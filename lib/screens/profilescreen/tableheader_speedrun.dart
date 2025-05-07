import 'package:tgh_mobile/imports.dart';

import '../../utils/colsinfo.dart';

class TableHeaderAbyss extends StatelessWidget {
  const TableHeaderAbyss({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 10.wr),
        if (MediaQuery.of(context).size.width > thresholdWidth + 100) ...[
          Expanded(
              flex: colAbyssSpeedrun[0],
              child: Center(
                  child: Text('Verified',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold)))),
          SizedBox(width: 10.wr),
        ],
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
        if (MediaQuery.of(context).size.width < thresholdWidth) ...[
          Expanded(
              flex: MediaQuery.of(context).size.width > kMaxWidthMobile ? colAbyssSpeedrun[2] : 3,
              child: Center(
                  child: Text('Team',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold))))
        ] else ...[
          Expanded(
              flex: colAbyssSpeedrun[2],
              child: Center(
                  child: Text('Team 1',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold)))),
          Expanded(
              flex: colAbyssSpeedrun[2],
              child: Center(
                  child: Text('Team 2',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold)))),
        ],
        SizedBox(width: 10.wr),
        if (MediaQuery.of(context).size.width > thresholdWidth + 100) ...[
          Expanded(
              flex: colAbyssSpeedrun[3],
              child: Center(
                  child: Text('Time',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold)))),
          SizedBox(width: 10.wr),
        ],
        if (MediaQuery.of(context).size.width > kMaxWidthMobile) ...[
          Expanded(
              flex: colAbyssSpeedrun[3],
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
        if (MediaQuery.of(context).size.width < thresholdWidth) ...[
          Expanded(
              flex: MediaQuery.of(context).size.width > kMaxWidthMobile ? colAbyssSpeedrun[2] : 3,
              child: Center(
                  child: Text('Team',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold))))
        ] else ...[
          Expanded(
              flex: colAbyssSpeedrun[2],
              child: Center(
                  child: Text('Team 1',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold)))),
          Expanded(
              flex: colAbyssSpeedrun[2],
              child: Center(
                  child: Text('Team 2',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold)))),
        ],
        SizedBox(width: 10.wr),
        if (MediaQuery.of(context).size.width > thresholdWidth + 100) ...[
          Expanded(
              flex: colAbyssSpeedrun[3],
              child: Center(
                  child: Text('Time',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold)))),
          SizedBox(width: 10.wr),
        ],
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
        if (MediaQuery.of(context).size.width < thresholdWidth) ...[
          Expanded(
              flex: MediaQuery.of(context).size.width > kMaxWidthMobile ? colAbyssSpeedrun[2] : 3,
              child: Center(
                  child: Text('Team',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold))))
        ] else ...[
          Expanded(
              flex: colAbyssSpeedrun[2],
              child: Center(
                  child: Text('Team 1',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold)))),
          Expanded(
              flex: colAbyssSpeedrun[2],
              child: Center(
                  child: Text('Team 2',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold)))),
        ],
        SizedBox(width: 10.wr),
        if (MediaQuery.of(context).size.width > thresholdWidth + 100) ...[
          Expanded(
              flex: colAbyssSpeedrun[3],
              child: Center(
                  child: Text('Time',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold)))),
          SizedBox(width: 10.wr),
        ],
        if (MediaQuery.of(context).size.width > kMaxWidthMobile) ...[
          Expanded(
              flex: colEventSpeedrun[3],
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
        if (MediaQuery.of(context).size.width < thresholdWidth) ...[
          Expanded(
              flex: MediaQuery.of(context).size.width > kMaxWidthMobile ? colAbyssSpeedrun[2] : 3,
              child: Center(
                  child: Text('Team',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold))))
        ] else ...[
          Expanded(
              flex: colAbyssSpeedrun[2],
              child: Center(
                  child: Text('Team 1',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold)))),
          Expanded(
              flex: colAbyssSpeedrun[2],
              child: Center(
                  child: Text('Team 2',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold)))),
        ],
        SizedBox(width: 10.wr),
        if (MediaQuery.of(context).size.width > thresholdWidth + 100) ...[
          Expanded(
              flex: colAbyssSpeedrun[3],
              child: Center(
                  child: Text('Time',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold)))),
          SizedBox(width: 10.wr),
        ],
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
