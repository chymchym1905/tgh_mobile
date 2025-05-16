import 'package:tgh_mobile/imports.dart';

class TableRowStandings extends StatelessWidget {
  const TableRowStandings({super.key, required this.rankInfo});
  final RankInfo rankInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: 10.wr),
            child: Row(children: [
              SizedBox(width: 10.wr),
              abyssVersionColumnContent(context, rankInfo.version),
              SizedBox(width: 10.wr),
              rankColumnContent(context, rankInfo.rank.rank.toString()),
              SizedBox(width: 10.wr),
              pointsColumnContent(context, rankInfo.rank.points),
              SizedBox(width: 10.wr),
              breakdownColumnContent(
                  context, rankInfo.rank.breakdown, MediaQuery.of(context).size.width > kMaxWidthMobile ? 5 : 4),
              SizedBox(width: 10.wr)
            ])),
        Divider(color: Theme.of(context).colorScheme.outline, thickness: 1, height: 0),
      ],
    );
  }
}
