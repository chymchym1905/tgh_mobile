import 'dart:developer';
import 'dart:isolate';

import 'package:fpdart/fpdart.dart';
import 'package:tgh_mobile/imports.dart';
import '../exception.dart';
import '../network.dart';

// Helper functions for isolate
({List<Weapon> weaponAssets, List<Artifact> artifactAssets}) _parseWeaponArti(Map<String, dynamic> data) {
  final weaponAssets = (data['weaponAssets'] as List).map((e) => Weapon.fromJson(e as Map<String, dynamic>)).toList();
  final artifactAssets =
      (data['artifactAssets'] as List).map((e) => Artifact.fromJson(e as Map<String, dynamic>)).toList();
  return (weaponAssets: weaponAssets, artifactAssets: artifactAssets);
}

List<Character> _parseCharacters(Map<String, dynamic> data) {
  return (data['characterAssets'] as List).map((e) => Character.fromJson(e as Map<String, dynamic>)).toList();
}

abstract class GameAssetApiBase {
  Future<Either<AppException, List<Character>>> fetchCharacters({CancelToken? cancelToken});
  Future<Either<AppException, ({List<Weapon> weaponAssets, List<Artifact> artifactAssets})>> fetchWeaponArti(
      {CancelToken? cancelToken});
}

class GameAssetApi implements GameAssetApiBase {
  final NetworkService _networkService;

  GameAssetApi(this._networkService);

  @override
  Future<Either<AppException, List<Character>>> fetchCharacters({CancelToken? cancelToken}) async {
    const url = '/game-assets/character/all';
    log('Fetching characters from $url');
    final response = await _networkService.get(url, cancelToken: cancelToken);

    return response.fold(
      (exception) => left(exception),
      (response) async {
        if (response.statusCode == 200 && (response.data as Map).containsKey('characterAssets')) {
          log('Parsing characters');
          final stopwatch = Stopwatch()..start();

          // // Create a port to receive the result
          // final receivePort = ReceivePort();

          // // Spawn the isolate
          // await Isolate.spawn(
          //   _parseCharactersInIsolate,
          //   _IsolateData(
          //     data: response.data as Map<String, dynamic>,
          //     sendPort: receivePort.sendPort,
          //   ),
          // );

          // // Wait for the result from the isolate
          // final result = await receivePort.first as List<Character>;
          // receivePort.close();

          // stopwatch.stop();
          final result = _parseCharacters(response.data as Map<String, dynamic>);
          log('Parsing Characters completed in ${stopwatch.elapsedMilliseconds}ms');

          return right(result);
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
  Future<Either<AppException, ({List<Weapon> weaponAssets, List<Artifact> artifactAssets})>> fetchWeaponArti(
      {CancelToken? cancelToken}) async {
    const url = '/game-assets/weapon-arti/all';
    log('Fetching weapon arti from $url');
    final response = await _networkService.get(url, cancelToken: cancelToken);

    return response.fold(
      (exception) => left(exception),
      (response) async {
        if (response.statusCode == 200 && (response.data as Map).containsKey('weaponAssets')) {
          log('Parsing weapon arti');
          final stopwatch = Stopwatch()..start();

          // // Create a port to receive the result
          // final receivePort = ReceivePort();

          // // Spawn the isolate
          // await Isolate.spawn(
          //   _parseWeaponArtiInIsolate,
          //   _IsolateData(
          //     data: response.data as Map<String, dynamic>,
          //     sendPort: receivePort.sendPort,
          //   ),
          // );

          // // Wait for the result from the isolate
          // final result = await receivePort.first as ({List<Weapon> weaponAssets, List<Artifact> artifactAssets});
          // receivePort.close();
          final result = _parseWeaponArti(response.data as Map<String, dynamic>);

          stopwatch.stop();
          log('Parsing Weapon Arti completed in ${stopwatch.elapsedMilliseconds}ms');

          return right(result);
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

// Data class to pass to isolate
class _IsolateData {
  final Map<String, dynamic> data;
  final SendPort sendPort;

  _IsolateData({required this.data, required this.sendPort});
}

// Function that runs in the isolate for weapon and artifact parsing
void _parseWeaponArtiInIsolate(_IsolateData isolateData) {
  final result = _parseWeaponArti(isolateData.data);
  isolateData.sendPort.send(result);
}

// Function that runs in the isolate for character parsing
void _parseCharactersInIsolate(_IsolateData isolateData) {
  final result = _parseCharacters(isolateData.data);
  isolateData.sendPort.send(result);
}
