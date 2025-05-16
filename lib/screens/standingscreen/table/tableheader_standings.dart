import 'package:tgh_mobile/imports.dart';

class TableHeaderStandings extends StatelessWidget {
  const TableHeaderStandings({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 10.wr),
        rankColumn(context),
        SizedBox(width: 10.wr),
        userColumn(context),
        SizedBox(width: 10.wr),
        regionColumn(context),
        SizedBox(width: 10.wr),
        breakdownColumn(context, MediaQuery.of(context).size.width > 970 ? 8 : 5),
        SizedBox(width: 10.wr),
        if (MediaQuery.of(context).size.width > 970) ...[
          characterUsageColumn(context, flex: 3),
          SizedBox(width: 10.wr),
        ]
      ],
    );
  }
}
