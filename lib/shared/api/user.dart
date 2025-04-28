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
  // Future<Either<AppException, Map<String, dynamic>>> fetchAccountInfo(String userId, {CancelToken? cancelToken});
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
    const url = '/users/get-name';
    final response = await _networkService.get(url, cancelToken: cancelToken);

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
  Future<Either<AppException, User>> getEmail(String email, {CancelToken? cancelToken}) async {
    const url = '/users/get-email';
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
}
