import 'package:freezed_annotation/freezed_annotation.dart';

import '../../exception.dart';
import '../index.dart';

part 'game_asset_state.freezed.dart';

@freezed
abstract class GameAssetState with _$GameAssetState {
  const factory GameAssetState.initial() = GameAssetStateInitial;
  const factory GameAssetState.loaded(List<Character>? characters, List<Weapon>? weapons, List<Artifact>? artifacts) =
      GameAssetStateLoaded;
  const factory GameAssetState.error(AppException exception) = GameAssetStateError;

  const GameAssetState._();

  @override
  String toString() {
    switch (this) {
      case GameAssetStateInitial():
        return 'GameAssetStateInitial';
      case GameAssetStateLoaded(:final characters, :final weapons, :final artifacts):
        return 'GameAssetStateLoaded( Characters count: ${characters?.length}, Weapons count: ${weapons?.length}, Artifacts count: ${artifacts?.length})';
      case GameAssetStateError(:final exception):
        return 'GameAssetStateError(exception: $exception)';
      default:
        return 'Unknown GameAssetState';
    }
  }
}
