import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../imports.dart';

part 'competitor.g.dart';

@riverpod
CompetitorApiBase competitorApi(Ref ref) {
  final networkService = ref.watch(dioNetworkServiceProvider);
  return CompetitorApi(networkService);
}

@riverpod
Future<Competitor?> updateCompetitorInfo(Ref ref, Map<String, dynamic> updatedInfo) async {
  final cancelToken = await ref.cancelToken();
  final result = await ref.watch(competitorApiProvider).updateCompetitorInfo(
        updatedInfo,
        cancelToken: cancelToken,
      );
  return result.fold(
    (failure) => throw failure,
    (success) => success,
  );
}

@riverpod
Future<Competitor> getCompetitorByAlias(Ref ref, String alias) async {
  final cancelToken = await ref.cancelToken();
  final result = await ref.watch(competitorApiProvider).getCompetitorByAlias(
        alias,
        cancelToken: cancelToken,
      );
  return result.fold(
    (failure) => throw failure,
    (success) => success,
  );
}
