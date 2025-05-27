import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../imports.dart';

part 'speedrun.g.dart';

@riverpod
SpeedrunApiBase speedrunApi(Ref ref) {
  final networkService = ref.watch(dioNetworkServiceProvider);
  return SpeedrunApi(networkService);
}

@riverpod
Future<(int count, List<Speedrun> speedruns)> fetchCompetitorSpeedruns(Ref ref,
    {required String competitorId,
    required String sortBy,
    required String sortDir,
    required int page,
    required int limit,
    bool? approved,
    Map<String, dynamic>? queryParam}) async {
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
Future<(int count, List<Speedrun> speedruns, List<CharUsageLbDisplay> charSnapshots)> fetchSpeedrun(Ref ref,
    {required String sortBy,
    required String sortDir,
    required int page,
    required int limit,
    bool? approved,
    Map<String, dynamic>? queryParam}) async {
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
Future<(int count, List<Speedrun> speedruns)> fetchSpeedrunAgent(Ref ref,
    {required String sortBy,
    required String sortDir,
    required int page,
    required int limit,
    bool? approved,
    Map<String, dynamic>? queryParam}) async {
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

@riverpod
Future<SpeedrunSubmitResponse> submitSpeedrun(Ref ref, SpeedrunSubmit submission) async {
  final speedrunApi = ref.watch(speedrunApiProvider);
  final cancelToken = await ref.cancelToken();
  final result = await speedrunApi.submitSpeedrun(
    submission: submission,
    cancelToken: cancelToken,
  );
  return result.fold(
    (failure) => throw failure,
    (success) => success,
  );
}
