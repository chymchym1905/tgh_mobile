import '../imports.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  SideMenuController sideMenuController = SideMenuController();
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
        drawer: MediaQuery.of(context).size.width > kMaxWidthTablet &&
                MediaQuery.of(context).size.width < kMaxWidthTabletLandscape
            ? Drawer(
                width: 300,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(0))),
                child: DrawerWidget(expanded: true))
            : null,
        body: widget.navigationShell,
        floatingActionButton: MediaQuery.of(context).size.width > kMaxWidthTablet
            ? null
            : FloatingActionButton(
                onPressed: () {},
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                shape: const CircleBorder(),
                mini: true,
                child: const Icon(Icons.add),
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
                onTap: (index) => widget.navigationShell.goBranch(index),
              ));
  }
}
