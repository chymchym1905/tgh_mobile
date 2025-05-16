import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../imports.dart';

part 'standings.g.dart';

@riverpod
StandingsApiBase standingsApi(Ref ref) {
  final networkService = ref.watch(dioNetworkServiceProvider);
  return StandingsApi(networkService);
}

@riverpod
Future<SpeedrunLeaderboardBoard> fetchSpeedrunLeaderboard(Ref ref, String abyssVersion) async {
  final cancelToken = await ref.cancelToken();
  final result = await ref.watch(standingsApiProvider).fetchSpeedrunLeaderboard(abyssVersion, cancelToken: cancelToken);
  return result.fold(
    (failure) => throw failure,
    (success) => success,
  );
}

@riverpod
Future<(List<SpeedrunLbSpot> spots, List<CharUsageLbDisplay> charUsages)> fetchSpeedrunLeaderboardSpots(
    Ref ref, String instanceId,
    {required int page, int daysElapse = 1, required String sortBy, required String sortDir}) async {
  final cancelToken = await ref.cancelToken();
  final result = await ref.watch(standingsApiProvider).fetchSpeedrunLeaderboardSpots(
        instanceId,
        page: page,
        daysElapse: daysElapse,
        sortBy: sortBy,
        sortDir: sortDir,
        cancelToken: cancelToken,
      );
  return result.fold(
    (failure) => throw failure,
    (success) => success,
  );
}
