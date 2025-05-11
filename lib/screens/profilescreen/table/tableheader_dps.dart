import 'package:tgh_mobile/imports.dart';

class TableHeaderDps extends StatelessWidget {
  const TableHeaderDps({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 10.wr),
        if (MediaQuery.of(context).size.width > kMaxWidthMobile) ...[
          verifiedColumn(context),
          SizedBox(width: 10.wr),
        ],
        gameVersionColumn(context),
        SizedBox(width: 10.wr),
        enemyColumn(context),
        SizedBox(width: 10.wr),
        nukerColumn(context),
        SizedBox(width: 10.wr),
        supportsColumn(context),
        SizedBox(width: 10.wr),
        damageColumn(context),
        SizedBox(width: 10.wr),
        if (MediaQuery.of(context).size.width > kMaxWidthMobile) ...[optionsColumn(context), SizedBox(width: 10.wr)]
      ],
    );
  }
}

class TableHeaderDpsEvent extends StatelessWidget {
  const TableHeaderDpsEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 10.wr),
        if (MediaQuery.of(context).size.width > kMaxWidthMobile) ...[
          verifiedColumn(context),
          SizedBox(width: 10.wr),
        ],
        gameVersionColumn(context),
        SizedBox(width: 10.wr),
        eventColumn(context),
        SizedBox(width: 10.wr),
        nukerColumn(context),
        SizedBox(width: 10.wr),
        supportsColumn(context),
        SizedBox(width: 10.wr),
        damageColumn(context),
        SizedBox(width: 10.wr),
        if (MediaQuery.of(context).size.width > kMaxWidthMobile) ...[optionsColumn(context), SizedBox(width: 10.wr)]
      ],
    );
  }
}
