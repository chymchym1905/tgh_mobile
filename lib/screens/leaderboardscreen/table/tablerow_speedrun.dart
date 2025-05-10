import 'package:tgh_mobile/imports.dart';

class TableRowAbyss extends StatelessWidget {
  const TableRowAbyss({super.key, required this.speedrun, this.rank, this.characterUsage});
  final Speedrun speedrun;
  final List<CharacterUsage>? characterUsage;
  final String? rank;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: 10.wr),
            child: Row(children: [
              SizedBox(width: 10.wr),
              rankColumnContent(context, rank ?? ''),
              SizedBox(width: 10.wr),
              timeColumnContent(context, speedrun.time),
              SizedBox(width: 10.wr),
              subCategoryColumnContent(context, speedrun.speedrunSubcategory ?? ''),
              SizedBox(width: 10.wr),
              SizedBox(width: 10.wr),
              if (MediaQuery.of(context).size.width < tableThresholdWidth) ...[
                teamColumnContent(context, speedrun.team1, speedrun.team2),
                SizedBox(width: 10.wr),
              ] else ...[
                team1ColumnContent(context, speedrun.team1),
                team2ColumnContent(context, speedrun.team2),
              ],
              if (MediaQuery.of(context).size.width > tableThresholdWidth) ...[
                characterUsageColumnContent(context, characterUsage),
                SizedBox(width: 10.wr),
              ],
              if (MediaQuery.of(context).size.width > kMaxWidthMobile) ...[
                optionsColumnContent(context),
                SizedBox(width: 10.wr)
              ]
            ])),
        Divider(color: Theme.of(context).colorScheme.outline, thickness: 1, height: 0),
      ],
    );
  }
}

class TableRowDomain extends StatelessWidget {
  const TableRowDomain({super.key, required this.speedrun, this.rank, this.characterUsage});
  final Speedrun speedrun;
  final List<CharacterUsage>? characterUsage;
  final String? rank;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: 10.wr),
            child: Row(children: [
              SizedBox(width: 10.wr),
              rankColumnContent(context, rank ?? ''),
              SizedBox(width: 10.wr),
              timeColumnContent(context, speedrun.time),
              SizedBox(width: 10.wr),
              if (MediaQuery.of(context).size.width < tableThresholdWidth) ...[
                teamColumnContent(context, speedrun.team1, speedrun.team2),
                SizedBox(width: 10.wr),
              ] else ...[
                team1ColumnContent(context, speedrun.team1),
                team2ColumnContent(context, speedrun.team2),
              ],
              SizedBox(width: 10.wr),
              if (MediaQuery.of(context).size.width > tableThresholdWidth) ...[
                characterUsageColumnContent(context, characterUsage),
                SizedBox(width: 10.wr),
              ],
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

class TableRowEvent extends StatelessWidget {
  const TableRowEvent({super.key, required this.speedrun, this.rank, this.characterUsage});
  final Speedrun speedrun;
  final List<CharacterUsage>? characterUsage;
  final String? rank;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: 10.wr),
            child: Row(children: [
              SizedBox(width: 10.wr),
              rankColumnContent(context, rank ?? ''),
              SizedBox(width: 10.wr),
              timeColumnContent(context, speedrun.time),
              SizedBox(width: 10.wr),
              subCategoryColumnContent(context, speedrun.speedrunSubcategory ?? ''),
              SizedBox(width: 10.wr),
              if (MediaQuery.of(context).size.width < tableThresholdWidth) ...[
                teamColumnContent(context, speedrun.team1, speedrun.team2),
                SizedBox(width: 10.wr),
              ] else ...[
                team1ColumnContent(context, speedrun.team1),
                team2ColumnContent(context, speedrun.team2),
              ],
              SizedBox(width: 10.wr),
              if (MediaQuery.of(context).size.width > tableThresholdWidth) ...[
                characterUsageColumnContent(context, characterUsage),
                SizedBox(width: 10.wr),
              ],
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

class TableRowBoss extends StatelessWidget {
  const TableRowBoss({super.key, required this.speedrun, this.rank, this.characterUsage});
  final Speedrun speedrun;
  final List<CharacterUsage>? characterUsage;
  final String? rank;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: 10.wr),
            child: Row(children: [
              SizedBox(width: 10.wr),
              rankColumnContent(context, rank ?? ''),
              SizedBox(width: 10.wr),
              enemyColumnContent(context, speedrun.speedrunSubcategory ?? ''),
              SizedBox(width: 10.wr),
              timeColumnContent(context, speedrun.time),
              SizedBox(width: 10.wr),
              if (MediaQuery.of(context).size.width < tableThresholdWidth) ...[
                teamColumnContent(context, speedrun.team1, speedrun.team2),
                SizedBox(width: 10.wr),
              ] else ...[
                team1ColumnContent(context, speedrun.team1),
                team2ColumnContent(context, speedrun.team2),
              ],
              SizedBox(width: 10.wr),
              if (MediaQuery.of(context).size.width > tableThresholdWidth) ...[
                characterUsageColumnContent(context, characterUsage),
                SizedBox(width: 10.wr),
              ],
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
