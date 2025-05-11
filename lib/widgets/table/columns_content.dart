import 'package:tgh_mobile/imports.dart';
import 'package:collection/collection.dart';

Widget verifiedColumnContent(BuildContext context, bool verified) {
  return Expanded(
      flex: 1,
      child: Center(
          child: Padding(
              padding: EdgeInsets.all(2.sp),
              child: verified
                  ? const Icon(Icons.verified, fill: 1, color: Colors.green)
                  : const Icon(Icons.cancel_rounded, fill: 1, color: Colors.red))));
}

Widget rankColumnContent(BuildContext context, String? rank) {
  return Expanded(
      flex: 1,
      child: Center(
          child: Text(rank ?? '',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold))));
}

Widget abyssVersionColumnContent(BuildContext context, String? abyssVersion) {
  return Expanded(
      flex: 1,
      child: Center(
          child: Text(abyssVersion ?? '',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold))));
}

Widget eventColumnContent(BuildContext context, String? event) {
  return Expanded(
      flex: 2,
      child: Center(
          child: Text(event ?? '',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold))));
}

Widget timeColumnContent(BuildContext context, int time) {
  return Expanded(
      flex: 1,
      child: Center(
          child: Text(parseTime(time),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold))));
}

Widget subCategoryColumnContent(BuildContext context, String? subCategory) {
  return Expanded(
      flex: 1,
      child: Center(
          child: Text(subCategory ?? '',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold))));
}

Widget teamColumnContent(BuildContext context, List<String?> team1, List<String?>? team2) {
  return Consumer(builder: (context, ref, child) {
    final assets = ref.read(gameAssetProvider);
    return Expanded(
        flex: MediaQuery.of(context).size.width > kMaxWidthMobile ? 4 : 3,
        child: Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
          if (team1.isNotEmpty)
            Center(
                child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 4.wr,
                    children: team1
                        .map((e) => assets.maybeWhen(
                            data: (data) {
                              switch (data) {
                                case GameAssetStateLoaded(:final characters):
                                  return UniformCircleAvatar(
                                      url: characters?.firstWhereOrNull((element) => element.name == e)?.avatar ?? '',
                                      radius: 13.wr);
                                default:
                                  return UniformCircleAvatar(url: '', radius: 13.wr);
                              }
                            },
                            orElse: () => UniformCircleAvatar(url: '', radius: 13.wr)))
                        .toList())),
          if (team2 != null && team2.isNotEmpty)
            Padding(
                padding: EdgeInsets.only(top: 4.wr),
                child: Center(
                    child: Wrap(
                        direction: Axis.horizontal,
                        spacing: 4.wr,
                        children: team2
                            .map((e) => assets.maybeWhen(
                                data: (data) {
                                  switch (data) {
                                    case GameAssetStateLoaded(:final characters):
                                      return UniformCircleAvatar(
                                          url: characters!.firstWhereOrNull((element) => element.name == e)?.avatar ??
                                              '',
                                          radius: 13.wr);
                                    default:
                                      return UniformCircleAvatar(url: '', radius: 13.wr);
                                  }
                                },
                                orElse: () => UniformCircleAvatar(url: '', radius: 13.wr)))
                            .toList())))
        ])));
  });
}

Widget team1ColumnContent(BuildContext context, List<String?> team1) {
  return Consumer(builder: (context, ref, child) {
    final assets = ref.read(gameAssetProvider);
    return Expanded(
        flex: 4,
        child: Center(
            child: team1.isNotEmpty
                ? Wrap(
                    direction: Axis.horizontal,
                    spacing: 4.wr,
                    children: team1
                        .map((e) => assets.maybeWhen(
                            data: (data) {
                              switch (data) {
                                case GameAssetStateLoaded(:final characters):
                                  return UniformCircleAvatar(
                                      url: characters?.firstWhereOrNull((element) => element.name == e)?.avatar ?? '',
                                      radius: 13.wr);
                                default:
                                  return UniformCircleAvatar(url: '', radius: 13.wr);
                              }
                            },
                            orElse: () => UniformCircleAvatar(url: '', radius: 13.wr)))
                        .toList())
                : const SizedBox.shrink()));
  });
}

Widget team2ColumnContent(BuildContext context, List<String?>? team2) {
  return Consumer(builder: (context, ref, child) {
    final assets = ref.read(gameAssetProvider);
    return Expanded(
        flex: 4,
        child: Center(
            child: team2 != null && team2.isNotEmpty
                ? Wrap(
                    direction: Axis.horizontal,
                    spacing: 4.wr,
                    children: team2
                        .map((e) => assets.maybeWhen(
                            data: (data) {
                              switch (data) {
                                case GameAssetStateLoaded(:final characters):
                                  return UniformCircleAvatar(
                                      url: characters?.firstWhereOrNull((element) => element.name == e)?.avatar ?? '',
                                      radius: 13.wr);
                                default:
                                  return UniformCircleAvatar(url: '', radius: 13.wr);
                              }
                            },
                            orElse: () => UniformCircleAvatar(url: '', radius: 13.wr)))
                        .toList())
                : const SizedBox.shrink()));
  });
}

Widget characterUsageColumnContent(BuildContext context, List<CharacterUsage>? characterUsage) {
  return Consumer(builder: (context, ref, child) {
    final assets = ref.read(gameAssetProvider);
    return Expanded(
        flex: 4,
        child: Center(
            child: characterUsage != null && characterUsage.isNotEmpty
                ? Wrap(
                    direction: Axis.horizontal,
                    spacing: 4.wr,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                        ...characterUsage.take(3).map((e) => assets.maybeWhen(
                            data: (data) {
                              switch (data) {
                                case GameAssetStateLoaded(:final characters):
                                  return UniformCircleAvatar(
                                      url: characters!.firstWhere((element) => element.name == e.character).avatar!,
                                      radius: 13.wr);
                                default:
                                  return UniformCircleAvatar(url: '', radius: 13.wr);
                              }
                            },
                            orElse: () => UniformCircleAvatar(url: '', radius: 13.wr))),
                        if (characterUsage.length > 3) Icon(Icons.more_horiz, size: 13.wr * 2)
                      ])
                : const SizedBox.shrink()));
  });
}

Widget optionsColumnContent(BuildContext context, {void Function()? onTap}) {
  return Expanded(
      flex: 1,
      child: Center(
          child: Material(
              shape: const CircleBorder(),
              color: Colors.transparent,
              child: InkWell(
                  onTap: onTap,
                  onLongPress: () {},
                  borderRadius: BorderRadius.circular(50),
                  child: Ink(
                      child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(Icons.more_vert, size: 20.wr),
                  ))))));
}

Widget enemyColumnContent(BuildContext context, String? enemy) {
  return Expanded(
      flex: 2,
      child: Center(
          child: Text(enemy ?? '',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold))));
}

Widget gameVersionColumnContent(BuildContext context, String? gameVersion) {
  return Expanded(
      flex: 1,
      child: Center(
          child: Text(gameVersion ?? '',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold))));
}

Widget nukerColumnContent(BuildContext context, String dpsCharacter) {
  return Consumer(builder: (context, ref, child) {
    final assets = ref.read(gameAssetProvider);
    return Expanded(
        flex: 1,
        child: Center(
            child: assets.maybeWhen(
          data: (data) {
            switch (data) {
              case GameAssetStateLoaded(:final characters):
                return UniformCircleAvatar(
                    url: characters!.firstWhere((element) => element.name == dpsCharacter).avatar!, radius: 13.wr);
              default:
                return UniformCircleAvatar(url: '', radius: 13.wr);
            }
          },
          orElse: () => UniformCircleAvatar(url: '', radius: 13.wr),
        )));
  });
}

Widget supportsColumnContent(BuildContext context, List<String?> supports) {
  return Consumer(builder: (context, ref, child) {
    final assets = ref.read(gameAssetProvider);
    return Expanded(
        flex: 4,
        child: Center(
            child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: Axis.horizontal,
                spacing: 4.wr,
                children: [
              ...supports.take(3).map((e) => assets.maybeWhen(
                  data: (data) {
                    switch (data) {
                      case GameAssetStateLoaded(:final characters):
                        return UniformCircleAvatar(
                            url: characters!.firstWhere((element) => element.name == e).avatar!, radius: 13.wr);
                      default:
                        return UniformCircleAvatar(url: '', radius: 13.wr);
                    }
                  },
                  orElse: () => UniformCircleAvatar(url: '', radius: 13.wr))),
              if (supports.length > 3) ...[
                Icon(Icons.more_horiz, size: 13.wr),
              ],
            ])));
  });
}

Widget damageColumnContent(BuildContext context, int damageDealt) {
  return Expanded(
      flex: 2,
      child: Center(
          child: Text(damageDealt.toInt().toString(),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold))));
}

Widget attackTypeColumnContent(BuildContext context, String char, String attackType) {
  return Consumer(builder: (context, ref, child) {
    final assets = ref.read(gameAssetProvider);
    return Expanded(
        flex: 1,
        child: Center(
            child: assets.maybeWhen(
          data: (data) {
            switch (data) {
              case GameAssetStateLoaded(:final characters):
                final character = characters!.firstWhere((element) => element.name == char);
                // Map attackType to the corresponding field in Character model
                String abilityName = '';
                switch (attackType) {
                  case 'normal_attack':
                    abilityName = character.normalAttackTalent ?? '';
                  case 'charged_attack':
                    abilityName = character.normalAttackTalent ?? '';
                  case 'plunge_attack':
                    abilityName = character.normalAttackTalent ?? '';
                    break;
                  case 'elemental_skill':
                    abilityName = character.elementalSkillTalent ?? '';
                    break;
                  case 'elemental_burst':
                    abilityName = character.elementalBurstTalent ?? '';
                  default:
                    abilityName = attackType;
                }
                return UniformCircleAvatar(url: abilityName, radius: 13.wr);
              default:
                return UniformCircleAvatar(url: '', radius: 13.wr);
            }
          },
          orElse: () => UniformCircleAvatar(url: '', radius: 13.wr),
        )));
  });
}

Widget userColumnContent(BuildContext context, String pfpurl, String alias) {
  return Expanded(
      flex: 2,
      child: Center(
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        UniformCircleAvatar(url: pfpUrl(pfpurl), radius: 13.wr),
        const SizedBox(height: 6),
        Text(alias,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold))
      ])));
}
