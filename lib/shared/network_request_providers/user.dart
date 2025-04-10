import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../imports.dart';

part 'user.g.dart';

@riverpod
UserApiBase userApi(Ref ref) {
  final networkService = ref.watch(dioNetworkServiceProvider);
  return UserApi(networkService);
}

@riverpod
Future<User> createCompetitor(Ref ref, Map<String, dynamic> data) async {
  final cancelToken = await ref.cancelToken();
  final result = await ref.watch(userApiProvider).createCompetitor(
        data,
        cancelToken: cancelToken,
      );
  return result.fold(
    (failure) => throw failure,
    (success) => success,
  );
}

@riverpod
Future<User?> updateCompetitorForCurrentUser(Ref ref, Map<String, dynamic> updatedInfo) async {
  final cancelToken = await ref.cancelToken();
  final result = await ref.watch(userApiProvider).updateCompetitorForCurrentUser(
        updatedInfo,
        cancelToken: cancelToken,
      );
  return result.fold(
    (failure) => throw failure,
    (success) => success,
  );
}

@riverpod
Future<void> unsetCompetitor(Ref ref) async {
  final cancelToken = await ref.cancelToken();
  final result = await ref.watch(userApiProvider).unsetCompetitor(
        cancelToken: cancelToken,
      );
  return result.fold(
    (failure) => throw failure,
    (success) => success,
  );
}
