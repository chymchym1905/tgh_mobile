import 'package:flutter/gestures.dart';
import 'package:tgh_mobile/imports.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key, required this.expanded});
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Colors.transparent),
        child: ListView(
            padding: EdgeInsets.zero,
            physics: const PageScrollPhysics(),
            children: expanded
                ? [
                    MediaQuery.of(context).size.width > kMaxWidthTablet &&
                            MediaQuery.of(context).size.width < kMaxWidthTabletLandscape
                        ? SizedBox(
                            height: 56,
                            child: Row(children: [
                              SizedBox(
                                  width: 70,
                                  child: Center(
                                      child: SizedBox(
                                          width: 56,
                                          height: 56,
                                          child: IconButton(
                                              onPressed: () => Scaffold.of(context).closeDrawer(),
                                              icon: const Icon(Icons.dehaze,
                                                  size: 30, weight: 700, grade: 200, opticalSize: 24))))),
                              const SizedBox(width: 8),
                              RichText(
                                  text: TextSpan(
                                      text: 'The Golden House',
                                      style: GoogleFonts.inter(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).colorScheme.primary,
                                        letterSpacing: -2,
                                      ),
                                      recognizer: TapGestureRecognizer()..onTap = () {}))
                            ]))
                        : Container(),
                    DrawerItemExpanded(
                        icon: SvgPicture.asset(Theme.of(context).extension<ThemeAssets>()!.homeIconSvg,
                            height: 30, width: 30),
                        title: 'Home',
                        onTap: () {
                          context.go(Routes.home);
                        }),
                    DrawerItemExpanded(
                        icon: SvgPicture.asset(Theme.of(context).extension<ThemeAssets>()!.lbIconSvg,
                            height: 30, width: 30),
                        title: 'Leaderboard',
                        onTap: () {
                          context.go(Routes.leaderboard);
                        }),
                    DrawerItemExpanded(
                        icon: SvgPicture.asset(Theme.of(context).extension<ThemeAssets>()!.trophyIconSvg,
                            height: 30, width: 30),
                        title: 'Standings',
                        onTap: () {
                          context.go(Routes.standings);
                        }),
                    DrawerItemExpanded(
                        icon: SvgPicture.asset(Theme.of(context).extension<ThemeAssets>()!.profileIconSvg,
                            height: 30, width: 30),
                        title: 'Profile',
                        onTap: () {
                          context.go(Routes.profile);
                        }),
                    DrawerItemExpanded(
                        icon: const Icon(Icons.settings, size: 30),
                        title: 'Settings',
                        onTap: () {
                          context.go(Routes.settings);
                        }),
                  ]
                : [
                    DrawerItemCollapsed(
                        icon: SvgPicture.asset(Theme.of(context).extension<ThemeAssets>()!.homeIconSvg,
                            height: 30, width: 30),
                        title: 'Home',
                        onTap: () {
                          context.go(Routes.home);
                        }),
                    DrawerItemCollapsed(
                        icon: SvgPicture.asset(Theme.of(context).extension<ThemeAssets>()!.lbIconSvg,
                            height: 30, width: 30),
                        title: 'Leaderboard',
                        onTap: () {
                          context.go(Routes.leaderboard);
                        }),
                    DrawerItemCollapsed(
                        icon: SvgPicture.asset(Theme.of(context).extension<ThemeAssets>()!.trophyIconSvg,
                            height: 30, width: 30),
                        title: 'Standings',
                        onTap: () {
                          context.go(Routes.standings);
                        }),
                    DrawerItemCollapsed(
                        icon: SvgPicture.asset(Theme.of(context).extension<ThemeAssets>()!.profileIconSvg,
                            height: 30, width: 30),
                        title: 'Profile',
                        onTap: () {
                          context.go(Routes.profile);
                        }),
                    DrawerItemCollapsed(
                        icon: const Icon(Icons.settings, size: 30),
                        title: 'Settings',
                        onTap: () {
                          context.go(Routes.settings);
                        }),
                  ]));
  }
}

class DrawerItemExpanded extends StatelessWidget {
  const DrawerItemExpanded({super.key, required this.icon, required this.title, required this.onTap});
  final Widget icon;
  final String title;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onTap,
            child: Ink(
              height: 48,
              child: Row(
                children: [
                  SizedBox(width: 70, child: Center(child: icon)),
                  const SizedBox(width: 8),
                  Text(title),
                ],
              ),
            )));
  }
}

class DrawerItemCollapsed extends StatelessWidget {
  const DrawerItemCollapsed({super.key, required this.icon, required this.title, required this.onTap});
  final Widget icon;
  final String title;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onTap,
            child: Ink(
              height: 48,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [icon, Text(title, style: const TextStyle(fontSize: 8))]),
            )));
  }
}
