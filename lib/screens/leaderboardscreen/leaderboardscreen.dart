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
  final customPopupMenuController = CustomPopupMenuController();
  final map = <String, ProviderOrFamily>{
    'Speedrun': fetchSpeedrunProvider,
    'DPS': fetchDpsProvider,
    'Restricted DPS': fetchRestrictedDpsProvider,
  };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          MyAppBar(
            leading: SizedBox(
              width: 70,
              child: Center(
                child: SizedBox(
                  width: 56,
                  height: 56,
                  child: IconButton(
                      onPressed: () {
                        if (MediaQuery.of(context).size.width > kMaxWidthTabletLandscape) {
                          setState(() {
                            _expanded = !_expanded;
                          });
                        } else {
                          Scaffold.of(context).openDrawer();
                        }
                      },
                      icon: const Icon(Icons.dehaze, size: 30, weight: 700, grade: 200, opticalSize: 24)),
                ),
              ),
            ),
            title: CustomPopupMenu(
                controller: customPopupMenuController,
                position: PreferredPosition.bottom,
                verticalMargin: 0,
                horizontalMargin: 80.wr,
                arrowColor: Theme.of(context).colorScheme.surfaceContainerHigh,
                menuBuilder: () => Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(5.wr)),
                    child: Consumer(
                      builder: (context, ref, child) {
                        return Material(
                            color: Colors.transparent,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.wr)),
                            child: IntrinsicWidth(
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                  InkWell(
                                      onTap: () {
                                        if (ref.read(appliedDisplayFilterProvider).isNotEmpty) {
                                          ref.invalidate(map[selectedLeaderboardCategory]!);
                                          // Call the appropriate resetFilter method based on the current category
                                          if (selectedLeaderboardCategory == 'Speedrun') {
                                            ref.read(speedrunLeaderboardFilterNotifierProvider.notifier).resetFilter();
                                          } else if (selectedLeaderboardCategory == 'DPS') {
                                            ref.read(dpsLeaderboardFilterNotifierProvider.notifier).resetFilter();
                                          } else if (selectedLeaderboardCategory == 'Restricted DPS') {
                                            ref
                                                .read(restrictedDpsLeaderboardFilterNotifierProvider.notifier)
                                                .resetFilter();
                                          }
                                        }
                                        setState(() {
                                          selectedLeaderboardCategory = 'Speedrun';
                                          ref.read(appliedDisplayFilterProvider.notifier).state = {};
                                        });

                                        customPopupMenuController.hideMenu();
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
                                            Text('Speedrun',
                                                style: TextStyle(fontSize: 18.wr, fontWeight: FontWeight.bold))
                                          ]))),
                                  InkWell(
                                      onTap: () {
                                        if (ref.read(appliedDisplayFilterProvider).isNotEmpty) {
                                          ref.invalidate(map[selectedLeaderboardCategory]!);
                                          // Call the appropriate resetFilter method based on the current category
                                          if (selectedLeaderboardCategory == 'Speedrun') {
                                            ref.read(speedrunLeaderboardFilterNotifierProvider.notifier).resetFilter();
                                          } else if (selectedLeaderboardCategory == 'DPS') {
                                            ref.read(dpsLeaderboardFilterNotifierProvider.notifier).resetFilter();
                                          } else if (selectedLeaderboardCategory == 'Restricted DPS') {
                                            ref
                                                .read(restrictedDpsLeaderboardFilterNotifierProvider.notifier)
                                                .resetFilter();
                                          }
                                        }
                                        setState(() {
                                          selectedLeaderboardCategory = 'DPS';

                                          ref.read(appliedDisplayFilterProvider.notifier).state = {};
                                        });
                                        customPopupMenuController.hideMenu();
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
                                        if (ref.read(appliedDisplayFilterProvider).isNotEmpty) {
                                          ref.invalidate(map[selectedLeaderboardCategory]!);
                                          // Call the appropriate resetFilter method based on the current category
                                          if (selectedLeaderboardCategory == 'Speedrun') {
                                            ref.read(speedrunLeaderboardFilterNotifierProvider.notifier).resetFilter();
                                          } else if (selectedLeaderboardCategory == 'DPS') {
                                            ref.read(dpsLeaderboardFilterNotifierProvider.notifier).resetFilter();
                                          } else if (selectedLeaderboardCategory == 'Restricted DPS') {
                                            ref
                                                .read(restrictedDpsLeaderboardFilterNotifierProvider.notifier)
                                                .resetFilter();
                                          }
                                        }
                                        setState(() {
                                          selectedLeaderboardCategory = 'Restricted DPS';
                                          ref.read(appliedDisplayFilterProvider.notifier).state = {};
                                        });
                                        customPopupMenuController.hideMenu();
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
                                ])));
                      },
                    )),
                pressType: PressType.singleClick,
                child: Text('$selectedLeaderboardCategory Leaderboard',
                    style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                        letterSpacing: -2))),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
                height: MediaQuery.of(context).size.height - kToolbarHeight,
                child: Row(children: [
                  if (MediaQuery.of(context).size.width > kMaxWidthTabletLandscape) ...[
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: _expanded ? 200 : 70,
                      child: AnimatedSwitcher(
                        duration: _expanded ? const Duration(milliseconds: 200) : const Duration(milliseconds: 500),
                        child: DrawerWidget(
                          key: ValueKey<bool>(_expanded),
                          expanded: _expanded,
                        ),
                      ),
                    ),
                    SizedBox(width: 8)
                  ] else if (MediaQuery.of(context).size.width > kMaxWidthTablet &&
                      MediaQuery.of(context).size.width < kMaxWidthTabletLandscape) ...[
                    const SizedBox(width: 70, child: DrawerWidget(expanded: false)),
                    SizedBox(width: 8)
                  ],
                  Expanded(
                      child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Center(
                            child: ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: 1680 - (_expanded ? 200 : 70)),
                                child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width > kMaxWidthMobile ? 32.wr : 16.wr),
                                    child: LeaderboardBody(currentLeaderboardCategory: selectedLeaderboardCategory)))),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 25)),
                      SliverToBoxAdapter(
                          child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  // color: Theme.of(context).colorScheme.surfaceContainerLow,
                                  color: Colors.transparent),
                              height: 200,
                              padding: EdgeInsets.symmetric(horizontal: 20.wr, vertical: 16.wr),
                              child: Center(
                                  child: Text(
                                      '© 2022 BY THE GOLDEN HOUSE. THE GOLDEN HOUSE is not affiliated with miHoYo. Genshin Impact, game content and materials are trademarks and copyrights of miHoYo.',
                                      style: TextStyle(fontSize: 10.swr),
                                      textAlign: TextAlign.center))))
                    ],
                  ))
                ])),
          )
        ],
      ),
    );
  }
}
