import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../imports.dart';

part 'speedrun.g.dart';

@riverpod
SpeedrunApiBase speedrunApi(Ref ref) {
  final networkService = ref.watch(dioNetworkServiceProvider);
  return SpeedrunApi(networkService);
}

@riverpod
Future<List<Speedrun>> fetchCompetitorSpeedruns(
    Ref ref, String competitorId, String sortBy, String sortDir, int page, int limit,
    {bool? approved, Map<String, dynamic>? queryParam}) async {
  final cancelToken = await ref.cancelToken();
  final result = await ref.watch(speedrunApiProvider).fetchCompetitorSpeedruns(
        competitorId,
        sortBy,
        sortDir,
        page,
        limit,
        approved: approved,
        queryParam: queryParam,
        cancelToken: cancelToken,
      );
  return result.fold(
    (failure) => throw failure,
    (success) => success,
  );
}

@riverpod
Future<List<Speedrun>> fetchSpeedrun(Ref ref, String sortBy, String sortDir, int page, int limit,
    {bool? approved, Map<String, dynamic>? queryParam}) async {
  final speedrunApi = ref.watch(speedrunApiProvider);
  final cancelToken = await ref.cancelToken();
  final result = await speedrunApi.fetchSpeedrun(
    sortBy,
    sortDir,
    page,
    limit,
    approved: approved,
    queryParam: queryParam,
    cancelToken: cancelToken,
  );
  return result.fold(
    (failure) => throw failure,
    (success) => success,
  );
}

@riverpod
Future<List<Speedrun>> fetchSpeedrunAgent(Ref ref, String sortBy, String sortDir, int page, int limit,
    {bool? approved, Map<String, dynamic>? queryParam}) async {
  final speedrunApi = ref.watch(speedrunApiProvider);
  final cancelToken = await ref.cancelToken();
  final result = await speedrunApi.fetchSpeedrunAgent(
    sortBy,
    sortDir,
    page,
    limit,
    approved: approved,
    queryParam: queryParam,
    cancelToken: cancelToken,
  );
  return result.fold(
    (failure) => throw failure,
    (success) => success,
  );
}
