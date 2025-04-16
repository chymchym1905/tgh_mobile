import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tgh_mobile/imports.dart';
import 'package:tgh_mobile/shared/network.dart';

part 'feed.g.dart';

// @riverpod
// FeedApiBase feedApi(Ref ref) {
//   final networkService = ref.watch(dioNetworkServiceProvider);
//   ref.keepAlive();
//   return FeedApi(networkService);
// }

@riverpod
class FeedNotifier extends _$FeedNotifier {
  late final NetworkService _networkService;
  late final FeedApiBase _feedApi;

  @override
  FeedState build() {
    _networkService = ref.watch(dioNetworkServiceProvider);
    _feedApi = FeedApi(_networkService);
    return const FeedStateLoaded([], []);
  }

  Future<List<Feed>> fetchFeed(Map<String, dynamic> param) async {
    state = const FeedStateLoading();
    final cancelToken = await ref.cancelToken();
    final result = await _feedApi.fetchFeed(param, cancelToken: cancelToken);
    return result.fold((l) => throw l, (r) {
      state.map(
        loading: (s) => s = const FeedStateLoading(),
        loaded: (s) => s = FeedStateLoaded(s.feedLists + [r], s.pages + [1]),
        error: (s) => s = FeedStateError(s.exception),
      );
      return r;
    });
  }

  Future<List<Feed>> fetchSpeedrunFeed(Map<String, dynamic> param) async {
    state = const FeedStateLoading();
    final cancelToken = await ref.cancelToken();
    final result = await _feedApi.fetchSpeedrunFeed(param, cancelToken: cancelToken);
    return result.fold((l) => throw l, (r) {
      state.map(
        loading: (s) => s = const FeedStateLoading(),
        loaded: (s) => s = FeedStateLoaded(s.feedLists + [r], s.pages + [1]),
        error: (s) => s = FeedStateError(s.exception),
      );
      return r;
    });
  }

  Future<List<Feed>> fetchDPSFeed(Map<String, dynamic> param) async {
    state = const FeedStateLoading();
    final cancelToken = await ref.cancelToken();
    final result = await _feedApi.fetchDPSFeed(param, cancelToken: cancelToken);
    return result.fold((l) => throw l, (r) {
      state.map(
        loading: (s) => s = const FeedStateLoading(),
        loaded: (s) => s = FeedStateLoaded(s.feedLists + [r], s.pages + [1]),
        error: (s) => s = FeedStateError(s.exception),
      );
      return r;
    });
  }

  void clearFeed() {
    state = const FeedStateLoaded([], []);
  }
}

// @riverpod
// Future<List<Feed>> fetchFeed(Ref ref, Map<String, dynamic> param) async {
//   final cancelToken = await ref.cancelToken();
//   final result = await ref.watch(feedApiProvider).fetchFeed(
//         param,
//         cancelToken: cancelToken,
//       );
//   return result.fold(
//     (failure) => throw failure,
//     (success) => success,
//   );
// }

// @riverpod
// Future<List<Feed>> fetchSpeedrunFeed(Ref ref, Map<String, dynamic> param) async {
//   final cancelToken = await ref.cancelToken();
//   final result = await ref.watch(feedApiProvider).fetchSpeedrunFeed(
//         param,
//         cancelToken: cancelToken,
//       );
//   return result.fold(
//     (failure) => throw failure,
//     (success) => success,
//   );
// }

// @riverpod
// Future<List<Feed>> fetchDPSFeed(Ref ref, Map<String, dynamic> param) async {
//   final cancelToken = await ref.cancelToken();
//   final result = await ref.watch(feedApiProvider).fetchDPSFeed(
//         param,
//         cancelToken: cancelToken,
//       );
//   return result.fold(
//     (failure) => throw failure,
//     (success) => success,
//   );
// }
