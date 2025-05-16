import 'package:tgh_mobile/imports.dart';

class TableheaderStandings extends StatelessWidget {
  const TableheaderStandings({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 10.wr),
        abyssVersionColumn(context),
        SizedBox(width: 10.wr),
        rankColumn(context),
        SizedBox(width: 10.wr),
        pointsColumn(context),
        SizedBox(width: 10.wr),
        breakdownColumn(context, MediaQuery.of(context).size.width > kMaxWidthMobile ? 5 : 4),
        SizedBox(width: 10.wr),
      ],
    );
  }
}
