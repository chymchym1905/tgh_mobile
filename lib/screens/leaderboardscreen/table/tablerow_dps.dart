import 'package:tgh_mobile/imports.dart';

class TableRowDps extends StatelessWidget {
  const TableRowDps({super.key, required this.dps, this.characterUsage, this.rank});

  final DPS dps;
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
              if (MediaQuery.of(context).size.width > kMaxWidthMobile) ...[
                rankColumnContent(context, rank ?? ''),
                SizedBox(width: 10.wr),
              ],
              userColumnContent(context, dps.competitor.id, dps.competitor.alias),
              SizedBox(width: 10.wr),
              gameVersionColumnContent(context, dps.gameVersion),
              SizedBox(width: 10.wr),
              enemyColumnContent(context, dps.enemy),
              SizedBox(width: 10.wr),
              nukerColumnContent(context, dps.dpsCharacter),
              SizedBox(width: 10.wr),
              if (MediaQuery.of(context).size.width > kMaxWidthMobile) ...[
                supportsColumnContent(context, dps.team),
                SizedBox(width: 10.wr),
              ],
              damageColumnContent(context, dps.damageDealt),
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

class TableRowDpsEvent extends StatelessWidget {
  const TableRowDpsEvent({super.key, required this.dps, this.characterUsage, this.rank});

  final DPS dps;
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
              if (MediaQuery.of(context).size.width > kMaxWidthMobile) ...[
                rankColumnContent(context, rank ?? ''),
                SizedBox(width: 10.wr),
              ],
              userColumnContent(context, dps.competitor.id, dps.competitor.alias),
              SizedBox(width: 10.wr),
              gameVersionColumnContent(context, dps.gameVersion),
              SizedBox(width: 10.wr),
              abyssVersionColumnContent(context, dps.event),
              SizedBox(width: 10.wr),
              nukerColumnContent(context, dps.dpsCharacter),
              SizedBox(width: 10.wr),
              if (MediaQuery.of(context).size.width > kMaxWidthMobile) ...[
                supportsColumnContent(context, dps.team),
                SizedBox(width: 10.wr),
              ],
              damageColumnContent(context, dps.damageDealt),
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
