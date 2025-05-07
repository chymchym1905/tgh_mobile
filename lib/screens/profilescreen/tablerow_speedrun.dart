import 'package:tgh_mobile/imports.dart';

import '../../shared/data_model/game_asset/game_asset_state.dart';
import '../../utils/colsinfo.dart';

class TableRowAbyss extends StatelessWidget {
  const TableRowAbyss({super.key, required this.speedrun});
  final Speedrun speedrun;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: 10.wr),
            child: Row(children: [
              SizedBox(width: 10.wr),
              if (MediaQuery.of(context).size.width > thresholdWidth + 100) ...[
                Expanded(
                    flex: colAbyssSpeedrun[0],
                    child: Center(
                        child: Padding(
                            padding: EdgeInsets.all(2.sp),
                            child: speedrun.approved
                                ? const Icon(Icons.verified, fill: 1, color: Colors.green)
                                : const Icon(Icons.cancel_rounded, fill: 1, color: Colors.red)))),
                SizedBox(width: 10.wr),
              ],
              Expanded(
                  flex: colAbyssSpeedrun[0],
                  child: Center(
                      child: Text(speedrun.abyssVersion ?? '',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold)))),
              SizedBox(width: 10.wr),
              Expanded(
                  flex: colAbyssSpeedrun[1],
                  child: Center(
                      child: Text(speedrun.speedrunSubcategory ?? '',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold)))),
              SizedBox(width: 10.wr),
              if (MediaQuery.of(context).size.width < thresholdWidth) ...[
                Consumer(builder: (context, ref, child) {
                  final assets = ref.read(gameAssetProvider);
                  return Expanded(
                      flex: MediaQuery.of(context).size.width > kMaxWidthMobile ? colAbyssSpeedrun[2] : 3,
                      child: Center(
                          child: Column(mainAxisSize: MainAxisSize.min, children: [
                        if (speedrun.team1.isNotEmpty)
                          Center(
                            child: Wrap(
                                direction: Axis.horizontal,
                                spacing: 4.wr,
                                children: speedrun.team1
                                    .map((e) => assets.maybeWhen(
                                        data: (data) {
                                          switch (data) {
                                            case GameAssetStateLoaded(:final characters):
                                              return UniformCircleAvatar(
                                                  url: characters!.firstWhere((element) => element.name == e).avatar!,
                                                  radius: 13.wr);
                                            default:
                                              return UniformCircleAvatar(url: '', radius: 13.wr);
                                          }
                                        },
                                        orElse: () => UniformCircleAvatar(url: '', radius: 13.wr)))
                                    .toList()),
                          ),
                        if (speedrun.team2 != null && speedrun.team2!.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(top: 4.wr),
                            child: Center(
                              child: Wrap(
                                  direction: Axis.horizontal,
                                  spacing: 4.wr,
                                  children: speedrun.team2!
                                      .map((e) => assets.maybeWhen(
                                          data: (data) {
                                            switch (data) {
                                              case GameAssetStateLoaded(:final characters):
                                                return UniformCircleAvatar(
                                                    url: characters!.firstWhere((element) => element.name == e).avatar!,
                                                    radius: 13.wr);
                                              default:
                                                return UniformCircleAvatar(url: '', radius: 13.wr);
                                            }
                                          },
                                          orElse: () => UniformCircleAvatar(url: '', radius: 13.wr)))
                                      .toList()),
                            ),
                          ),
                      ])));
                }),
                SizedBox(width: 10.wr),
              ] else ...[
                Consumer(builder: (context, ref, child) {
                  final assets = ref.read(gameAssetProvider);
                  return Expanded(
                      flex: colAbyssSpeedrun[2],
                      child: Center(
                        child: speedrun.team1.isNotEmpty
                            ? Wrap(
                                direction: Axis.horizontal,
                                spacing: 4.wr,
                                children: speedrun.team1
                                    .map((e) => assets.maybeWhen(
                                        data: (data) {
                                          switch (data) {
                                            case GameAssetStateLoaded(:final characters):
                                              return UniformCircleAvatar(
                                                  url: characters!.firstWhere((element) => element.name == e).avatar!,
                                                  radius: 13.wr);
                                            default:
                                              return UniformCircleAvatar(url: '', radius: 13.wr);
                                          }
                                        },
                                        orElse: () => UniformCircleAvatar(url: '', radius: 13.wr)))
                                    .toList())
                            : const SizedBox.shrink(),
                      ));
                }),
                Consumer(builder: (context, ref, child) {
                  final assets = ref.read(gameAssetProvider);
                  return Expanded(
                      flex: colAbyssSpeedrun[2],
                      child: Center(
                        child: speedrun.team2 != null && speedrun.team2!.isNotEmpty
                            ? Wrap(
                                direction: Axis.horizontal,
                                spacing: 4.wr,
                                children: speedrun.team2!
                                    .map((e) => assets.maybeWhen(
                                        data: (data) {
                                          switch (data) {
                                            case GameAssetStateLoaded(:final characters):
                                              return UniformCircleAvatar(
                                                  url: characters!.firstWhere((element) => element.name == e).avatar!,
                                                  radius: 13.wr);
                                            default:
                                              return UniformCircleAvatar(url: '', radius: 13.wr);
                                          }
                                        },
                                        orElse: () => UniformCircleAvatar(url: '', radius: 13.wr)))
                                    .toList())
                            : const SizedBox.shrink(),
                      ));
                })
              ],
              if (MediaQuery.of(context).size.width > thresholdWidth + 100) ...[
                Expanded(
                    flex: colAbyssSpeedrun[3],
                    child: Center(
                        child: Text(parseTime(speedrun.time),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold)))),
                SizedBox(width: 10.wr),
              ],
              if (MediaQuery.of(context).size.width > kMaxWidthMobile) ...[
                Expanded(
                    flex: colAbyssSpeedrun[3],
                    child: Center(
                        child: Material(
                            shape: const CircleBorder(),
                            color: Colors.transparent,
                            child: InkWell(
                                onTap: () {},
                                onLongPress: () {},
                                borderRadius: BorderRadius.circular(50),
                                child: Ink(
                                    child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Icon(Icons.more_vert, size: 20.wr),
                                )))))),
                SizedBox(width: 10.wr)
              ]
            ])),
        Divider(color: Theme.of(context).colorScheme.outline, thickness: 1, height: 0),
      ],
    );
  }
}
