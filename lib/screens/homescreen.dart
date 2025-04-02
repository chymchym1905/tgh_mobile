import 'package:tgh_mobile/providers/theme.dart';

import '../imports.dart';
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

class HomeScreenMobile extends StatefulWidget {
  const HomeScreenMobile({super.key});

  @override
  State<HomeScreenMobile> createState() => _HomeScreenMobileState();
}

class _HomeScreenMobileState extends State<HomeScreenMobile> {
  int _bottomNavIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home'), centerTitle: true),
      body: Center(
          child: Container(
              // child: Image.asset('assets/images/circleavatar.webp')
              child: SvgPicture.asset(Theme.of(context).extension<ThemeAssets>()!.lbIconSvg, height: 300, width: 300))),
      floatingActionButton: Consumer(builder: (context, ref, child) {
        return FloatingActionButton(
          onPressed: () {
            ref.read(themeNotifierProvider.notifier).toggleTheme();
          },
          child: const Icon(Icons.add),
          shape: CircleBorder(),
          mini: true,
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        tabBuilder: (index, isActive) {
          switch (index) {
            case 0:
              return isActive
                  ? Lottie.asset(Theme.of(context).extension<ThemeAssets>()!.homeLottieJson,
                      height: 20, width: 20, repeat: false)
                  : SvgPicture.asset(Theme.of(context).extension<ThemeAssets>()!.homeIconSvg, height: 20, width: 20);
            case 1:
              return isActive
                  ? Lottie.asset(Theme.of(context).extension<ThemeAssets>()!.lbLottieJson,
                      height: 20, width: 20, repeat: false)
                  : SvgPicture.asset(Theme.of(context).extension<ThemeAssets>()!.lbIconSvg, height: 20, width: 20);
            case 2:
              return isActive
                  ? Lottie.asset(Theme.of(context).extension<ThemeAssets>()!.trophyLottieJson,
                      height: 20, width: 20, repeat: false)
                  : SvgPicture.asset(Theme.of(context).extension<ThemeAssets>()!.trophyIconSvg, height: 20, width: 20);
            default:
              return isActive
                  ? Lottie.asset(Theme.of(context).extension<ThemeAssets>()!.profileLottieJson,
                      height: 20, width: 20, repeat: false)
                  : SvgPicture.asset(Theme.of(context).extension<ThemeAssets>()!.profileIconSvg, height: 20, width: 20);
          }
        },
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
