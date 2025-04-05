import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';
import 'package:tgh_mobile/imports.dart';
import 'package:tgh_mobile/shared/network.dart';

ProviderContainer createContainer({
  ProviderContainer? parent,
  List<Override> overrides = const [],
  List<ProviderObserver>? observers,
}) {
  final container = ProviderContainer(
    parent: parent,
    overrides: overrides,
    observers: observers,
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  group('DpsProvider Tests', () {
    late ProviderContainer container;

    setUp(() async {
      WidgetsFlutterBinding.ensureInitialized();
      // Must have line to run test
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      container = createContainer(
        overrides: [
          sharedPrefInstanceProvider.overrideWithValue(prefs),
          dioNetworkServiceProvider.overrideWithValue(DioNetworkService(Dio())),
        ],
      );
    });

    test('fetchCompetitorDps returns valid dps entries', () async {
      final api = container.read(dpsApiProvider);
      final result = await api.fetchCompetitorDps(
        '621336b43e8e7f7628dce587',
        'created_at',
        'desc',
        0,
        10,
        approved: true,
      );

      result.fold(
        (failure) => fail('API call failed: ${failure.toString()}'),
        (dpsEntries) {
          expect(dpsEntries, isNotNull);
          for (final dps in dpsEntries) {
            expect(dps.id, isNotEmpty);
            expect(dps.competitor.alias, equals('chymchym1905'));
            log('DPS ID: ${dps.id}');
            log('Enenmy: ${dps.enemy}');
            log('Video: ${dps.videolink}');
          }
        },
      );
    });

    test('fetchDps returns paginated dps entries', () async {
      final api = container.read(dpsApiProvider);
      final result = await api.fetchDps(
        'created_at',
        'desc',
        0,
        5,
        approved: true,
        queryParam: {'dps_category': 'Overworld'},
      );

      result.fold(
        (failure) => fail('API call failed: ${failure.toString()}'),
        (dpsEntries) {
          expect(dpsEntries.length, lessThanOrEqualTo(5));
          for (final dps in dpsEntries) {
            expect(dps.approved, isTrue);
            log('DPS ID: ${dps.id}');
            log('Created at: ${dps.createdAt}');
            log('Enenmy: ${dps.enemy}');
            log('Video: ${dps.videolink}');
          }
        },
      );
    });

    test('fetchDpsAgent returns agent dps entries', () async {
      // First ensure we have a valid auth token
      final authNotifier = container.read(authNotifierProvider.notifier);
      // Wait for the auth state to be authenticated

      await authNotifier.login('leyeuttoteuhau-8698@yopmail.com', 'SecurePassword123\\');
      final authState = await container.read(authNotifierProvider.future);
      expect(authState, isA<AuthStateAuthenticated>());

      final api = container.read(dpsApiProvider);
      final result = await api.fetchDpsAgent(
        'created_at',
        'desc',
        0,
        10,
        approved: true,
        queryParam: {'dps_category': 'Weekly Boss'},
      );

      result.fold(
        (failure) => fail('API call failed: ${failure.toString()}'),
        (dpsEntries) {
          expect(dpsEntries, isNotNull);
          for (final dps in dpsEntries) {
            expect(dps.id, isNotEmpty);
            log('Agent DPS ID: ${dps.id}');
            log('Category: ${dps.dpsCategory}');
            log('Enenmy: ${dps.enemy}');
            log('Video: ${dps.videolink}');
          }
        },
      );
    });
  });
}
