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
          dioNetworkServiceProvider.overrideWithValue(DioNetworkService(Dio(), AppConfig.apiUrl)),
        ],
      );
    });

    test('fetchCompetitorSpeedruns returns valid speedruns', () async {
      final states = List<AsyncValue<(int count, List<Speedrun> speedruns)>>.empty(growable: true);
      final provider = fetchCompetitorSpeedrunsProvider(
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

      // Wait for the first data emission
      await container.read(provider.future);
      subscription.close();

      final data = states.last.value;
      log(states.toString());
      expect(data, isNotNull);
      expect(data, isA<(int count, List<Speedrun> speedruns)>());

      for (final speedrun in data!.$2) {
        expect(speedrun.id, isNotEmpty);
        expect(speedrun.competitor.alias, equals('chymchym1905'));
        log('Speedrun ID: ${speedrun.id}');
        log('Video: ${speedrun.videolink}');
      }
    });

    test('fetchSpeedrun returns paginated speedruns', () async {
      final states = List<AsyncValue<(int count, List<Speedrun> speedruns, List<CharUsageLbDisplay> charUsage)>>.empty(
          growable: true);
      final provider = fetchSpeedrunProvider(
        sortBy: 'created_at',
        sortDir: 'desc',
        page: 0,
        limit: 5,
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

      final data = states.last.value;
      log(states.toString());
      expect(data, isNotNull);
      expect(data, isA<(int count, List<Speedrun> speedruns, List<CharUsageLbDisplay> charUsage)>());

      for (final speedrun in data!.$2) {
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
      final states = List<AsyncValue<(int count, List<Speedrun> speedruns)>>.empty(growable: true);
      final provider = fetchSpeedrunAgentProvider(
        sortBy: 'created_at',
        sortDir: 'desc',
        page: 0,
        limit: 10,
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

      final data = states.last.value;
      log(states.toString());
      expect(data, isNotNull);
      expect(data, isA<(int count, List<Speedrun> speedruns)>());

      for (final speedrun in data!.$2) {
        expect(speedrun.id, isNotEmpty);
        expect(speedrun.speedrunCategory, equals('Abyss'));
        log('Agent Speedrun ID: ${speedrun.id}');
        log('Category: ${speedrun.speedrunCategory}');
        log('Video: ${speedrun.videolink}');
      }
    });

    // test('submitSpeedrun returns valid speedrun', () async {
    //   // First ensure we have a valid auth token
    //   final authStates = List<AsyncValue<AuthState>>.empty(growable: true);
    //   final authStateSubscription = container.listen(authNotifierProvider, (previous, next) => authStates.add(next));
    //   await container
    //       .read(authNotifierProvider.notifier)
    //       .login('leyeuttoteuhau-8698@yopmail.com', 'SecurePassword123\\');
    //   final competitor = authStates.last.value?.map(
    //     authenticated: (authenticated) => authenticated.user.competitor,
    //     error: (error) => null,
    //     loggedOut: (loggedOut) => null,
    //   );
    //   log(authStates.toString());
    //   expect(authStates.last.value, isA<AuthStateAuthenticated>());
    //   authStateSubscription.close();

    //   // Now test the speedrun agent provider
    //   final states = List<AsyncValue<SpeedrunSubmitResponse>>.empty(growable: true);
    //   final provider = submitSpeedrunProvider(SpeedrunSubmit(
    //       accountUid: competitor!.uid.toString(),
    //       alias: competitor.alias,
    //       discordTag: competitor.discordtag!,
    //       gameVersion: '5.6',
    //       abyssVersion: ABYSS_VERSION_HISTORY.last,
    //       notes: 'Test notes',
    //       region: 'America',
    //       speedrunCategory: 'Abyss',
    //       speedrunSubcategory: '12-3-1',
    //       videolink: 'https://www.youtube.com/watch?v=ljAZomFegHk',
    //       deletedAt: DateTime.now().subtract(const Duration(days: 29, hours: 23, minutes: 57))));
    //   final subscription = container.listen(
    //     provider,
    //     (previous, next) => states.add(next),
    //     fireImmediately: true,
    //   );

    //   // Wait for the first data emission
    //   await container.read(provider.future);
    //   subscription.close();

    //   final speedrun = states.last.value;
    //   log(states.toString());
    //   expect(speedrun, isNotNull);
    //   expect(speedrun, isA<SpeedrunSubmitResponse>());

    //   expect(speedrun?.id, isNotEmpty);
    //   expect(speedrun?.speedrunCategory, equals('Abyss'));
    //   log('Account Snapshot: ${speedrun?.accountSnapshot}');
    //   log('Category: ${speedrun?.speedrunCategory}');
    //   log('Video: ${speedrun?.videolink}');
    // });
  });
}
