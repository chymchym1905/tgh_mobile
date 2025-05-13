import '../../imports.dart';

enum TagsType { speedrun, dps, all }

final tagsStateProvider = StateProvider.autoDispose<TagsType>((ref) => TagsType.all);

final appliedFilterProvider = StateProvider<Map<String, dynamic>>((ref) => {});

final characterTagsProvider = FutureProvider.autoDispose<List<String>>((ref) async {
  final response = await ref.watch(gameAssetProvider.notifier).fetchCharacters();
  switch (response) {
    case GameAssetStateLoaded():
      return response.characters?.map((e) => e.name).toList() ?? [];
    default:
      return [];
  }
});

final speedrunTagsProvider = Provider.autoDispose<List<String>>((ref) => [
      'Vaporize',
      'Freeze',
      'Melt',
      'Spread/Aggravate',
      'Bloom',
      'Overload',
      'Eletro Charged',
      'Geo carry',
      'Anemo carry',
      'Physical carry',
      'Mono cyro',
      'Mono hydro',
      'Mono electro',
      'Mono pyro',
      'Burn'
    ]);

final elementTagsProvider = Provider.autoDispose<List<String>>((ref) => [
      'Hydro',
      'Pyro',
      'Electro',
      'Cryo',
      'Anemo',
      'Geo',
      'Dendro',
    ]);
