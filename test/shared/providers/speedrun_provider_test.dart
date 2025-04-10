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
      final states = List<AsyncValue<List<Speedrun>>>.empty(growable: true);
      final provider = fetchCompetitorSpeedrunsProvider(
        '621336b43e8e7f7628dce587',
        'created_at',
        'desc',
        0,
        10,
        approved: true,
      );
      final subscription = container.listen(
        provider,
        (previous, next) => states.add(next),
        fireImmediately: true,
      );

      // Wait for the first data emission
      await container.read(provider.future);
      subscription.close();

      final speedruns = states.last.value;
      log(states.toString());
      expect(speedruns, isNotNull);
      expect(speedruns, isA<List<Speedrun>>());

      for (final speedrun in speedruns!) {
        expect(speedrun.id, isNotEmpty);
        expect(speedrun.competitor.alias, equals('chymchym1905'));
        log('Speedrun ID: ${speedrun.id}');
        log('Video: ${speedrun.videolink}');
      }
    });

    test('fetchSpeedrun returns paginated speedruns', () async {
      final states = List<AsyncValue<List<Speedrun>>>.empty(growable: true);
      final provider = fetchSpeedrunProvider(
        'created_at',
        'desc',
        0,
        5,
        approved: true,
      );
      final subscription = container.listen(
        provider,
        (previous, next) => states.add(next),
        fireImmediately: true,
      );

      // Wait for the first data emission
      await container.read(provider.future);
      subscription.close();

      final speedruns = states.last.value;
      log(states.toString());
      expect(speedruns, isNotNull);
      expect(speedruns, isA<List<Speedrun>>());
      expect(speedruns!.length, lessThanOrEqualTo(5));

      for (final speedrun in speedruns) {
        expect(speedrun.approved, isTrue);
        log('Speedrun ID: ${speedrun.id}');
        log('Created at: ${speedrun.createdAt}');
        log('Video: ${speedrun.videolink}');
      }
    });

    test('fetchSpeedrunAgent returns agent speedruns', () async {
      // First ensure we have a valid auth token
      final authStates = List<AsyncValue<AuthState>>.empty(growable: true);
      final authStateSubscription = container.listen(authNotifierProvider, (previous, next) => authStates.add(next));
      await container
          .read(authNotifierProvider.notifier)
          .login('leyeuttoteuhau-8698@yopmail.com', 'SecurePassword123\\');
      log(authStates.toString());
      expect(authStates.last.value, isA<AuthStateAuthenticated>());
      authStateSubscription.close();

      // Now test the speedrun agent provider
      final states = List<AsyncValue<List<Speedrun>>>.empty(growable: true);
      final provider = fetchSpeedrunAgentProvider(
        'created_at',
        'desc',
        0,
        10,
        approved: false,
        queryParam: {'speedrun_category': 'Abyss'},
      );
      final subscription = container.listen(
        provider,
        (previous, next) => states.add(next),
        fireImmediately: true,
      );

      // Wait for the first data emission
      await container.read(provider.future);
      subscription.close();

      final speedruns = states.last.value;
      log(states.toString());
      expect(speedruns, isNotNull);
      expect(speedruns, isA<List<Speedrun>>());

      for (final speedrun in speedruns!) {
        expect(speedrun.id, isNotEmpty);
        expect(speedrun.speedrunCategory, equals('Abyss'));
        log('Agent Speedrun ID: ${speedrun.id}');
        log('Category: ${speedrun.speedrunCategory}');
        log('Video: ${speedrun.videolink}');
      }
    });
  });
}
