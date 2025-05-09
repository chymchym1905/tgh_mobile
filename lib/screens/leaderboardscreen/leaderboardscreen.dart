import 'package:tgh_mobile/imports.dart';

import 'lbbody.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  bool _expanded = false;
  final leaderboardCategories = ['Speedrun, DPS, Restricted DPS'];
  String selectedLeaderboardCategory = 'Speedrun';

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
            centerTitle: false,
            pinned: true,
            floating: true,
            leading: MediaQuery.of(context).size.width > kMaxWidthTablet
                ? IconButton(
                    onPressed: () {
                      if (MediaQuery.of(context).size.width > kMaxWidthTabletLandscape) {
                        setState(() {
                          _expanded = !_expanded;
                        });
                      } else {
                        Scaffold.of(context).openDrawer();
                      }
                    },
                    icon: const Icon(Icons.dehaze, size: 30, weight: 700, grade: 200, opticalSize: 24))
                : null,
            title: CustomPopupMenu(
                position: PreferredPosition.bottom,
                verticalMargin: 0,
                horizontalMargin: 80.wr,
                arrowColor: Theme.of(context).colorScheme.surfaceContainerLowest,
                menuBuilder: () => Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainerLowest,
                        borderRadius: BorderRadius.circular(5.wr)),
                    child: Material(
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.wr)),
                        child: IntrinsicWidth(
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                              InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedLeaderboardCategory = 'Speedrun';
                                    });
                                  },
                                  highlightColor: Theme.of(context).colorScheme.surfaceContainerHigh,
                                  splashColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5.wr),
                                    topRight: Radius.circular(5.wr),
                                  ),
                                  child: Padding(
                                      padding: EdgeInsets.only(right: 10.wr, left: 10.wr, top: 10.wr, bottom: 5.wr),
                                      child: Row(children: [
                                        Icon(Icons.timer, size: 24.wr),
                                        SizedBox(width: 5.wr),
                                        Text('Speedrun', style: TextStyle(fontSize: 18.wr, fontWeight: FontWeight.bold))
                                      ]))),
                              InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedLeaderboardCategory = 'DPS';
                                    });
                                  },
                                  highlightColor: Theme.of(context).colorScheme.surfaceContainerHigh,
                                  splashColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(5.wr), bottomRight: Radius.circular(5.wr)),
                                  child: Ink(
                                      padding: EdgeInsets.symmetric(vertical: 5.wr, horizontal: 10.wr),
                                      child: Row(children: [
                                        SvgPicture.asset('assets/icons/whale.svg', width: 24.wr, height: 24.wr),
                                        SizedBox(width: 5.wr),
                                        Text('DPS', style: TextStyle(fontSize: 18.wr, fontWeight: FontWeight.bold))
                                      ]))),
                              InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedLeaderboardCategory = 'Restricted DPS';
                                    });
                                  },
                                  highlightColor: Theme.of(context).colorScheme.surfaceContainerHigh,
                                  splashColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(5.wr), bottomRight: Radius.circular(5.wr)),
                                  child: Padding(
                                      padding: EdgeInsets.only(right: 10.wr, left: 10.wr, top: 5.wr, bottom: 10.wr),
                                      child: Row(children: [
                                        SvgPicture.asset('assets/icons/fish.svg', width: 24.wr, height: 24.wr),
                                        SizedBox(width: 5.wr),
                                        Text('Restricted DPS',
                                            style: TextStyle(fontSize: 18.wr, fontWeight: FontWeight.bold))
                                      ])))
                            ])))),
                pressType: PressType.singleClick,
                child: Text('$selectedLeaderboardCategory Leaderboard',
                    style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                        letterSpacing: -2)))),
        SliverToBoxAdapter(
          child: SizedBox(
              height: MediaQuery.of(context).size.height - kToolbarHeight,
              child: Row(children: [
                if (MediaQuery.of(context).size.width > kMaxWidthTabletLandscape) ...[
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: _expanded ? 200 : 56,
                    child: AnimatedSwitcher(
                      duration: _expanded ? const Duration(milliseconds: 200) : const Duration(milliseconds: 500),
                      child: DrawerWidget(
                        key: ValueKey<bool>(_expanded),
                        expanded: _expanded,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.wr)
                ] else if (MediaQuery.of(context).size.width > kMaxWidthTablet &&
                    MediaQuery.of(context).size.width < kMaxWidthTabletLandscape) ...[
                  const SizedBox(width: 56, child: DrawerWidget(expanded: false)),
                  SizedBox(width: 10.wr)
                ],
                Expanded(
                    child: Center(
                        child: ConstrainedBox(
                            constraints:
                                BoxConstraints(maxWidth: kMaxWidthTabletLandscape.toDouble() - (_expanded ? 200 : 56)),
                            child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.wr),
                                child: LeaderboardBody(currentLeaderboardCategory: selectedLeaderboardCategory)))))
              ])),
        )
      ],
    );
  }
}
