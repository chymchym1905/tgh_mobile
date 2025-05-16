import 'package:tgh_mobile/imports.dart';

class TableRowStandings extends StatelessWidget {
  const TableRowStandings({super.key, required this.spot, required this.characterUsage});
  final SpeedrunLbSpot spot;
  final List<CharacterUsage> characterUsage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: 10.wr),
            child: Row(children: [
              SizedBox(width: 10.wr),
              rankColumnContent(context, spot.rank.toString()),
              SizedBox(width: 10.wr),
              userColumnContent(context, spot.competitor.id, spot.alias ?? ''),
              SizedBox(width: 10.wr),
              regionColumnContent(context, spot.region),
              SizedBox(width: 10.wr),
              breakdownColumnContent(context, spot.breakdown, MediaQuery.of(context).size.width > 970 ? 8 : 5),
              SizedBox(width: 10.wr),
              if (MediaQuery.of(context).size.width > 970) ...[
                characterUsageColumnContent(context, characterUsage, flex: 3),
                SizedBox(width: 10.wr),
              ]
            ])),
        Divider(color: Theme.of(context).colorScheme.outline, thickness: 1, height: 0),
      ],
    );
  }
}
