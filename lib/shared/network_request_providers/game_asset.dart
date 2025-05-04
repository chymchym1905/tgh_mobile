import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tgh_mobile/imports.dart';
import 'package:tgh_mobile/shared/data_model/game_asset/game_asset_state.dart';

import '../exception.dart';

part 'game_asset.g.dart';

@riverpod
class GameAsset extends _$GameAsset {
  late GameAssetApiBase _gameAssetApi;

  @override
  FutureOr<GameAssetState> build() async {
    state = const AsyncValue.loading();
    final networkService = ref.watch(dioNetworkServiceProvider);
    _gameAssetApi = GameAssetApi(networkService);

    final cancelToken = await ref.cancelToken();
    final futures = [
      _gameAssetApi.fetchCharacters(cancelToken: cancelToken),
      _gameAssetApi.fetchWeaponArti(cancelToken: cancelToken),
    ];
    final results = await Future.wait(futures, eagerError: false);
    final charactersResult = results[0] as Either<AppException, List<Character>>;
    final weaponArtiResult =
        results[1] as Either<AppException, ({List<Weapon> weaponAssets, List<Artifact> artifactAssets})>;
    return charactersResult.fold(
      (failure) => GameAssetState.error(failure),
      (characters) => weaponArtiResult.fold(
        (failure) {
          return GameAssetState.error(failure);
        },
        (weaponArti) {
          return GameAssetState.loaded(characters, weaponArti.weaponAssets, weaponArti.artifactAssets);
        },
      ),
    );
  }

  Future<GameAssetState> fetchCharacters() async {
    state = const AsyncValue.loading();
    final cancelToken = await ref.cancelToken();
    return (await _gameAssetApi.fetchCharacters(cancelToken: cancelToken)).fold(
      (failure) {
        state = AsyncValue.error(GameAssetStateError(failure), StackTrace.current);
        return GameAssetState.error(failure);
      },
      (characters) {
        final currentState = state.valueOrNull;
        switch (currentState) {
          case GameAssetStateLoaded():
            state = AsyncValue.data(GameAssetState.loaded(
              characters,
              currentState.weapons,
              currentState.artifacts,
            ));
          default:
            state = AsyncValue.data(GameAssetState.loaded(characters, null, null));
        }
        return state.value!;
      },
    );
  }

  Future<GameAssetState> fetchWeaponArti() async {
    state = const AsyncValue.loading();
    final cancelToken = await ref.cancelToken();
    return (await _gameAssetApi.fetchWeaponArti(cancelToken: cancelToken)).fold(
      (failure) {
        state = AsyncValue.error(GameAssetStateError(failure), StackTrace.current);
        return GameAssetState.error(failure);
      },
      (weaponArti) {
        final currentState = state.valueOrNull;
        switch (currentState) {
          case GameAssetStateLoaded():
            state = AsyncValue.data(GameAssetState.loaded(
              currentState.characters,
              weaponArti.weaponAssets,
              weaponArti.artifactAssets,
            ));
          default:
            state = AsyncValue.data(GameAssetState.loaded(null, weaponArti.weaponAssets, weaponArti.artifactAssets));
        }
        return state.value!;
      },
    );
  }

  Future<GameAssetState> fetchAll() async {
    state = const AsyncValue.loading();
    final cancelToken = await ref.cancelToken();
    final futures = [
      _gameAssetApi.fetchCharacters(cancelToken: cancelToken),
      _gameAssetApi.fetchWeaponArti(cancelToken: cancelToken),
    ];
    final results = await Future.wait(futures, eagerError: false);
    final charactersResult = results[0] as Either<AppException, List<Character>>;
    final weaponArtiResult =
        results[1] as Either<AppException, ({List<Weapon> weaponAssets, List<Artifact> artifactAssets})>;

    return charactersResult.fold(
      (failure) => GameAssetState.error(failure),
      (characters) => weaponArtiResult.fold(
        (failure) {
          state = AsyncValue.error(GameAssetStateError(failure), StackTrace.current);
          return GameAssetState.error(failure);
        },
        (weaponArti) {
          state =
              AsyncValue.data(GameAssetState.loaded(characters, weaponArti.weaponAssets, weaponArti.artifactAssets));
          return state.value!;
        },
      ),
    );
  }
}
