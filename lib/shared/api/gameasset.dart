import 'dart:developer';
import 'dart:isolate';

import 'package:fpdart/fpdart.dart';
import 'package:tgh_mobile/imports.dart';
import '../exception.dart';
import '../network.dart';

// Helper functions for isolate
({List<Weapon> weaponAssets, List<Artifact> artifactAssets}) _parseAssets(Map<String, dynamic> data) {
  final weaponAssets = (data['weaponAssets'] as List).map((e) => Weapon.fromJson(e as Map<String, dynamic>)).toList();
  final artifactAssets =
      (data['artifactAssets'] as List).map((e) => Artifact.fromJson(e as Map<String, dynamic>)).toList();
  return (weaponAssets: weaponAssets, artifactAssets: artifactAssets);
}

abstract class GameAssetApiBase {
  Future<Either<AppException, List<Character>>> fetchCharacters();
  Future<Either<AppException, ({List<Weapon> weaponAssets, List<Artifact> artifactAssets})>> fetchWeaponArti();
}

class GameAssetApi implements GameAssetApiBase {
  final NetworkService _networkService;

  GameAssetApi(this._networkService);

  @override
  Future<Either<AppException, List<Character>>> fetchCharacters() async {
    const url = '/game-assets/character/all';
    final response = await _networkService.get(url);

    return response.fold(
      (exception) => left(exception),
      (response) {
        if (response.statusCode == 200 && (response.data as Map).containsKey('characterAssets')) {
          final characterAssets = (response.data['characterAssets'] as List)
              .map((e) => Character.fromJson(e as Map<String, dynamic>))
              .toList();
          return right(characterAssets);
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
  Future<Either<AppException, ({List<Weapon> weaponAssets, List<Artifact> artifactAssets})>> fetchWeaponArti() async {
    const url = '/game-assets/weapon-arti/all';
    log('Fetching weapon arti from $url');
    final response = await _networkService.get(url);

    return response.fold(
      (exception) => left(exception),
      (response) async {
        if (response.statusCode == 200 && (response.data as Map).containsKey('weaponAssets')) {
          log('Parsing weapon arti');
          final stopwatch = Stopwatch()..start();

          // Create a port to receive the result
          final receivePort = ReceivePort();

          // Spawn the isolate
          await Isolate.spawn(
            _parseInIsolate,
            _IsolateData(
              data: response.data as Map<String, dynamic>,
              sendPort: receivePort.sendPort,
            ),
          );

          // Wait for the result from the isolate
          final result = await receivePort.first as ({List<Weapon> weaponAssets, List<Artifact> artifactAssets});
          receivePort.close();

          stopwatch.stop();
          log('Parsing completed in ${stopwatch.elapsedMilliseconds}ms');

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

// Function that runs in the isolate
void _parseInIsolate(_IsolateData isolateData) {
  final result = _parseAssets(isolateData.data);
  isolateData.sendPort.send(result);
}
