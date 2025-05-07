import 'package:tgh_mobile/imports.dart';

import '../../shared/data_model/game_asset/game_asset_state.dart';
import '../../utils/colsinfo.dart';

class TableRowDps extends StatelessWidget {
  const TableRowDps({super.key, required this.dps});

  final DPS dps;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: 10.wr),
            child: Row(children: [
              SizedBox(width: 10.wr),
              Expanded(
                  flex: colDps[0],
                  child: Center(
                      child: Text(dps.gameVersion,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold)))),
              SizedBox(width: 10.wr),
              Expanded(
                  flex: colDps[1],
                  child: Center(
                      child: Text(dps.enemy,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold)))),
              SizedBox(width: 10.wr),
              Consumer(builder: (context, ref, child) {
                final assets = ref.read(gameAssetProvider);
                return Expanded(
                    flex: colDps[2],
                    child: Center(
                        child: assets.maybeWhen(
                      data: (data) {
                        switch (data) {
                          case GameAssetStateLoaded(:final characters):
                            return UniformCircleAvatar(
                                url: characters!.firstWhere((element) => element.name == dps.dpsCharacter).avatar!,
                                radius: 13.wr);
                          default:
                            return UniformCircleAvatar(url: '', radius: 13.wr);
                        }
                      },
                      orElse: () => UniformCircleAvatar(url: '', radius: 13.wr),
                    )));
              }),
              SizedBox(width: 10.wr),
              Consumer(builder: (context, ref, child) {
                final assets = ref.read(gameAssetProvider);
                return Expanded(
                    flex: colDps[3],
                    child: Center(
                        child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.end,
                            direction: Axis.horizontal,
                            spacing: 4.wr,
                            children: [
                          ...dps.team.take(3).map((e) => assets.maybeWhen(
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
                              orElse: () => UniformCircleAvatar(url: '', radius: 13.wr))),
                          if (dps.team.length > 3) ...[
                            Icon(Icons.more_horiz, size: 13.wr),
                          ],
                        ])));
              }),
              SizedBox(width: 10.wr),
              Expanded(
                  flex: colDps[4],
                  child: Center(
                      child: Text(dps.damageDealt.toInt().toString(),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold)))),
              SizedBox(width: 10.wr),
              if (MediaQuery.of(context).size.width > kMaxWidthMobile) ...[
                Expanded(
                    flex: colDps[5],
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
