import 'package:fpdart/fpdart.dart';
import 'package:tgh_mobile/imports.dart';
import '../exception.dart';
import '../network.dart';

abstract class UserApiBase {
  Future<Either<AppException, User>> createCompetitor(Map<String, dynamic> data, {CancelToken? cancelToken});
  Future<Either<AppException, User?>> updateCompetitorForCurrentUser(Map<String, dynamic> updatedInfo,
      {CancelToken? cancelToken});
  Future<Either<AppException, void>> unsetCompetitor({CancelToken? cancelToken});
  Future<Either<AppException, User>> getName(String name, {CancelToken? cancelToken});
  Future<Either<AppException, User>> getEmail(String email, {CancelToken? cancelToken});
  Future<Either<AppException, User>> register(String name, String email, String password, {CancelToken? cancelToken});
  Future<Either<AppException, User>> resendVerificationEmail(String email, {CancelToken? cancelToken});
  Future<Either<AppException, UserProfileInfo>> fetchAccountInfo(String userId, {CancelToken? cancelToken});
  Future<Either<AppException, (User user, UserProfileInfo accountInfo)>> fetchPublicAccountInfo(String competitorId,
      {CancelToken? cancelToken});
  Future<Either<AppException, List<User>>> searchUsers(String query,
      {Map<String, dynamic>? queryParameters, CancelToken? cancelToken});
}

class UserApi implements UserApiBase {
  final NetworkService _networkService;

  UserApi(this._networkService);

  @override
  Future<Either<AppException, User>> createCompetitor(Map<String, dynamic> data, {CancelToken? cancelToken}) async {
    const url = '/users/create-competitor';
    final response = await _networkService.put(url, body: data, cancelToken: cancelToken);

    return response.fold(
      (exception) => left(exception),
      (response) {
        if (response.statusCode == 200 && (response.data as Map).containsKey('user')) {
          return right(User.fromJson(response.data['user'] as Map<String, dynamic>));
        } else {
          return left(AppException(
            message: response.data.toString(),
            code: response.statusCode.toString(),
          ));
        }
      },
    );
  }

  @override
  Future<Either<AppException, User?>> updateCompetitorForCurrentUser(Map<String, dynamic> updatedInfo,
      {CancelToken? cancelToken}) async {
    const url = '/users/update-current';
    final response = await _networkService.put(url, body: updatedInfo, cancelToken: cancelToken);

    return response.fold(
      (exception) => left(exception),
      (response) {
        if (response.statusCode == 200 && (response.data as Map).containsKey('user')) {
          return right(User.fromJson(response.data['user'] as Map<String, dynamic>));
        } else if (response.statusCode == 200) {
          return right(null);
        } else {
          return left(AppException(
            message: response.data.toString(),
            code: response.statusCode.toString(),
          ));
        }
      },
    );
  }

  @override
  Future<Either<AppException, void>> unsetCompetitor({CancelToken? cancelToken}) async {
    const url = '/users/unset-current';
    final response = await _networkService.put(url, body: {"field": "competitor"}, cancelToken: cancelToken);

    return response.fold(
      (exception) => left(exception),
      (response) {
        if (response.statusCode == 200) {
          return right(null);
        } else {
          return left(AppException(
            message: response.data.toString(),
            code: response.statusCode.toString(),
          ));
        }
      },
    );
  }

  @override
  Future<Either<AppException, User>> getName(String name, {CancelToken? cancelToken}) async {
    final url = '/users/get-name/$name';
    final response = await _networkService.get(url, cancelToken: cancelToken);

    return response.fold(
      (exception) => left(exception),
      (response) {
        if (response.statusCode == 200 && (response.data as Map).containsKey('user')) {
          return right(User.fromJson(response.data['user'] as Map<String, dynamic>));
        } else {
          return left(AppException(message: response.data.toString(), code: response.statusCode.toString()));
        }
      },
    );
  }

  @override
  Future<Either<AppException, User>> getEmail(String email, {CancelToken? cancelToken}) async {
    final url = '/users/get-email/$email';
    final response = await _networkService.get(url, cancelToken: cancelToken);

    return response.fold(
      (exception) => left(exception),
      (response) {
        if (response.statusCode == 200 && (response.data as Map).containsKey('user')) {
          return right(User.fromJson(response.data['user'] as Map<String, dynamic>));
        } else {
          return left(AppException(message: response.data.toString(), code: response.statusCode.toString()));
        }
      },
    );
  }

  @override
  Future<Either<AppException, User>> register(String name, String email, String password,
      {CancelToken? cancelToken}) async {
    const url = '/users/register';
    final response = await _networkService.post(url,
        body: {"name": name, "email": email, "password": password}, cancelToken: cancelToken);

    return response.fold(
      (exception) => left(exception),
      (response) {
        if (response.statusCode == 200) {
          return right(User.fromJson(response.data as Map<String, dynamic>));
        } else {
          return left(AppException(message: response.data.toString(), code: response.statusCode.toString()));
        }
      },
    );
  }

  @override
  Future<Either<AppException, User>> resendVerificationEmail(String email, {CancelToken? cancelToken}) async {
    const url = '/users/resend-verification-email';
    final response = await _networkService.post(url, body: {"email": email}, cancelToken: cancelToken);

    return response.fold(
      (exception) => left(exception),
      (response) {
        if (response.statusCode == 200 && (response.data as Map).containsKey('user')) {
          return right(User.fromJson(response.data['user'] as Map<String, dynamic>));
        } else {
          return left(AppException(message: response.data.toString(), code: response.statusCode.toString()));
        }
      },
    );
  }

  @override
  Future<Either<AppException, UserProfileInfo>> fetchAccountInfo(String userId, {CancelToken? cancelToken}) async {
    final url = '/users/$userId/account-info';
    final response =
        await _networkService.get(url, queryParameters: {'versions': ABYSS_VERSION_HISTORY}, cancelToken: cancelToken);

    return response.fold(
      (exception) => left(exception),
      (response) {
        if (response.statusCode == 200 && (response.data as Map).containsKey('userProfileInformation')) {
          return right(UserProfileInfo.fromJson(response.data['userProfileInformation'] as Map<String, dynamic>));
        } else {
          return left(AppException(message: response.data.toString(), code: response.statusCode.toString()));
        }
      },
    );
  }

  @override
  Future<Either<AppException, (User user, UserProfileInfo accountInfo)>> fetchPublicAccountInfo(String competitorId,
      {CancelToken? cancelToken}) async {
    final url = '/users/$competitorId/public-account-info';
    final response =
        await _networkService.get(url, queryParameters: {'versions': ABYSS_VERSION_HISTORY}, cancelToken: cancelToken);

    return response.fold(
      (exception) => left(exception),
      (response) {
        if (response.statusCode == 200 && (response.data as Map).containsKey('userProfileInformation')) {
          return right((
            User.fromJson(response.data['user'] as Map<String, dynamic>),
            UserProfileInfo.fromJson(response.data['userProfileInformation'] as Map<String, dynamic>)
          ));
        } else {
          return left(AppException(message: response.data.toString(), code: response.statusCode.toString()));
        }
      },
    );
  }

  @override
  Future<Either<AppException, List<User>>> searchUsers(String query,
      {Map<String, dynamic>? queryParameters, CancelToken? cancelToken}) async {
    const url = '/users/all';
    final response = await _networkService.get(url,
        queryParameters: {'search': query, ...queryParameters ?? {}}, cancelToken: cancelToken);

    return response.fold(
      (exception) => left(exception),
      (response) {
        if (response.statusCode == 200 && (response.data as Map).containsKey('users')) {
          return right(
              (response.data['users']['rows'] as List).map((e) => User.fromJson(e as Map<String, dynamic>)).toList());
        } else {
          return left(AppException(message: response.data.toString(), code: response.statusCode.toString()));
        }
      },
    );
  }
}
