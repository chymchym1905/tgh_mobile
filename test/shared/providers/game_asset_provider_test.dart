import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';
import 'package:tgh_mobile/imports.dart';
import 'package:tgh_mobile/shared/data_model/game_asset/game_asset_state.dart';
import 'package:tgh_mobile/shared/exception.dart';
import 'package:tgh_mobile/shared/network.dart';
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

    setUp(() async {
      WidgetsFlutterBinding.ensureInitialized();
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      container = createContainer(
        overrides: [
          sharedPrefInstanceProvider.overrideWithValue(prefs),
          dioNetworkServiceProvider.overrideWithValue(DioNetworkService(Dio())),
        ],
      );
    });

    test('fetchCharacters returns valid characters', () async {
      final states = <AsyncValue<GameAssetState>>[];
      final provider = gameAssetProvider;
      final subscription = container.listen(
        provider,
        (previous, next) => states.add(next),
        fireImmediately: true,
      );

      final state = await container.read(provider.notifier).fetchCharacters();
      subscription.close();

      log(states.toString());
      switch (state) {
        case GameAssetStateLoaded():
          expect(state.characters, isA<List<Character>>());
          expect(state.characters, isNotEmpty);
        case GameAssetStateError():
          expect(state.exception, isA<AppException>());
      }
    });

    test('fetchWeaponArti returns valid weapons and artifacts', () async {
      final states = <AsyncValue<GameAssetState>>[];
      final provider = gameAssetProvider;
      final subscription = container.listen(
        provider,
        (previous, next) => states.add(next),
        fireImmediately: true,
      );

      final state = await container.read(provider.notifier).fetchWeaponArti();
      subscription.close();

      log(states.toString());
      switch (state) {
        case GameAssetStateLoaded():
          expect(state.weapons, isA<List<Weapon>>());
          expect(state.artifacts, isA<List<Artifact>>());
          expect(state.weapons, isNotEmpty);
          expect(state.artifacts, isNotEmpty);
        case GameAssetStateError():
          expect(state.exception, isA<AppException>());
      }
    });

    test('fetchAll returns valid game assets', () async {
      final states = <AsyncValue<GameAssetState>>[];
      final provider = gameAssetProvider;
      final subscription = container.listen(
        provider,
        (previous, next) => states.add(next),
        fireImmediately: true,
      );

      final state = await container.read(provider.notifier).fetchAll();
      subscription.close();

      log(states.toString());
      switch (state) {
        case GameAssetStateLoaded():
          expect(state.characters, isA<List<Character>>());
          expect(state.weapons, isA<List<Weapon>>());
          expect(state.artifacts, isA<List<Artifact>>());
          expect(state.characters, isNotEmpty);
          expect(state.weapons, isNotEmpty);
          expect(state.artifacts, isNotEmpty);
        case GameAssetStateError():
          expect(state.exception, isA<AppException>());
      }
    });
  });
}
