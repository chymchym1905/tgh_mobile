import 'package:tgh_mobile/app_state_providers/theme.dart';

import '../../imports.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= kMaxWidthMobile) {
        return const HomeScreenMobile();
      } else if (constraints.maxWidth <= kMaxWidthTablet) {
        return const HomeScreenTablet();
      } else if (constraints.maxWidth <= kMaxWidthTabletLandscape) {
        return const HomeScreenTabletLandscape();
      } else {
        return const HomeScreenDesktop();
      }
    });
  }
}

class HomeScreenMobile extends ConsumerStatefulWidget {
  const HomeScreenMobile({super.key});

  @override
  ConsumerState<HomeScreenMobile> createState() => _HomeScreenMobileState();
}

class _HomeScreenMobileState extends ConsumerState<HomeScreenMobile> {
  int _bottomNavIndex = 0;

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
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {},
          child: CustomScrollView(
            slivers: [
              MyAppBar(home: _bottomNavIndex == 0, profile: _bottomNavIndex == 3),
            ],
          ),
        ),
      ),
      floatingActionButton: Consumer(builder: (context, ref, child) {
        return FloatingActionButton(
          onPressed: () {
            ref.read(themeNotifierProvider.notifier).toggleTheme();
          },
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          shape: CircleBorder(),
          mini: true,
          child: const Icon(Icons.add),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        tabBuilder: (index, isActive) => _tabBuilder(index, isActive, 20, 20),
        itemCount: 4,
        backgroundColor: Theme.of(context).colorScheme.surface,
        // splashColor: Theme.of(context).colorScheme.onPrimaryContainer,
        splashRadius: 0,
        scaleFactor: 0,
        shadow: Theme.of(context).extension<Shadows>()!.shadow,
        notchSmoothness: NotchSmoothness.defaultEdge,
        gapLocation: GapLocation.center,
        activeIndex: _bottomNavIndex,
        onTap: (index) => setState(() => _bottomNavIndex = index),
      ),
    );
  }
}

class HomeScreenTablet extends StatefulWidget {
  const HomeScreenTablet({super.key});

  @override
  State<HomeScreenTablet> createState() => _HomeScreenTabletState();
}

class _HomeScreenTabletState extends State<HomeScreenTablet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Tablet')));
  }
}

class HomeScreenTabletLandscape extends StatefulWidget {
  const HomeScreenTabletLandscape({super.key});

  @override
  State<HomeScreenTabletLandscape> createState() => _HomeScreenTabletLandscapeState();
}

class _HomeScreenTabletLandscapeState extends State<HomeScreenTabletLandscape> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Tablet Landscape')));
  }
}

class HomeScreenDesktop extends StatefulWidget {
  const HomeScreenDesktop({super.key});

  @override
  State<HomeScreenDesktop> createState() => _HomeScreenDesktopState();
}

class _HomeScreenDesktopState extends State<HomeScreenDesktop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Desktop')));
  }
}
