import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'exception.dart';
import 'package:fpdart/fpdart.dart';
import '../imports.dart';

abstract class NetworkService {
  Future<Either<AppException, Response>> get(String path, {Map<String, dynamic>? queryParameters});
  Future<Either<AppException, Response>> post(String path, {Map<String, dynamic>? body});
  Future<Either<AppException, Response>> put(String path, {Map<String, dynamic>? body});
  Future<Either<AppException, Response>> delete(String path);
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
          responseHeader: true,
          logPrint: (o) => log(o.toString())));
    }
  }

  @override
  Future<Either<AppException, Response>> get(String path, {Map<String, dynamic>? queryParameters}) async {
    return await handleException(() => _dio.get(path, queryParameters: queryParameters), endpoint: path).run();
  }

  @override
  Future<Either<AppException, Response>> post(String path, {Map<String, dynamic>? body}) async {
    return await handleException(() => _dio.post(path, data: body), endpoint: path).run();
  }

  @override
  Future<Either<AppException, Response>> put(String path, {Map<String, dynamic>? body}) async {
    return await handleException(() => _dio.put(path, data: body), endpoint: path).run();
  }

  @override
  Future<Either<AppException, Response>> delete(String path) async {
    return await handleException(() => _dio.delete(path), endpoint: path).run();
  }
}

mixin NetworkException {
  TaskEither<AppException, Response> handleException(Future<Response> Function() func, {String endpoint = ''}) =>
      TaskEither<AppException, Response>.tryCatch(
        () => func(),
        (e, stackTrace) {
          String message = '';
          String identifier = '';
          int statusCode = 0;
          log(e.runtimeType.toString());
          switch (e.runtimeType) {
            case SocketException _:
              e as SocketException;
              message = 'Unable to connect to the server.';
              statusCode = 0;
              identifier = 'Socket Exception ${e.message}\n at  $endpoint';
              break;

            case DioException _:
              e as DioException;
              message = e.response?.data?['message'] as String;
              statusCode = 1;
              identifier = 'DioException ${e.message} \nat  $endpoint';
              break;

            default:
              message = 'Unknown error occurred';
              statusCode = 2;
              identifier = 'Unknown error ${e.toString()}\n at $endpoint';
          }
          return AppException(
            message: message,
            code: statusCode.toString(),
            identifier: identifier,
          );
        },
      );
}
