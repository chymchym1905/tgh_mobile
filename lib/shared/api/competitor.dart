import 'package:fpdart/fpdart.dart';
import 'package:tgh_mobile/imports.dart';
import '../exception.dart';
import '../network.dart';

abstract class CompetitorApiBase {
  Future<Either<AppException, Competitor?>> updateCompetitorInfo(Map<String, dynamic> updatedInfo,
      {CancelToken? cancelToken});

  Future<Either<AppException, Competitor>> getCompetitorByAlias(String alias, {CancelToken? cancelToken});
  Future<Either<AppException, List<Competitor>>> searchCompetitors(String alias, {CancelToken? cancelToken});
}

class CompetitorApi implements CompetitorApiBase {
  final NetworkService _networkService;

  CompetitorApi(this._networkService);

  @override
  Future<Either<AppException, Competitor?>> updateCompetitorInfo(Map<String, dynamic> updatedInfo,
      {CancelToken? cancelToken}) async {
    const url = '/competitors/update-current';
    final response = await _networkService.put(url, body: updatedInfo, cancelToken: cancelToken);

    return response.fold(
      (exception) => left(exception),
      (response) {
        if (response.statusCode == 200 && (response.data as Map).containsKey('competitor')) {
          return right(Competitor.fromJson(response.data['competitor'] as Map<String, dynamic>));
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
  Future<Either<AppException, Competitor>> getCompetitorByAlias(String alias, {CancelToken? cancelToken}) async {
    final url = '/competitors/$alias';
    final response = await _networkService.get(url, cancelToken: cancelToken);

    return response.fold(
      (exception) => left(exception),
      (response) {
        if (response.statusCode == 200 && (response.data as Map).containsKey('competitor')) {
          return right(Competitor.fromJson(response.data['competitor'] as Map<String, dynamic>));
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
  Future<Either<AppException, List<Competitor>>> searchCompetitors(String alias, {CancelToken? cancelToken}) async {
    const url = '/competitors/all';
    final queryParams = {'search': alias};
    final response = await _networkService.get(url, queryParameters: queryParams, cancelToken: cancelToken);

    return response.fold(
      (exception) => left(exception),
      (response) {
        if (response.statusCode == 200 && (response.data as Map).containsKey('competitors')) {
          return right((response.data['competitors']['rows'] as List)
              .map((e) => Competitor.fromJson(e as Map<String, dynamic>))
              .toList());
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
