import 'package:tgh_mobile/imports.dart';

class TableHeaderAbyss extends StatelessWidget {
  const TableHeaderAbyss({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 10.wr),
        if (MediaQuery.of(context).size.width > tableThresholdWidth) ...[
          rankColumn(context),
          SizedBox(width: 10.wr),
        ],
        userColumn(context),
        SizedBox(width: 10.wr),
        timeColumn(context),
        SizedBox(width: 10.wr),
        chamberColumn(context),
        SizedBox(width: 10.wr),
        if (MediaQuery.of(context).size.width < tableThresholdWidth) ...[
          teamColumn(context),
        ] else ...[
          team1or2Column(context, 1),
          team1or2Column(context, 2),
        ],
        SizedBox(width: 10.wr),
        if (MediaQuery.of(context).size.width > tableThresholdWidth) ...[
          characterUsageColumn(context),
          SizedBox(width: 10.wr),
        ],
        if (MediaQuery.of(context).size.width > kMaxWidthMobile) ...[
          optionsColumn(context),
          SizedBox(width: 10.wr),
        ]
      ],
    );
  }
}

class TableHeaderDomain extends StatelessWidget {
  const TableHeaderDomain({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 10.wr),
        if (MediaQuery.of(context).size.width > tableThresholdWidth) ...[
          rankColumn(context),
          SizedBox(width: 10.wr),
        ],
        userColumn(context),
        SizedBox(width: 10.wr),
        timeColumn(context),
        SizedBox(width: 10.wr),
        if (MediaQuery.of(context).size.width < tableThresholdWidth) ...[
          teamColumn(context),
        ] else ...[
          team1or2Column(context, 1),
          team1or2Column(context, 2),
        ],
        SizedBox(width: 10.wr),
        if (MediaQuery.of(context).size.width > tableThresholdWidth) ...[
          characterUsageColumn(context),
          SizedBox(width: 10.wr),
        ],
        if (MediaQuery.of(context).size.width > kMaxWidthMobile) ...[
          optionsColumn(context),
          SizedBox(width: 10.wr),
        ]
      ],
    );
  }
}

class TableHeaderEvent extends StatelessWidget {
  const TableHeaderEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 10.wr),
        if (MediaQuery.of(context).size.width > tableThresholdWidth) ...[
          rankColumn(context),
          SizedBox(width: 10.wr),
        ],
        userColumn(context),
        SizedBox(width: 10.wr),
        timeColumn(context),
        SizedBox(width: 10.wr),
        eventStageColumn(context),
        SizedBox(width: 10.wr),
        if (MediaQuery.of(context).size.width < tableThresholdWidth) ...[
          teamColumn(context),
        ] else ...[
          team1or2Column(context, 1),
          team1or2Column(context, 2),
        ],
        SizedBox(width: 10.wr),
        if (MediaQuery.of(context).size.width > tableThresholdWidth) ...[
          characterUsageColumn(context),
          SizedBox(width: 10.wr),
        ],
        if (MediaQuery.of(context).size.width > kMaxWidthMobile) ...[
          optionsColumn(context),
          SizedBox(width: 10.wr),
        ]
      ],
    );
  }
}

class TableHeaderBoss extends StatelessWidget {
  const TableHeaderBoss({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 10.wr),
        if (MediaQuery.of(context).size.width > tableThresholdWidth) ...[
          rankColumn(context),
          SizedBox(width: 10.wr),
        ],
        userColumn(context),
        SizedBox(width: 10.wr),
        enemyColumn(context),
        SizedBox(width: 10.wr),
        timeColumn(context),
        SizedBox(width: 10.wr),
        if (MediaQuery.of(context).size.width < tableThresholdWidth) ...[
          teamColumn(context)
        ] else ...[
          team1or2Column(context, 1),
          team1or2Column(context, 2),
        ],
        SizedBox(width: 10.wr),
        if (MediaQuery.of(context).size.width > tableThresholdWidth) ...[
          characterUsageColumn(context),
          SizedBox(width: 10.wr),
        ],
        if (MediaQuery.of(context).size.width > kMaxWidthMobile) ...[
          optionsColumn(context),
          SizedBox(width: 10.wr),
        ]
      ],
    );
  }
}
