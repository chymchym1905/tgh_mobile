import 'package:fpdart/fpdart.dart';
import 'package:tgh_mobile/imports.dart';
import '../exception.dart';
import '../network.dart';

abstract class UserApiBase {
  Future<Either<AppException, User>> createCompetitor(Map<String, dynamic> data, {CancelToken? cancelToken});
  Future<Either<AppException, User?>> updateCompetitorForCurrentUser(Map<String, dynamic> updatedInfo,
      {CancelToken? cancelToken});
  Future<Either<AppException, void>> unsetCompetitor({CancelToken? cancelToken});
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
}
