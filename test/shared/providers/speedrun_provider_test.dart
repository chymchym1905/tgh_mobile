import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';
import 'package:tgh_mobile/imports.dart';
import 'package:tgh_mobile/shared/network.dart';

ProviderContainer createContainer({
  ProviderContainer? parent,
  List<Override> overrides = const [],
  List<ProviderObserver>? observers,
}) {
  // Create a ProviderContainer, and optionally allow specifying parameters.
  final container = ProviderContainer(
    parent: parent,
    overrides: overrides,
    observers: observers,
  );

  // When the test ends, dispose the container.
  addTearDown(container.dispose);

  return container;
}

void main() {
  group('SpeedrunProvider Tests', () {
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

    test('fetchCompetitorSpeedruns returns valid speedruns', () async {
      final api = container.read(speedrunApiProvider);
      final result = await api.fetchCompetitorSpeedruns(
        '621336b43e8e7f7628dce587',
        'created_at',
        'desc',
        0,
        10,
        approved: true,
      );

      result.fold(
        (failure) => fail('API call failed: ${failure.toString()}'),
        (speedruns) {
          expect(speedruns, isNotNull);
          for (final speedrun in speedruns) {
            expect(speedrun.id, isNotEmpty);
            expect(speedrun.competitor.alias, equals('chymchym1905'));
            log('Speedrun ID: ${speedrun.id}');
            log('Video: ${speedrun.videolink}');
          }
        },
      );
    });

    test('fetchSpeedrun returns paginated speedruns', () async {
      final api = container.read(speedrunApiProvider);
      final result = await api.fetchSpeedrun(
        'created_at',
        'desc',
        0,
        5,
        approved: true,
      );

      result.fold(
        (failure) => fail('API call failed: ${failure.toString()}'),
        (speedruns) {
          expect(speedruns.length, lessThanOrEqualTo(5));
          for (final speedrun in speedruns) {
            expect(speedrun.approved, isTrue);
            log('Speedrun ID: ${speedrun.id}');
            log('Created at: ${speedrun.createdAt}');
            log('Video: ${speedrun.videolink}');
          }
        },
      );
    });

    test('fetchSpeedrunAgent returns agent speedruns', () async {
      // First ensure we have a valid auth token
      final authNotifier = container.read(authNotifierProvider.notifier);
      // Wait for the auth state to be authenticated

      await authNotifier.login('leyeuttoteuhau-8698@yopmail.com', 'SecurePassword123\\');
      final authState = await container.read(authNotifierProvider.future);
      expect(authState, isA<AuthStateAuthenticated>());

      // Now the dioNetworkService should have the auth token
      final api = container.read(speedrunApiProvider);
      final result = await api.fetchSpeedrunAgent(
        'created_at',
        'desc',
        0,
        10,
        approved: true,
        queryParam: {'speedrun_category': 'Abyss'},
      );

      result.fold(
        (failure) => fail('API call failed: ${failure.toString()}'),
        (speedruns) {
          expect(speedruns, isNotNull);
          for (final speedrun in speedruns) {
            expect(speedrun.id, isNotEmpty);
            expect(speedrun.speedrunCategory, equals('Abyss'));
            log('Agent Speedrun ID: ${speedrun.id}');
            log('Category: ${speedrun.speedrunCategory}');
            log('Video: ${speedrun.videolink}');
          }
        },
      );
    });
  });
}
