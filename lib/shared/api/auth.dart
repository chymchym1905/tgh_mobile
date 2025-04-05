import 'package:fpdart/fpdart.dart';
import '../exception.dart';
import '../network.dart';
import '../data_model/user/user.dart';

abstract class AuthApiBase {
  Future<Either<AppException, User>> login(String email, String password);
  Future<Either<AppException, User>> checkAuth();
  void updateAuthToken(String token);
}

class AuthApi implements AuthApiBase {
  final NetworkService _networkService;

  AuthApi(this._networkService);

  @override
  void updateAuthToken(String token) {
    _networkService.updateHeaders(token);
  }

  @override
  Future<Either<AppException, User>> login(String email, String password) async {
    const url = '/authentication';
    final response = await _networkService.post(
      url,
      body: {
        'userEmail': email,
        'password': password,
      },
    );

    return response.fold(
      (exception) => left(exception),
      (response) {
        if (response.statusCode == 200 && (response.data as Map).containsKey('user')) {
          final token = response.data['authToken'] as String;
          updateAuthToken(token);
          return right(User.fromJson(response.data['user'] as Map<String, dynamic>));
        } else if (response.statusCode == 401) {
          return left(AppException(
            message: 'Invalid email or password.',
            code: response.statusCode.toString(),
          ));
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
  Future<Either<AppException, User>> checkAuth() async {
    const url = '/authentication/current';
    final response = await _networkService.get(url);

    return response.fold(
      (exception) => left(exception),
      (response) {
        if (response.statusCode == 200 && (response.data as Map).containsKey('user')) {
          final token = response.data['authToken'] as String;
          updateAuthToken(token);
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
}
