import 'package:fpdart/fpdart.dart';
import 'package:tgh_mobile/imports.dart';

import '../exception.dart';
import '../network.dart';

abstract class SpeedrunApiBase {
  Future<Either<AppException, (int count, List<Speedrun> speedruns)>> fetchCompetitorSpeedruns(
    String competitorId,
    String sortBy,
    String sortDir,
    int page,
    int limit, {
    bool? approved,
    Map<String, dynamic>? queryParam,
    CancelToken? cancelToken,
  });

  Future<Either<AppException, (int count, List<Speedrun> speedruns, List<CharUsageLbDisplay> charSnapshots)>>
      fetchSpeedrun(
    String sortBy,
    String sortDir,
    int page,
    int limit, {
    bool? approved,
    Map<String, dynamic>? queryParam,
    CancelToken? cancelToken,
  });

  Future<Either<AppException, (int count, List<Speedrun> speedruns)>> fetchSpeedrunAgent(
    String sortBy,
    String sortDir,
    int page,
    int limit, {
    bool? approved,
    Map<String, dynamic>? queryParam,
    CancelToken? cancelToken,
  });

  Future<Either<AppException, Speedrun>> fetchSpeedrunById(String id);
  // Future<Either<AppException, List<Speedrun>>> getSpeedrunCountInPeriod(String startDate, String endDate,
  //     [bool? day, bool? week, bool? month, bool? year]);

  Future<Either<AppException, SpeedrunSubmitResponse>> submitSpeedrun(
      {required SpeedrunSubmit submission, CancelToken? cancelToken});
}

class SpeedrunApi implements SpeedrunApiBase {
  final NetworkService _networkService;

  SpeedrunApi(this._networkService);

  @override
  Future<Either<AppException, (int count, List<Speedrun> speedruns)>> fetchCompetitorSpeedruns(
    String competitorId,
    String sortBy,
    String sortDir,
    int page,
    int limit, {
    bool? approved,
    Map<String, dynamic>? queryParam,
    CancelToken? cancelToken,
  }) async {
    const url = '/speedrun-entries/all';
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
        if (response.statusCode == 200 && (response.data as Map).containsKey('entries')) {
          final entries = (response.data['entries']['rows'] as List).map((e) => e as Map<String, dynamic>).toList();
          return right((response.data['entries']['count'] as int, entries.map((e) => Speedrun.fromJson(e)).toList()));
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
  Future<Either<AppException, (int count, List<Speedrun> speedruns, List<CharUsageLbDisplay> charSnapshots)>>
      fetchSpeedrun(
    String sortBy,
    String sortDir,
    int page,
    int limit, {
    bool? approved,
    Map<String, dynamic>? queryParam,
    CancelToken? cancelToken,
  }) async {
    const url = '/speedrun-entries/all-detailed';
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
        if (response.statusCode == 200 && (response.data as Map).containsKey('entries')) {
          final entries = (response.data['entries']['rows'] as List).map((e) => e as Map<String, dynamic>).toList();
          final charUsageLbDisplay = (response.data['userProfileInformations'] as List)
              .map((e) => CharUsageLbDisplay.fromJson(e as Map<String, dynamic>))
              .toList();
          return right((
            response.data['entries']['count'] as int,
            entries.map((e) => Speedrun.fromJson(e)).toList(),
            charUsageLbDisplay
          ));
        } else {
          return left(AppException(message: response.data.toString(), code: response.statusCode.toString()));
        }
      },
    );
  }

  @override
  Future<Either<AppException, (int count, List<Speedrun> speedruns)>> fetchSpeedrunAgent(
    String sortBy,
    String sortDir,
    int page,
    int limit, {
    bool? approved,
    Map<String, dynamic>? queryParam,
    CancelToken? cancelToken,
  }) async {
    const url = '/speedrun-entries/agent-all';
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
        if (response.statusCode == 200 && (response.data as Map).containsKey('entries')) {
          final entries = (response.data['entries']['rows'] as List).map((e) => e as Map<String, dynamic>).toList();
          return right((response.data['entries']['count'] as int, entries.map((e) => Speedrun.fromJson(e)).toList()));
        } else {
          return left(AppException(message: response.data.toString(), code: response.statusCode.toString()));
        }
      },
    );
  }

  @override
  Future<Either<AppException, Speedrun>> fetchSpeedrunById(String id) async {
    final url = '/speedrun-entries/$id';
    final response = await _networkService.get(url);
    return response.fold(
      (exception) => left(exception),
      (response) {
        if (response.statusCode == 200 && (response.data as Map).containsKey('speedrunEntry')) {
          return right(Speedrun.fromJson(response.data['speedrunEntry'] as Map<String, dynamic>));
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
  Future<Either<AppException, SpeedrunSubmitResponse>> submitSpeedrun(
      {required SpeedrunSubmit submission, CancelToken? cancelToken}) async {
    const url = '/speedrun-entries/create';
    final response = await _networkService.post(url, body: submission.toJson(), cancelToken: cancelToken);
    return response.fold(
      (exception) => left(exception),
      (response) {
        if (response.statusCode == 200 && (response.data as Map).containsKey('entry')) {
          return right(SpeedrunSubmitResponse.fromJson(response.data['entry'] as Map<String, dynamic>).copyWith(
              accountSnapshot: AccountSnapshot.fromJson(response.data['accountSnapshot'] as Map<String, dynamic>)));
        } else {
          return left(AppException(
            message: response.data.toString(),
            code: response.statusCode.toString(),
          ));
        }
      },
    );
  }

  // @override
  // Future<Either<AppException, List<Speedrun>>> getSpeedrunCountInPeriod(String startDate, String endDate,
  //     [bool? day, bool? week, bool? month, bool? year]) async {
  //   const url = '/speedrun-entries/stats';
  //   final query = {
  //     'start': startDate,
  //     'end': endDate,
  //     'day': day,
  //     'week': week,
  //     'month': month,
  //     'year': year,
  //   };
  //   final response = await _networkService.post(url, body: query);
  //   return response.fold(
  //     (exception) => left(exception),
  //     (response) {
  //       return right(response.data);
  //     },
  //   );
  // }
}
