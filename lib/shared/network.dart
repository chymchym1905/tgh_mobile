import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'exception.dart';
import 'package:fpdart/fpdart.dart';
import '../imports.dart';

abstract class NetworkService {
  Map<String, dynamic> get headers;
  void updateHeaders(String authToken);
  void removeAuthHeader();
  Future<Either<AppException, Response<T>>> get<T>(String path, {Map<String, dynamic>? queryParameters});
  Future<Either<AppException, Response<T>>> post<T>(String path, {Map<String, dynamic>? body});
  Future<Either<AppException, Response<T>>> put<T>(String path, {Map<String, dynamic>? body});
  Future<Either<AppException, Response<T>>> delete<T>(String path);
}

class DioNetworkService with NetworkException implements NetworkService {
  final Dio _dio;

  DioNetworkService(this._dio) {
    _dio.options.baseUrl = AppConfig.apiUrl;
    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
          requestBody: true,
          responseBody: true,
          error: true,
          request: true,
          requestHeader: true,
          logPrint: (o) => log(o.toString())));
    }
  }

  @override
  Map<String, dynamic> get headers => _dio.options.headers;

  @override
  void updateHeaders(String authToken) {
    _dio.options.headers.addEntries([MapEntry('Authorization', authToken)]);
  }

  @override
  void removeAuthHeader() {
    _dio.options.headers.remove('Authorization');
  }

  @override
  Future<Either<AppException, Response<T>>> get<T>(String path, {Map<String, dynamic>? queryParameters}) async {
    return await handleException(() => _dio.get<T>(path, queryParameters: queryParameters), endpoint: path).run();
  }

  @override
  Future<Either<AppException, Response<T>>> post<T>(String path, {Map<String, dynamic>? body}) async {
    return await handleException(() => _dio.post<T>(path, data: body), endpoint: path).run();
  }

  @override
  Future<Either<AppException, Response<T>>> put<T>(String path, {Map<String, dynamic>? body}) async {
    return await handleException(() => _dio.put<T>(path, data: body), endpoint: path).run();
  }

  @override
  Future<Either<AppException, Response<T>>> delete<T>(String path) async {
    return await handleException(() => _dio.delete<T>(path), endpoint: path).run();
  }
}

mixin NetworkException {
  TaskEither<AppException, Response<T>> handleException<T>(
    Future<Response<T>> Function() func, {
    String endpoint = '',
  }) =>
      TaskEither<AppException, Response<T>>.tryCatch(
        () => func(),
        (e, stackTrace) {
          log(e.runtimeType.toString());

          switch (e) {
            case DioException():
              final response = e.response;
              return AppException(
                message: response?.data.toString() ?? e.message ?? 'Server error',
                code: response?.statusCode?.toString() ?? 'Unknown HTTP Status Code',
                identifier: 'DioException: ${e.type} at $endpoint',
                data: response?.data.toString(),
              );

            case SocketException():
              return AppException(
                message: 'Unable to connect to the server.',
                code: '1',
                identifier: 'Socket Exception: ${e.message} at $endpoint',
              );

            default:
              return AppException(
                message: 'Unknown error occurred',
                code: '0',
                identifier: 'Unknown error: ${e.toString()} at $endpoint',
              );
          }
        },
      );
}
