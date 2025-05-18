import '../imports.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _key = GlobalKey<ExpandableFabState>();
  final customPopupMenuController = CustomPopupMenuController();

  Widget _tabBuilder(int index, bool isActive, double width, double height) {
    switch (index) {
      case 0:
        return isActive
            ? Lottie.asset(Theme.of(context).extension<ThemeAssets>()!.homeLottieJson,
                height: height, width: width, repeat: false)
            : SvgPicture.asset(Theme.of(context).extension<ThemeAssets>()!.homeIconSvg, height: height, width: width);
      case 1:
        return isActive
            ? Lottie.asset(Theme.of(context).extension<ThemeAssets>()!.lbLottieJson,
                height: height, width: width, repeat: false)
            : SvgPicture.asset(Theme.of(context).extension<ThemeAssets>()!.lbIconSvg, height: height, width: width);
      case 2:
        return isActive
            ? Lottie.asset(Theme.of(context).extension<ThemeAssets>()!.trophyLottieJson,
                height: height, width: width, repeat: false)
            : SvgPicture.asset(Theme.of(context).extension<ThemeAssets>()!.trophyIconSvg, height: height, width: width);
      default:
        return isActive
            ? Lottie.asset(Theme.of(context).extension<ThemeAssets>()!.profileLottieJson,
                height: height, width: width, repeat: false)
            : SvgPicture.asset(Theme.of(context).extension<ThemeAssets>()!.profileIconSvg,
                height: height, width: width);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final chymchymSpeedrun = ref.watch(fetchCompetitorSpeedrunsProvider(
    //   '621336b43e8e7f7628dce587',
    //   'created_at',
    //   'desc',
    //   0,
    //   10,
    //   approved: true,
    // ));

    return Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: MediaQuery.of(context).size.width > kMaxWidthTablet &&
                MediaQuery.of(context).size.width < kMaxWidthTabletLandscape
            ? const Drawer(
                width: 300,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(0))),
                child: DrawerWidget(expanded: true))
            : null,
        body: widget.navigationShell,
        floatingActionButton: MediaQuery.of(context).size.width > kMaxWidthTablet
            ? (widget.navigationShell.currentIndex == 3
                ? ExpandableFab(
                    key: _key,
                    elevation: 10,
                    type: ExpandableFabType.up,
                    openButtonBuilder: RotateFloatingActionButtonBuilder(
                      child: const Icon(Icons.menu),
                      fabSize: ExpandableFabSize.regular,
                      foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                      shape: const CircleBorder(),
                    ),
                    closeButtonBuilder: DefaultFloatingActionButtonBuilder(
                      child: const Icon(Icons.close),
                      fabSize: ExpandableFabSize.regular,
                      foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                      shape: const CircleBorder(),
                    ),
                    children: [
                      FloatingActionButton(
                        onPressed: () {
                          if (_key.currentState?.isOpen ?? false) {
                            _key.currentState?.toggle();
                          }
                          widget.navigationShell.goBranch(0);
                        },
                        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: _tabBuilder(0, widget.navigationShell.currentIndex == 0, 40, 40),
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          if (_key.currentState?.isOpen ?? false) {
                            _key.currentState?.toggle();
                          }
                          widget.navigationShell.goBranch(1);
                        },
                        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: _tabBuilder(1, widget.navigationShell.currentIndex == 1, 40, 40),
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          if (_key.currentState?.isOpen ?? false) {
                            _key.currentState?.toggle();
                          }
                          widget.navigationShell.goBranch(2);
                        },
                        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: _tabBuilder(2, widget.navigationShell.currentIndex == 2, 40, 40),
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          if (_key.currentState?.isOpen ?? false) {
                            _key.currentState?.toggle();
                          }
                          widget.navigationShell.goBranch(3);
                        },
                        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: _tabBuilder(3, widget.navigationShell.currentIndex == 3, 40, 40),
                      ),
                      AddFloatingActionButton(
                          fab: FloatingActionButton(
                            onPressed: () {
                              // if (_key.currentState?.isOpen ?? false) {
                              //   _key.currentState?.toggle();
                              // }
                              customPopupMenuController.showMenu();
                            },
                            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                            child: const Icon(Icons.add, size: 40),
                          ),
                          controller: customPopupMenuController)
                    ],
                  )
                : null)
            : AddFloatingActionButton(
                controller: customPopupMenuController,
                fab: FloatingActionButton(
                  onPressed: () {
                    customPopupMenuController.showMenu();
                  },
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  shape: const CircleBorder(),
                  mini: true,
                  child: const Icon(Icons.add),
                )),
        floatingActionButtonLocation:
            widget.navigationShell.currentIndex == 3 && MediaQuery.of(context).size.width > kMaxWidthTabletLandscape
                ? ExpandableFab.location
                : FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: MediaQuery.of(context).size.width > kMaxWidthTablet
            ? null
            : AnimatedBottomNavigationBar.builder(
                tabBuilder: (index, isActive) => _tabBuilder(index, isActive, 20, 20),
                itemCount: 4,
                backgroundColor: Theme.of(context).colorScheme.surface,
                // splashColor: Theme.of(context).colorScheme.onPrimaryContainer,
                splashRadius: 0,
                scaleFactor: 0,
                shadow: Theme.of(context).extension<Shadows>()!.shadow,
                notchSmoothness: NotchSmoothness.defaultEdge,
                gapLocation: GapLocation.center,
                activeIndex: widget.navigationShell.currentIndex,
                onTap: (index) {
                  widget.navigationShell.goBranch(index);
                },
              ));
  }
}

class AddFloatingActionButton extends StatefulWidget {
  const AddFloatingActionButton({super.key, required this.fab, required this.controller});
  final Widget fab;
  final CustomPopupMenuController controller;

  @override
  State<AddFloatingActionButton> createState() => _AddFloatingActionButtonState();
}

class _AddFloatingActionButtonState extends State<AddFloatingActionButton> {
  @override
  Widget build(BuildContext context) {
    return CustomPopupMenu(
        controller: widget.controller,
        materialShape: const CircleBorder(),
        hoverColor: Colors.transparent,
        arrowColor: Theme.of(context).colorScheme.surfaceContainerHigh,
        menuBuilder: () => Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHigh, borderRadius: BorderRadius.circular(5.wr)),
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
                                context.push(Routes.submitSpeedrun);
                                widget.controller.hideMenu();
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
                                    // Icon(Icons.timer, size: 24.wr),
                                    // SizedBox(width: 5.wr),
                                    Text('Submit Speedrun',
                                        style: TextStyle(fontSize: 12.wr, fontWeight: FontWeight.bold))
                                  ]))),
                          InkWell(
                              onTap: () {
                                context.push(Routes.submitDps);
                                widget.controller.hideMenu();
                              },
                              highlightColor: Theme.of(context).colorScheme.surfaceContainerHigh,
                              splashColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(5.wr), bottomRight: Radius.circular(5.wr)),
                              child: Ink(
                                  padding: EdgeInsets.symmetric(vertical: 5.wr, horizontal: 10.wr),
                                  child: Row(children: [
                                    // SvgPicture.asset('assets/icons/whale.svg', width: 24.wr, height: 24.wr),
                                    // SizedBox(width: 5.wr),
                                    Text('Submit DPS', style: TextStyle(fontSize: 12.wr, fontWeight: FontWeight.bold))
                                  ]))),
                          InkWell(
                              onTap: () {
                                context.push(Routes.submitRestrictedDps);
                                widget.controller.hideMenu();
                              },
                              highlightColor: Theme.of(context).colorScheme.surfaceContainerHigh,
                              splashColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(5.wr), bottomRight: Radius.circular(5.wr)),
                              child: Padding(
                                  padding: EdgeInsets.only(right: 10.wr, left: 10.wr, top: 5.wr, bottom: 10.wr),
                                  child: Row(children: [
                                    // SvgPicture.asset('assets/icons/fish.svg', width: 24.wr, height: 24.wr),
                                    // SizedBox(width: 5.wr),
                                    Text('Submit Restricted DPS',
                                        style: TextStyle(fontSize: 12.wr, fontWeight: FontWeight.bold))
                                  ])))
                        ])));
              },
            )),
        pressType: PressType.singleClick,
        child: widget.fab);
  }
}
