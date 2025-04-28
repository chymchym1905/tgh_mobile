import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../imports.dart';

part 'user.g.dart';

@riverpod
UserApiBase userApi(Ref ref) {
  final networkService = ref.watch(dioNetworkServiceProvider);
  return UserApi(networkService);
}

@riverpod
Future<User> register(Ref ref, String userName, String email, String password) async {
  final cancelToken = await ref.cancelToken();
  final result = await ref.watch(userApiProvider).register(userName, email, password, cancelToken: cancelToken);
  return result.fold(
    (failure) => throw failure,
    (success) => success,
  );
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

@riverpod
Future<User> getName(Ref ref, String username) async {
  final cancelToken = await ref.cancelToken();
  final result = await ref.watch(userApiProvider).getName(
        username,
        cancelToken: cancelToken,
      );
  return result.fold(
    (failure) => throw failure,
    (success) => success,
  );
}

@riverpod
Future<User> getEmail(Ref ref, String email) async {
  final cancelToken = await ref.cancelToken();
  final result = await ref.watch(userApiProvider).getEmail(
        email,
        cancelToken: cancelToken,
      );
  return result.fold(
    (failure) => throw failure,
    (success) => success,
  );
}

@riverpod
Future<void> resendVerificationEmail(Ref ref, String email) async {
  final cancelToken = await ref.cancelToken();
  final result = await ref.watch(userApiProvider).resendVerificationEmail(email, cancelToken: cancelToken);
  return result.fold(
    (failure) => throw failure,
    (success) => success,
  );
}
