import 'package:fpdart/fpdart.dart';
import 'package:tgh_mobile/imports.dart';
import '../exception.dart';
import '../network.dart';

abstract class FeedApiBase {
  Future<Either<AppException, List<Feed>>> fetchFeed(Map<String, dynamic> param, {CancelToken? cancelToken});

  Future<Either<AppException, List<Feed>>> fetchSpeedrunFeed(Map<String, dynamic> param, {CancelToken? cancelToken});

  Future<Either<AppException, List<Feed>>> fetchDPSFeed(Map<String, dynamic> param, {CancelToken? cancelToken});

  Future<Either<AppException, Feed>> fetchFeedById(String id, {CancelToken? cancelToken});
}

class FeedApi implements FeedApiBase {
  final NetworkService _networkService;

  FeedApi(this._networkService);

  @override
  Future<Either<AppException, List<Feed>>> fetchFeed(Map<String, dynamic> param, {CancelToken? cancelToken}) async {
    /// Available params:
    /// - version (game_version) (string)
    /// - approved (boolean) (true by default)
    const url = '/feed';
    final response = await _networkService.get(url, queryParameters: param, cancelToken: cancelToken);

    return response.fold(
      (exception) => left(exception),
      (response) {
        if (response.statusCode == 200 && (response.data as Map).containsKey('entries')) {
          final entries = (response.data['entries'] as List).map((e) => e as Map<String, dynamic>).toList();
          return right(entries.map((e) => Feed.fromJson(e)).toList());
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
  Future<Either<AppException, List<Feed>>> fetchSpeedrunFeed(Map<String, dynamic> param,
      {CancelToken? cancelToken}) async {
    /// Available params:
    /// - approved (boolean)
    /// - version (game_version) (string)
    /// - abyss_version (string) (limited to Abyss speedruns only)
    /// - characters (string) (a string of characters separated by commas) eg: "Kaedehara Kazuha,Mona,Mika"
    const url = '/feed/speedrun-entries';
    final response = await _networkService.get(url, queryParameters: param, cancelToken: cancelToken);

    return response.fold(
      (exception) => left(exception),
      (response) {
        if (response.statusCode == 200 && (response.data as Map).containsKey('entries')) {
          final entries = (response.data['entries'] as List).map((e) => e as Map<String, dynamic>).toList();
          return right(entries.map((e) => Feed.fromJson(e)).toList());
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
  Future<Either<AppException, List<Feed>>> fetchDPSFeed(Map<String, dynamic> param, {CancelToken? cancelToken}) async {
    /// Available params:
    /// - approved (boolean)
    /// - version (game_version) (string)
    /// - dps_character (string) (a single character)
    /// - element (string) (a single element) [Pyro, Hydro, Anemo, Electro, Dendro, Cryo, Geo, Dendro]
    const url = '/feed/dps-entries';
    final response = await _networkService.get(url, queryParameters: param, cancelToken: cancelToken);

    return response.fold(
      (exception) => left(exception),
      (response) {
        if (response.statusCode == 200 && (response.data as Map).containsKey('entries')) {
          final entries = (response.data['entries'] as List).map((e) => e as Map<String, dynamic>).toList();
          return right(entries.map((e) => Feed.fromJson(e)).toList());
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
  Future<Either<AppException, Feed>> fetchFeedById(String id, {CancelToken? cancelToken}) async {
    final url = '/feed/$id';
    final response = await _networkService.get(url, cancelToken: cancelToken);
    return response.fold(
      (exception) => left(exception),
      (response) {
        if (response.statusCode == 200 && (response.data as Map).containsKey('entries')) {
          final entries = (response.data['entries'] as List).map((e) => e as Map<String, dynamic>).toList();
          if (entries.length > 1) {
            return left(AppException(
              message: 'Multiple entries found for id: $id',
              code: '500',
            ));
          }
          return right(entries.map((e) => Feed.fromJson(e)).toList().first);
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
