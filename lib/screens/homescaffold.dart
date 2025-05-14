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
                    ],
                  )
                : null)
            : FloatingActionButton(
                onPressed: () {},
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                shape: const CircleBorder(),
                mini: true,
                child: const Icon(Icons.add),
              ),
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
