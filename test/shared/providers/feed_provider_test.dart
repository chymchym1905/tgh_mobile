import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tgh_mobile/shared/network_request_providers/feed.dart';
import 'package:tgh_mobile/shared/data_model/feed/feed.dart';

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

    setUp(() {
      container = createContainer();
    });

    test('Target both speedrun and dps entries', () async {
      final api = container.read(feedApiProvider);
      final result = await api.fetchFeed({});

      result.fold(
        (failure) => fail('API call failed: ${failure.toString()}'),
        (feeds) {
          // Add your assertions here
          for (final feed in feeds) {
            switch (feed) {
              case SpeedrunFeed(:final speedrunCategory):
                expect(speedrunCategory, isNotNull);
              case DPSFeed(:final dpsCategory):
                expect(dpsCategory, isNotNull);
            }
            // expect(feed.videoMetadata, isNotNull);
            if (feed.videoMetadata != null) {
              log("Title: ${feed.videoMetadata?.title}");
              log("Thumbnail: ${feed.videoMetadata?.thumbnail}");
              log("Views: ${feed.videoMetadata?.views}");
              log("Duration: ${feed.videoMetadata?.duration}");
            }
          }
        },
      );
    });

    test('Target speedrun entries', () async {
      final api = container.read(feedApiProvider);
      final result = await api.fetchSpeedrunFeed({'characters': 'Mavuika,Xilonen'});

      result.fold(
        (failure) => fail('API call failed: ${failure.toString()}'),
        (feeds) {
          // Add your assertions here
          for (final feed in feeds) {
            switch (feed) {
              case SpeedrunFeed(:final speedrunCategory):
                expect(speedrunCategory, isNotNull);
              case DPSFeed(:final dpsCategory):
                expect(dpsCategory, isNotNull);
            }
            // expect(feed.videoMetadata, isNotNull);
            if (feed.videoMetadata != null) {
              log("Title: ${feed.videoMetadata?.title}");
              log("Thumbnail: ${feed.videoMetadata?.thumbnail}");
              log("Views: ${feed.videoMetadata?.views}");
              log("Duration: ${feed.videoMetadata?.duration}");
            }
          }
        },
      );
    });

    test('Target dps entries', () async {
      final api = container.read(feedApiProvider);
      final result = await api.fetchDPSFeed({'dps_character': 'Mavuika'});

      result.fold(
        (failure) => fail('API call failed: ${failure.toString()}'),
        (feeds) {
          // Add your assertions here
          for (final feed in feeds) {
            switch (feed) {
              case SpeedrunFeed(:final speedrunCategory):
                expect(speedrunCategory, isNotNull);
              case DPSFeed(:final dpsCategory):
                expect(dpsCategory, isNotNull);
            }
            // expect(feed.videoMetadata, isNotNull);
            if (feed.videoMetadata != null) {
              log("Title: ${feed.videoMetadata?.title}");
              log("Thumbnail: ${feed.videoMetadata?.thumbnail}");
              log("Views: ${feed.videoMetadata?.views}");
              log("Duration: ${feed.videoMetadata?.duration}");
            }
          }
        },
      );
    });
  });
}
