import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tgh_mobile/imports.dart';

part 'feed.g.dart';

@riverpod
FeedApiBase feedApi(Ref ref) {
  final networkService = ref.watch(dioNetworkServiceProvider);
  return FeedApi(networkService);
}

@riverpod
Future<List<Feed>> fetchFeed(Ref ref, Map<String, dynamic> param) async {
  final cancelToken = await ref.cancelToken();
  final result = await ref.watch(feedApiProvider).fetchFeed(
        param,
        cancelToken: cancelToken,
      );
  return result.fold(
    (failure) => throw failure,
    (success) => success,
  );
}

@riverpod
Future<List<Feed>> fetchSpeedrunFeed(Ref ref, Map<String, dynamic> param) async {
  final cancelToken = await ref.cancelToken();
  final result = await ref.watch(feedApiProvider).fetchSpeedrunFeed(
        param,
        cancelToken: cancelToken,
      );
  return result.fold(
    (failure) => throw failure,
    (success) => success,
  );
}

@riverpod
Future<List<Feed>> fetchDPSFeed(Ref ref, Map<String, dynamic> param) async {
  final cancelToken = await ref.cancelToken();
  final result = await ref.watch(feedApiProvider).fetchDPSFeed(
        param,
        cancelToken: cancelToken,
      );
  return result.fold(
    (failure) => throw failure,
    (success) => success,
  );
}
