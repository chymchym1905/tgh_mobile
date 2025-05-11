import 'package:tgh_mobile/imports.dart';

class TableRowSpeedrunAbyss extends StatelessWidget {
  const TableRowSpeedrunAbyss({super.key, required this.speedrun});
  final Speedrun speedrun;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: 10.wr),
            child: Row(children: [
              SizedBox(width: 10.wr),
              //verified column
              if (MediaQuery.of(context).size.width > tableThresholdWidth) ...[
                verifiedColumnContent(context, speedrun.approved),
                SizedBox(width: 10.wr),
              ],
              //abyss version column
              abyssVersionColumnContent(context, speedrun.abyssVersion),
              SizedBox(width: 10.wr),
              //time column
              if (MediaQuery.of(context).size.width > tableThresholdWidth) ...[
                timeColumnContent(context, speedrun.time),
                SizedBox(width: 10.wr),
              ],
              //chamber column
              subCategoryColumnContent(context, speedrun.speedrunSubcategory),
              SizedBox(width: 10.wr),
              //team column
              if (MediaQuery.of(context).size.width < tableThresholdWidth) ...[
                teamColumnContent(context, speedrun.team1, speedrun.team2),
              ] else ...[
                team1ColumnContent(context, speedrun.team1),
                team2ColumnContent(context, speedrun.team2),
              ],
              SizedBox(width: 10.wr),
              //options column
              if (MediaQuery.of(context).size.width > kMaxWidthMobile) ...[
                optionsColumnContent(context),
                SizedBox(width: 10.wr),
              ]
            ])),
        Divider(color: Theme.of(context).colorScheme.outline, thickness: 1, height: 0),
      ],
    );
  }
}

class TableRowSpeedrunEvent extends StatelessWidget {
  const TableRowSpeedrunEvent({super.key, required this.speedrun});
  final Speedrun speedrun;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: 10.wr),
            child: Row(children: [
              SizedBox(width: 10.wr),
              if (MediaQuery.of(context).size.width > tableThresholdWidth) ...[
                verifiedColumnContent(context, speedrun.approved),
                SizedBox(width: 10.wr),
              ],
              eventColumnContent(context, speedrun.abyssVersion),
              SizedBox(width: 10.wr),
              subCategoryColumnContent(context, speedrun.speedrunSubcategory),
              SizedBox(width: 10.wr),
              if (MediaQuery.of(context).size.width > tableThresholdWidth) ...[
                timeColumnContent(context, speedrun.time),
                SizedBox(width: 10.wr),
              ],
              if (MediaQuery.of(context).size.width < tableThresholdWidth) ...[
                teamColumnContent(context, speedrun.team1, speedrun.team2),
              ] else ...[
                team1ColumnContent(context, speedrun.team1),
                team2ColumnContent(context, speedrun.team2),
              ],
              SizedBox(width: 10.wr),
              if (MediaQuery.of(context).size.width > kMaxWidthMobile) ...[
                optionsColumnContent(context),
                SizedBox(width: 10.wr),
              ]
            ])),
        Divider(color: Theme.of(context).colorScheme.outline, thickness: 1, height: 0),
      ],
    );
  }
}

class TableRowSpeedrunDomain extends StatelessWidget {
  const TableRowSpeedrunDomain({super.key, required this.speedrun});
  final Speedrun speedrun;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: 10.wr),
            child: Row(children: [
              SizedBox(width: 10.wr),
              if (MediaQuery.of(context).size.width > tableThresholdWidth) ...[
                verifiedColumnContent(context, speedrun.approved),
                SizedBox(width: 10.wr),
              ],
              subCategoryColumnContent(context, speedrun.speedrunSubcategory),
              SizedBox(width: 10.wr),
              timeColumnContent(context, speedrun.time),
              SizedBox(width: 10.wr),
              if (MediaQuery.of(context).size.width < tableThresholdWidth) ...[
                teamColumnContent(context, speedrun.team1, speedrun.team2),
              ] else ...[
                team1ColumnContent(context, speedrun.team1),
                team2ColumnContent(context, speedrun.team2),
              ],
              SizedBox(width: 10.wr),
              if (MediaQuery.of(context).size.width > kMaxWidthMobile) ...[
                optionsColumnContent(context),
                SizedBox(width: 10.wr),
              ]
            ])),
        Divider(color: Theme.of(context).colorScheme.outline, thickness: 1, height: 0),
      ],
    );
  }
}

class TableRowSpeedrunBoss extends StatelessWidget {
  const TableRowSpeedrunBoss({super.key, required this.speedrun});
  final Speedrun speedrun;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: 10.wr),
            child: Row(children: [
              SizedBox(width: 10.wr),
              if (MediaQuery.of(context).size.width > tableThresholdWidth) ...[
                verifiedColumnContent(context, speedrun.approved),
                SizedBox(width: 10.wr),
              ],
              subCategoryColumnContent(context, speedrun.speedrunSubcategory),
              SizedBox(width: 10.wr),
              timeColumnContent(context, speedrun.time),
              SizedBox(width: 10.wr),
              if (MediaQuery.of(context).size.width < tableThresholdWidth) ...[
                teamColumnContent(context, speedrun.team1, speedrun.team2),
              ] else ...[
                team1ColumnContent(context, speedrun.team1),
                team2ColumnContent(context, speedrun.team2),
              ],
              SizedBox(width: 10.wr),
              if (MediaQuery.of(context).size.width > kMaxWidthMobile) ...[
                optionsColumnContent(context),
                SizedBox(width: 10.wr),
              ]
            ])),
        Divider(color: Theme.of(context).colorScheme.outline, thickness: 1, height: 0),
      ],
    );
  }
}
