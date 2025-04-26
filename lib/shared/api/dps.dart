import 'package:fpdart/fpdart.dart';
import 'package:tgh_mobile/imports.dart';
import '../exception.dart';
import '../network.dart';

abstract class DpsApiBase {
  Future<Either<AppException, List<DPS>>> fetchCompetitorDps(
    String competitorId,
    String sortBy,
    String sortDir,
    int page,
    int limit, {
    bool? approved,
    Map<String, dynamic>? queryParam,
    CancelToken? cancelToken,
  });

  Future<Either<AppException, List<DPS>>> fetchDps(
    String sortBy,
    String sortDir,
    int page,
    int limit, {
    bool? approved,
    Map<String, dynamic>? queryParam,
    CancelToken? cancelToken,
  });

  Future<Either<AppException, List<DPS>>> fetchDpsAgent(
    String sortBy,
    String sortDir,
    int page,
    int limit, {
    bool? approved,
    Map<String, dynamic>? queryParam,
    CancelToken? cancelToken,
  });

  Future<Either<AppException, DPS>> fetchDpsById(String id);
}

class DpsApi implements DpsApiBase {
  final NetworkService _networkService;

  DpsApi(this._networkService);

  @override
  Future<Either<AppException, List<DPS>>> fetchCompetitorDps(
    String competitorId,
    String sortBy,
    String sortDir,
    int page,
    int limit, {
    bool? approved,
    Map<String, dynamic>? queryParam,
    CancelToken? cancelToken,
  }) async {
    const url = '/dps-entries/all';
    final response = await _networkService.get(url,
        queryParameters: {
          'competitor': competitorId,
          'sortBy': sortBy,
          'sortDir': sortDir,
          'limit': limit,
          'page': page,
          'approved': approved ?? true,
          ...queryParam ?? {},
        },
        cancelToken: cancelToken);

    return response.fold(
      (exception) => left(exception),
      (response) {
        if (response.statusCode == 200 && (response.data as Map).containsKey('dpsEntries')) {
          final entries = (response.data['dpsEntries']['rows'] as List).map((e) => e as Map<String, dynamic>).toList();
          return right(entries.map((e) => DPS.fromJson(e)).toList());
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
  Future<Either<AppException, List<DPS>>> fetchDps(
    String sortBy,
    String sortDir,
    int page,
    int limit, {
    bool? approved,
    Map<String, dynamic>? queryParam,
    CancelToken? cancelToken,
  }) async {
    const url = '/dps-entries/all-detailed';
    final response = await _networkService.get(url,
        queryParameters: {
          'sortBy': sortBy,
          'sortDir': sortDir,
          'page': page,
          'limit': limit,
          'approved': approved ?? true,
          ...queryParam ?? {},
        },
        cancelToken: cancelToken);

    return response.fold(
      (exception) => left(exception),
      (response) {
        if (response.statusCode == 200 && (response.data as Map).containsKey('dpsEntries')) {
          final entries = (response.data['dpsEntries']['rows'] as List).map((e) => e as Map<String, dynamic>).toList();
          return right(entries.map((e) => DPS.fromJson(e)).toList());
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
  Future<Either<AppException, List<DPS>>> fetchDpsAgent(
    String sortBy,
    String sortDir,
    int page,
    int limit, {
    bool? approved,
    Map<String, dynamic>? queryParam,
    CancelToken? cancelToken,
  }) async {
    const url = '/dps-entries/agent-all';
    final response = await _networkService.get(url,
        queryParameters: {
          'sortBy': sortBy,
          'sortDir': sortDir,
          'page': page,
          'limit': limit,
          'approved': approved ?? true,
          ...queryParam ?? {},
        },
        cancelToken: cancelToken);

    return response.fold(
      (exception) => left(exception),
      (response) {
        if (response.statusCode == 200 && (response.data as Map).containsKey('dpsEntries')) {
          final entries = (response.data['dpsEntries']['rows'] as List).map((e) => e as Map<String, dynamic>).toList();
          return right(entries.map((e) => DPS.fromJson(e)).toList());
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
  Future<Either<AppException, DPS>> fetchDpsById(String id) async {
    final url = '/dps-entries/$id';
    final response = await _networkService.get(url);
    return response.fold(
      (exception) => left(exception),
      (response) {
        if (response.statusCode == 200 && (response.data as Map).containsKey('dpsEntry')) {
          return right(DPS.fromJson(response.data['dpsEntry'] as Map<String, dynamic>));
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
