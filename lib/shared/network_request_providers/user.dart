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

@riverpod
Future<(User user, UserProfileInfo accountInfo)> fetchPublicAccountInfo(Ref ref, String competitorId) async {
  final cancelToken = await ref.cancelToken();
  final result = await ref.watch(userApiProvider).fetchPublicAccountInfo(competitorId, cancelToken: cancelToken);
  return result.fold(
    (failure) => throw failure,
    (success) => success,
  );
}

@riverpod
Future<UserProfileInfo> fetchAccountInfo(Ref ref, String userId) async {
  final cancelToken = await ref.cancelToken();
  final result = await ref.watch(userApiProvider).fetchAccountInfo(userId, cancelToken: cancelToken);
  return result.fold(
    (failure) => throw failure,
    (success) => success,
  );
}

@riverpod
Future<List<User>> searchUsers(
  Ref ref,
  String query, {
  bool? verified = true,
  String? sortBy = 'name',
  String? sortDir = 'asc',
}) async {
  final cancelToken = await ref.cancelToken();
  final result = await ref.watch(userApiProvider).searchUsers(query,
      queryParameters: {
        'verified': verified ?? true,
        'sortBy': sortBy ?? 'name',
        'sortDir': sortDir ?? 'asc',
      },
      cancelToken: cancelToken);
  return result.fold(
    (failure) => throw failure,
    (success) => success,
  );
}
