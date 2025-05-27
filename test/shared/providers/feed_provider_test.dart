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
  group('FeedProvider Tests', () {
    late ProviderContainer container;

    setUp(() async {
      WidgetsFlutterBinding.ensureInitialized();
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      container = createContainer(
        overrides: [
          sharedPrefInstanceProvider.overrideWithValue(prefs),
          dioNetworkServiceProvider.overrideWithValue(DioNetworkService(Dio(), AppConfig.apiUrl)),
        ],
      );
    });

    test('fetchFeed returns valid feed entries', () async {
      final states = List<AsyncValue<FeedState>>.empty(growable: true);
      final subscription = container.listen(
        feedNotifierProvider,
        (previous, next) => states.add(next),
        fireImmediately: true,
      );

      final feeds = await container.read(feedNotifierProvider.notifier).fetchFeed({});
      subscription.close();

      log(states.toString());
      expect(feeds, isA<List<Feed>>());
      expect(feeds, isNotEmpty);

      for (final feed in feeds) {
        switch (feed) {
          case SpeedrunFeed():
            expect(feed.speedrunCategory, isNotNull);
          case DPSFeed():
            expect(feed.dpsCategory, isNotNull);
        }
      }
    });

    test('fetchSpeedrunFeed returns valid speedrun entries', () async {
      final states = List<AsyncValue<FeedState>>.empty(growable: true);
      final subscription = container.listen(
        feedNotifierProvider,
        (previous, next) => states.add(next),
        fireImmediately: true,
      );
      final feeds = await container.read(feedNotifierProvider.notifier).fetchSpeedrunFeed({});

      subscription.close();

      log(states.toString());
      expect(feeds, isA<List<Feed>>());
      expect(feeds, isNotEmpty);

      for (final feed in feeds) {
        expect(feed, isA<SpeedrunFeed>());
        final speedrunFeed = feed as SpeedrunFeed;
        expect(speedrunFeed.speedrunCategory, isNotNull);
      }
    });

    test('fetchDPSFeed returns valid dps entries', () async {
      final states = List<AsyncValue<FeedState>>.empty(growable: true);
      final subscription = container.listen(
        feedNotifierProvider,
        (previous, next) => states.add(next),
        fireImmediately: true,
      );
      final feeds = await container.read(feedNotifierProvider.notifier).fetchDPSFeed({});
      subscription.close();

      log(states.toString());
      expect(feeds, isA<List<Feed>>());
      expect(feeds, isNotEmpty);

      for (final feed in feeds) {
        expect(feed, isA<DPSFeed>());
        final dpsFeed = feed as DPSFeed;
        expect(dpsFeed.dpsCategory, isNotNull);
      }
    });
  });
}
