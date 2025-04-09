import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tgh_mobile/shared/data_model/game_asset/game_asset_state.dart';

import '../../app_state_providers/dio.dart';
import '../api/index.dart';

part 'game_asset.g.dart';

@riverpod
class GameAsset extends _$GameAsset {
  late GameAssetApiBase gameAssetApi;

  @override
  FutureOr<GameAssetState> build() async {
    state = const AsyncValue.loading();
    final networkService = ref.watch(dioNetworkServiceProvider);
    gameAssetApi = GameAssetApi(networkService);
    return const GameAssetStateInitial();
    // final charactersResult = await gameAssetApi.fetchCharacters();
    // final weaponArtiResult = await gameAssetApi.fetchWeaponArti();

    // return charactersResult.fold(
    //   (failure) => GameAssetState.error(failure),
    //   (characters) => weaponArtiResult.fold(
    //     (failure) => GameAssetState.error(failure),
    //     (weaponArti) => GameAssetState.loaded(
    //       characters,
    //       weaponArti.weaponAssets,
    //       weaponArti.artifactAssets,
    //     ),
    //   ),
    // );
  }

  Future<GameAssetState> fetchCharacters() async {
    state = const AsyncValue.loading();
    return (await gameAssetApi.fetchCharacters()).fold(
      (failure) {
        state = AsyncValue.error(GameAssetStateError(failure), StackTrace.current);
        return GameAssetState.error(failure);
      },
      (characters) {
        final currentState = state.valueOrNull;
        if (currentState is GameAssetStateLoaded) {
          state = AsyncValue.data(GameAssetState.loaded(
            characters,
            currentState.weapons,
            currentState.artifacts,
          ));
        }
        return state.value!;
      },
    );
  }

  Future<GameAssetState> fetchWeaponArti() async {
    state = const AsyncValue.loading();
    return (await gameAssetApi.fetchWeaponArti()).fold(
      (failure) {
        state = AsyncValue.error(GameAssetStateError(failure), StackTrace.current);
        return GameAssetState.error(failure);
      },
      (weaponArti) {
        final currentState = state.valueOrNull;
        if (currentState is GameAssetStateLoaded) {
          state = AsyncValue.data(GameAssetState.loaded(
            currentState.characters,
            weaponArti.weaponAssets,
            weaponArti.artifactAssets,
          ));
        }
        return state.value!;
      },
    );
  }

  Future<GameAssetState> fetchAll() async {
    state = const AsyncValue.loading();
    final charactersResult = await gameAssetApi.fetchCharacters();
    final weaponArtiResult = await gameAssetApi.fetchWeaponArti();

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
