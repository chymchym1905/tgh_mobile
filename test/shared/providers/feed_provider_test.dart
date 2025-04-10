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
          dioNetworkServiceProvider.overrideWithValue(DioNetworkService(Dio())),
        ],
      );
    });

    test('fetchFeed returns valid feed entries', () async {
      final states = <AsyncValue<List<Feed>>>[];
      final provider = fetchFeedProvider({});
      final subscription = container.listen(
        provider,
        (previous, next) => states.add(next),
        fireImmediately: true,
      );

      final feeds = await container.read(provider.future);
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
        expect(feed.videoMetadata, isNotNull);
      }
    });

    test('fetchSpeedrunFeed returns valid speedrun entries', () async {
      final states = <AsyncValue<List<Feed>>>[];
      final provider = fetchSpeedrunFeedProvider({'characters': 'Mavuika,Xilonen'});
      final subscription = container.listen(
        provider,
        (previous, next) => states.add(next),
        fireImmediately: true,
      );

      final feeds = await container.read(provider.future);
      subscription.close();

      log(states.toString());
      expect(feeds, isA<List<Feed>>());
      expect(feeds, isNotEmpty);

      for (final feed in feeds) {
        expect(feed, isA<SpeedrunFeed>());
        final speedrunFeed = feed as SpeedrunFeed;
        expect(speedrunFeed.speedrunCategory, isNotNull);
        expect(speedrunFeed.videoMetadata, isNotNull);
      }
    });

    test('fetchDPSFeed returns valid dps entries', () async {
      final states = <AsyncValue<List<Feed>>>[];
      final provider = fetchDPSFeedProvider({'dps_character': 'Mavuika'});
      final subscription = container.listen(
        provider,
        (previous, next) => states.add(next),
        fireImmediately: true,
      );

      final feeds = await container.read(provider.future);
      subscription.close();

      log(states.toString());
      expect(feeds, isA<List<Feed>>());
      expect(feeds, isNotEmpty);

      for (final feed in feeds) {
        expect(feed, isA<DPSFeed>());
        final dpsFeed = feed as DPSFeed;
        expect(dpsFeed.dpsCategory, isNotNull);
        expect(dpsFeed.videoMetadata, isNotNull);
      }
    });
  });
}
