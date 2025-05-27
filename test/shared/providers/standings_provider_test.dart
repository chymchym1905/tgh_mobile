import 'dart:developer';

import 'package:collection/collection.dart';
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
  group('StandingsProvider Tests', () {
    late ProviderContainer container;
    String boardId = '';

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

    test('fetchSpeedrunLeaderboard returns valid leaderboard', () async {
      final states = List<AsyncValue<SpeedrunLeaderboardBoard>>.empty(growable: true);
      final provider = fetchSpeedrunLeaderboardProvider('3.7');
      final subscription = container.listen(
        provider,
        (previous, next) => states.add(next),
        fireImmediately: true,
      );

      final leaderboard = await container.read(provider.future);
      subscription.close();
      log(states.toString());
      expect(leaderboard, isA<SpeedrunLeaderboardBoard>());
      boardId = leaderboard.instanceId;
      log('Board ID: $boardId', name: 'Leaderboard ID');
    });

    test('fetchSpeedrunLeaderboardSpots returns valid leaderboard spots', () async {
      final states =
          List<AsyncValue<(List<SpeedrunLbSpot> spots, List<CharUsageLbDisplay> charUsages)>>.empty(growable: true);
      final provider = fetchSpeedrunLeaderboardSpotsProvider(
        boardId,
        page: 0,
        sortBy: 'rank',
        sortDir: 'asc',
      );
      final subscription = container.listen(
        provider,
        (previous, next) => states.add(next),
        fireImmediately: true,
      );

      final spots = await container.read(provider.future);
      subscription.close();
      expect(spots, isA<(List<SpeedrunLbSpot> spots, List<CharUsageLbDisplay> charUsages)>());
      log('First rank: ${spots.$1[0].alias}');
      final charUsageFirstRank =
          spots.$2.firstWhereOrNull((element) => element.competitorId == spots.$1[0].competitor.id);
      log('Char usage first rank: $charUsageFirstRank');
      log(spots.$1.toString());
    });
  });
}
