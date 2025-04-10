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
      final states = <AsyncValue<List<DPS>>>[];
      final provider = fetchCompetitorDpsProvider(
        competitorId: '621336b43e8e7f7628dce587',
        sortBy: 'created_at',
        sortDir: 'desc',
        page: 0,
        limit: 10,
        approved: true,
      );
      final subscription = container.listen(
        provider,
        (previous, next) => states.add(next),
        fireImmediately: true,
      );

      final dpsEntries = await container.read(provider.future);
      subscription.close();

      log(states.toString());
      expect(dpsEntries, isA<List<DPS>>());
      expect(dpsEntries, isNotEmpty);

      for (final dps in dpsEntries) {
        expect(dps.id, isNotEmpty);
        expect(dps.competitor.alias, equals('chymchym1905'));
        expect(dps.enemy, isNotNull);
        expect(dps.videolink, isNotNull);
      }
    });

    test('fetchDps returns paginated dps entries', () async {
      final states = <AsyncValue<List<DPS>>>[];
      final provider = fetchDpsProvider(
        sortBy: 'created_at',
        sortDir: 'desc',
        page: 0,
        limit: 5,
        approved: true,
        queryParam: {'dps_category': 'Overworld'},
      );
      final subscription = container.listen(
        provider,
        (previous, next) => states.add(next),
        fireImmediately: true,
      );

      final dpsEntries = await container.read(provider.future);
      subscription.close();

      log(states.toString());
      expect(dpsEntries, isA<List<DPS>>());
      expect(dpsEntries.length, lessThanOrEqualTo(5));

      for (final dps in dpsEntries) {
        expect(dps.approved, isTrue);
        expect(dps.id, isNotEmpty);
        expect(dps.createdAt, isNotNull);
        expect(dps.enemy, isNotNull);
        expect(dps.videolink, isNotNull);
      }
    });

    test('fetchDpsAgent returns agent dps entries', () async {
      // First ensure we have a valid auth token
      final authNotifier = container.read(authNotifierProvider.notifier);
      await authNotifier.login('leyeuttoteuhau-8698@yopmail.com', 'SecurePassword123\\');
      final authState = await container.read(authNotifierProvider.future);
      expect(authState, isA<AuthStateAuthenticated>());

      final states = <AsyncValue<List<DPS>>>[];
      final provider = fetchDpsAgentProvider(
        sortBy: 'created_at',
        sortDir: 'desc',
        page: 0,
        limit: 10,
        approved: true,
        queryParam: {'dps_category': 'Weekly Boss'},
      );
      final subscription = container.listen(
        provider,
        (previous, next) => states.add(next),
        fireImmediately: true,
      );

      final dpsEntries = await container.read(provider.future);
      subscription.close();

      log(states.toString());
      expect(dpsEntries, isA<List<DPS>>());
      expect(dpsEntries, isNotEmpty);

      for (final dps in dpsEntries) {
        expect(dps.id, isNotEmpty);
        expect(dps.dpsCategory, isNotNull);
        expect(dps.enemy, isNotNull);
        expect(dps.videolink, isNotNull);
      }
    });
  });
}
