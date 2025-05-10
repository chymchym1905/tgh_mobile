import 'package:tgh_mobile/imports.dart';

class TableHeaderAbyss extends StatelessWidget {
  const TableHeaderAbyss({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 10.wr),
        //verified column
        if (MediaQuery.of(context).size.width > tableThresholdWidth) ...[
          verifiedColumn(context),
          SizedBox(width: 10.wr),
        ],
        //abyss version column
        abyssVersionColumn(context),
        SizedBox(width: 10.wr),
        //time column
        if (MediaQuery.of(context).size.width > tableThresholdWidth) ...[
          timeColumn(context),
          SizedBox(width: 10.wr),
        ],
        //chamber column
        chamberColumn(context),
        SizedBox(width: 10.wr),
        //team column
        if (MediaQuery.of(context).size.width < tableThresholdWidth) ...[
          teamColumn(context),
        ] else ...[
          team1or2Column(context, 1),
          team1or2Column(context, 2),
        ],
        SizedBox(width: 10.wr),
        //options column
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
          verifiedColumn(context),
          SizedBox(width: 10.wr),
        ],
        domainColumn(context),
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
          verifiedColumn(context),
          SizedBox(width: 10.wr),
        ],
        eventColumn(context),
        SizedBox(width: 10.wr),
        eventStageColumn(context),
        SizedBox(width: 10.wr),
        if (MediaQuery.of(context).size.width > tableThresholdWidth) ...[
          timeColumn(context),
          SizedBox(width: 10.wr),
        ],
        if (MediaQuery.of(context).size.width < tableThresholdWidth) ...[
          teamColumn(context)
        ] else ...[
          team1or2Column(context, 1),
          team1or2Column(context, 2),
        ],
        SizedBox(width: 10.wr),
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
          verifiedColumn(context),
          SizedBox(width: 10.wr),
        ],
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
        if (MediaQuery.of(context).size.width > kMaxWidthMobile) ...[
          optionsColumn(context),
          SizedBox(width: 10.wr),
        ]
      ],
    );
  }
}
