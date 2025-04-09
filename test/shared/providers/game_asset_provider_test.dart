import 'package:flutter_test/flutter_test.dart';
import 'package:tgh_mobile/imports.dart';
import 'package:tgh_mobile/shared/data_model/game_asset/game_asset_state.dart';
import 'package:tgh_mobile/shared/exception.dart';
import 'package:tgh_mobile/shared/network_request_providers/game_asset.dart';

ProviderContainer createContainer({
  ProviderContainer? parent,
  List<Override> overrides = const [],
  List<ProviderObserver>? observers,
}) {
  final container = ProviderContainer(
    parent: parent,
    overrides: overrides,
    observers: observers,
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  group('GameAssetProvider Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = createContainer();
    });

    test('Fetch characters', () async {
      final api = container.read(gameAssetProvider.notifier);

      final state = await api.fetchCharacters();

      switch (state) {
        case GameAssetStateLoaded():
          expect(state.characters, isA<List<Character>>());
        case GameAssetStateError():
          expect(state.exception, isA<AppException>());
      }
    });

    test('Fetch weapon arti', () async {
      final api = container.read(gameAssetProvider.notifier);
      final state = await api.fetchWeaponArti();

      switch (state) {
        case GameAssetStateLoaded():
          expect(state.weapons, isA<List<Weapon>>());
          expect(state.artifacts, isA<List<Artifact>>());
        case GameAssetStateError():
          expect(state.exception, isA<AppException>());
      }
    });

    test('Fetch all', () async {
      final api = container.read(gameAssetProvider.notifier);
      final state = await api.fetchAll();

      switch (state) {
        case GameAssetStateLoaded():
          expect(state.characters, isA<List<Character>>());
          expect(state.weapons, isA<List<Weapon>>());
          expect(state.artifacts, isA<List<Artifact>>());
        case GameAssetStateError():
          expect(state.exception, isA<AppException>());
      }
    });
  });
}
