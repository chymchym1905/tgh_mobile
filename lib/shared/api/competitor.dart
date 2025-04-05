import 'package:fpdart/fpdart.dart';
import '../exception.dart';
import '../data_model/competitor/competitor.dart';
import '../data_model/user/user.dart';
import '../network.dart';

abstract class CompetitorApiBase {
  Future<Either<AppException, User>> createCompetitor(Map<String, dynamic> data);

  Future<Either<AppException, Competitor?>> updateCompetitorInfo(
    Map<String, dynamic> updatedInfo,
  );

  Future<Either<AppException, Competitor>> getCompetitorByAlias(
    String alias,
  );
}

class CompetitorApi implements CompetitorApiBase {
  final NetworkService _networkService;

  CompetitorApi(this._networkService);

  @override
  Future<Either<AppException, User>> createCompetitor(Map<String, dynamic> data) async {
    const url = '/users/create-competitor';
    final response = await _networkService.put(url, body: data);

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
  Future<Either<AppException, Competitor?>> updateCompetitorInfo(
    Map<String, dynamic> updatedInfo,
  ) async {
    const url = '/competitors/update-current';
    final response = await _networkService.put(url, body: updatedInfo);

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
  Future<Either<AppException, Competitor>> getCompetitorByAlias(String alias) async {
    final url = '/competitors/$alias';
    final response = await _networkService.get(url);

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
}
