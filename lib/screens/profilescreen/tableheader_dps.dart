import 'package:tgh_mobile/imports.dart';
import '../../utils/colsinfo.dart';

class TableHeaderDps extends StatelessWidget {
  const TableHeaderDps({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 10.wr),
        Expanded(
            flex: colDps[0],
            child: Center(
                child: Text('Game version',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold)))),
        SizedBox(width: 10.wr),
        Expanded(
            flex: colDps[1],
            child: Center(
                child: Text('Enemy',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold)))),
        SizedBox(width: 10.wr),
        Expanded(
            flex: colDps[2],
            child: Center(
                child: Text('Nuker',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold)))),
        SizedBox(width: 10.wr),
        Expanded(
            flex: colDps[3],
            child: Center(
                child: Text('Supports',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold)))),
        SizedBox(width: 10.wr),
        Expanded(
            flex: colDps[4],
            child: Center(
                child: Text('Damage',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold)))),
        SizedBox(width: 10.wr),
        if (MediaQuery.of(context).size.width > kMaxWidthMobile) ...[
          Expanded(
              flex: colDps[5],
              child: Center(
                  child: Text('Options',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold)))),
          SizedBox(width: 10.wr)
        ]
      ],
    );
  }
}
