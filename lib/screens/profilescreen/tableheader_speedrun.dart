import 'package:tgh_mobile/imports.dart';

import 'colsinfo.dart';

class TableHeaderAbyss extends StatelessWidget {
  const TableHeaderAbyss({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 10.wr),
        Expanded(
            flex: colAbyssSpeedrun[0],
            child: Center(
                child: Text('Abyss version',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold)))),
        SizedBox(width: 10.wr),
        Expanded(
            flex: colAbyssSpeedrun[1],
            child: Center(
                child: Text('Chamber',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold)))),
        SizedBox(width: 10.wr),
        Expanded(
            flex: colAbyssSpeedrun[2],
            child: Center(
                child: Text('Team',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold)))),
        SizedBox(width: 10.wr),
        Expanded(
            flex: colAbyssSpeedrun[3],
            child: Center(
                child: Text('Options',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold)))),
        SizedBox(width: 10.wr)
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
        Expanded(
            flex: colDomainSpeedrun[0],
            child: Center(
                child: Text('Domain',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold)))),
        SizedBox(width: 10.wr),
        Expanded(
            flex: colDomainSpeedrun[1],
            child: Center(
                child: Text('Team',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold)))),
        SizedBox(width: 10.wr),
        Expanded(
            flex: colDomainSpeedrun[2],
            child: Center(
                child: Text('Options',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold)))),
        SizedBox(width: 10.wr)
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
        Expanded(
            flex: colEventSpeedrun[0],
            child: Center(
                child: Text('Event',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold)))),
        SizedBox(width: 10.wr),
        Expanded(
            flex: colEventSpeedrun[1],
            child: Center(
                child: Text('Stage',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold)))),
        SizedBox(width: 10.wr),
        Expanded(
            flex: colEventSpeedrun[2],
            child: Center(
                child: Text('Team',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold)))),
        SizedBox(width: 10.wr),
        Expanded(
            flex: colEventSpeedrun[3],
            child: Center(
                child: Text('Options',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold)))),
        SizedBox(width: 10.wr)
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
        Expanded(
            flex: colBossSpeedrun[0],
            child: Center(
                child: Text('Enemy',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold)))),
        SizedBox(width: 10.wr),
        Expanded(
            flex: colBossSpeedrun[1],
            child: Center(
                child: Text('Team',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold)))),
        SizedBox(width: 10.wr),
        Expanded(
            flex: colBossSpeedrun[2],
            child: Center(
                child: Text('Options',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold)))),
        SizedBox(width: 10.wr)
      ],
    );
  }
}
