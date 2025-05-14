import 'package:fpdart/fpdart.dart';
import 'package:tgh_mobile/imports.dart';
import 'package:tgh_mobile/shared/data_model/standings/speedrun_lb_spot.dart';
import '../exception.dart';
import '../network.dart';

abstract class StandingsApiBase {
  Future<Either<AppException, SpeedrunLeaderboardBoard>> fetchSpeedrunLeaderboard(String abyssVersion,
      {CancelToken? cancelToken});

  Future<Either<AppException, (List<SpeedrunLbSpot> spots, List<CharUsageLbDisplay> charUsages)>>
      fetchSpeedrunLeaderboardSpots(String instanceId,
          {required int limit,
          required int page,
          int daysElapse = 1,
          required String sortBy,
          required String sortDir,
          CancelToken? cancelToken});
}

class StandingsApi implements StandingsApiBase {
  final NetworkService _networkService;

  StandingsApi(this._networkService);

  @override
  Future<Either<AppException, SpeedrunLeaderboardBoard>> fetchSpeedrunLeaderboard(String abyssVersion,
      {CancelToken? cancelToken}) async {
    const url = '/speedrun-leaderboards';
    final response = await _networkService.get(url,
        queryParameters: {
          'speedrun_category': 'Abyss',
          'abyss_version': abyssVersion,
        },
        cancelToken: cancelToken);

    return response.fold(
      (exception) => left(exception),
      (response) {
        if (response.statusCode == 200 && (response.data as Map).containsKey('speedrunLeaderboardWithInstance')) {
          return right(SpeedrunLeaderboardBoard.fromJson(
              response.data['speedrunLeaderboardWithInstance'] as Map<String, dynamic>));
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
  Future<Either<AppException, (List<SpeedrunLbSpot> spots, List<CharUsageLbDisplay> charUsages)>>
      fetchSpeedrunLeaderboardSpots(String instanceId,
          {required int limit,
          required int page,
          int daysElapse = 1,
          required String sortBy,
          required sortDir,
          CancelToken? cancelToken}) async {
    const url = '/speedrun-leaderboard-spots/show-change-detailed';
    final response = await _networkService.get(url,
        queryParameters: {
          'limit': limit,
          'page': page,
          'days_elapse': daysElapse,
          'sort_by': sortBy,
          'sort_dir': sortDir,
          'instance_id': instanceId,
        },
        cancelToken: cancelToken);

    return response.fold(
      (exception) => left(exception),
      (response) {
        if (response.statusCode == 200 && (response.data as Map).containsKey('speedrunLeaderboardSpots')) {
          final spots = (response.data['speedrunLeaderboardSpots']['rows'] as List)
              .map((e) => e as Map<String, dynamic>)
              .toList();
          final charUsages =
              (response.data['userProfileInformations'] as List).map((e) => e as Map<String, dynamic>).toList();
          return right((
            spots.map((e) => SpeedrunLbSpot.fromJson(e)).toList(),
            charUsages.map((e) => CharUsageLbDisplay.fromJson(e)).toList()
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
}
