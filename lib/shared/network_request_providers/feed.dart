import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tgh_mobile/imports.dart';
import 'package:tgh_mobile/shared/network.dart';

part 'feed.g.dart';

// final feedApiProvider = Provider<FeedApiBase>((ref) {
//   final networkService = ref.watch(dioNetworkServiceProvider);
//   return FeedApi(networkService);
// });
@riverpod
FeedApiBase feedApi(Ref ref) {
  final networkService = ref.watch(dioNetworkServiceProvider);
  return FeedApi(networkService);
}

@riverpod
class FeedNotifier extends _$FeedNotifier {
  late final NetworkService _networkService = ref.watch(dioNetworkServiceProvider);
  late final FeedApiBase _feedApi = FeedApi(_networkService);
  FeedStateLoaded _stateStore = const FeedStateLoaded([], []);

  @override
  Future<FeedState> build() async {
    _stateStore = const FeedStateLoaded([], []);
    return const FeedStateLoaded([], []);
  }

  Future<List<Feed>> fetchFeed(Map<String, dynamic> param) async {
    state = const AsyncData(FeedStateLoading());
    final cancelToken = await ref.cancelToken();
    final result = await _feedApi.fetchFeed(param, cancelToken: cancelToken);
    return result.fold((l) {
      state = AsyncError(l, StackTrace.current);
      throw l;
    }, (r) {
      appendFeed(r);
      return r;
    });
  }

  Future<List<Feed>> fetchSpeedrunFeed(Map<String, dynamic> param) async {
    state = const AsyncData(FeedStateLoading());
    final cancelToken = await ref.cancelToken();
    final result = await _feedApi.fetchSpeedrunFeed(param, cancelToken: cancelToken);
    return result.fold((l) {
      state = AsyncError(l, StackTrace.current);
      throw l;
    }, (r) {
      appendFeed(r);
      return r;
    });
  }

  Future<List<Feed>> fetchDPSFeed(Map<String, dynamic> param) async {
    state = const AsyncData(FeedStateLoading());
    final cancelToken = await ref.cancelToken();
    final result = await _feedApi.fetchDPSFeed(param, cancelToken: cancelToken);
    return result.fold((l) {
      state = AsyncError(l, StackTrace.current);
      throw l;
    }, (r) {
      appendFeed(r);
      return r;
    });
  }

  void appendFeed(List<Feed> feed) {
    final currFeedList = _stateStore.feedLists;
    final currPage = _stateStore.pages;
    _stateStore = FeedStateLoaded(currFeedList + [feed], currPage.isEmpty ? [1] : currPage + [currPage.last + 1]);
    state = AsyncData(_stateStore);
  }

  void clearFeed() {
    state = const AsyncData(FeedStateLoaded([], []));
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

@riverpod
Future<Feed> fetchFeedById(Ref ref, String id) async {
  final cancelToken = await ref.cancelToken();
  final result = await ref.watch(feedApiProvider).fetchFeedById(id, cancelToken: cancelToken);
  return result.fold((l) => throw l, (r) => r);
}
