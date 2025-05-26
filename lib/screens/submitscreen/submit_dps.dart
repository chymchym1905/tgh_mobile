import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:tgh_mobile/imports.dart';
import 'submit_dps_body.dart';

class SubmitDpsScreen extends ConsumerStatefulWidget {
  const SubmitDpsScreen({super.key});

  @override
  ConsumerState<SubmitDpsScreen> createState() => _SubmitSpeedrunScreenState();
}

class _SubmitSpeedrunScreenState extends ConsumerState<SubmitDpsScreen> {
  bool _isHovered = false;
  final GlobalKey _drawerKey = GlobalKey();
  final _key = GlobalKey<ExpandableFabState>();
  final customPopupMenuController = CustomPopupMenuController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
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
                context.go(Routes.home);
              },
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
              child: SvgPicture.asset(Theme.of(context).extension<ThemeAssets>()!.homeIconSvg, height: 40, width: 40),
            ),
            FloatingActionButton(
              onPressed: () {
                if (_key.currentState?.isOpen ?? false) {
                  _key.currentState?.toggle();
                }
                context.go(Routes.leaderboard);
              },
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
              child: SvgPicture.asset(Theme.of(context).extension<ThemeAssets>()!.lbIconSvg, height: 40, width: 40),
            ),
            FloatingActionButton(
              onPressed: () {
                if (_key.currentState?.isOpen ?? false) {
                  _key.currentState?.toggle();
                }
                context.go(Routes.standings);
              },
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
              child: SvgPicture.asset(Theme.of(context).extension<ThemeAssets>()!.trophyIconSvg, height: 40, width: 40),
            ),
            FloatingActionButton(
              onPressed: () {
                if (_key.currentState?.isOpen ?? false) {
                  _key.currentState?.toggle();
                }
                context.go(Routes.profile);
              },
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
              child:
                  SvgPicture.asset(Theme.of(context).extension<ThemeAssets>()!.profileIconSvg, height: 40, width: 40),
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
          ]),
      body: Stack(children: [
        CustomScrollView(slivers: [
          MyAppBar(
              title: RichText(
                  text: TextSpan(
                      text: 'The Golden House',
                      style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                        letterSpacing: -2,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.go(Routes.home);
                        })),
              leading: context.canPop()
                  ? SizedBox(
                      width: 70,
                      child: Center(
                          child: SizedBox(
                              width: 56,
                              height: 56,
                              child: IconButton(
                                  onPressed: () {
                                    context.pop();
                                  },
                                  icon: Icon(
                                      defaultTargetPlatform == TargetPlatform.iOS
                                          ? Icons.arrow_back_ios_new
                                          : Icons.arrow_back,
                                      size: 30,
                                      weight: 700,
                                      grade: 200,
                                      opticalSize: 24)))))
                  : const SizedBox(width: 8)),
          const SliverToBoxAdapter(child: SizedBox(height: 50)),
          SliverToBoxAdapter(
              child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: kMaxWidthTabletLandscape.toDouble()),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width > kMaxWidthMobile ? 32.wr : 16.wr),
                child: const SubmitDpsBody(),
              ),
            ),
          )),
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
        ]),
        if (MediaQuery.of(context).size.width > kMaxWidthTabletLandscape) ...[
          Align(
              alignment: Alignment.centerLeft,
              child: MouseRegion(
                  onEnter: (_) => setState(() => _isHovered = true),
                  onExit: (p) {
                    // Only exit if mouse is actually leaving the left edge area
                    // and not just entering the drawer
                    if (!_isHovered) return;
                    final RenderBox box = context.findRenderObject() as RenderBox;
                    final position = box.globalToLocal(p.position);
                    if (position.dx > 200) {
                      setState(() => _isHovered = false);
                    }
                  },
                  child: Container(
                      height: 100,
                      width: 25, // small strip to the left
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Theme.of(context).colorScheme.shadow,
                                offset: const Offset(2, 3),
                                blurRadius: 2,
                                spreadRadius: 1)
                          ],
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius:
                              const BorderRadius.only(topRight: Radius.circular(15), bottomRight: Radius.circular(15))),
                      child: Center(
                          child: Icon(Icons.arrow_forward_ios,
                              size: 20, color: Theme.of(context).colorScheme.surfaceContainer))))),
          AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              left: _isHovered ? 0 : -230, // hide when not hovered
              top: MediaQuery.of(context).size.height / 2 - 48 * 5 / 2,
              child: MouseRegion(
                  // This ensures the drawer stays visible when mouse is over it
                  onEnter: (_) => setState(() => _isHovered = true),
                  onExit: (p) {
                    // Only exit if mouse is actually leaving the drawer area
                    final RenderBox box = _drawerKey.currentContext?.findRenderObject() as RenderBox;
                    final position = box.globalToLocal(p.position);
                    if (position.dx < 0 || position.dx > 200) {
                      setState(() => _isHovered = false);
                    }
                    if (position.dy < 0 || position.dy > 48 * 5) {
                      setState(() => _isHovered = false);
                    }
                  },
                  child: Row(
                    children: [
                      Container(
                          key: _drawerKey,
                          height: 48 * 5,
                          width: 200,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Theme.of(context).colorScheme.shadow,
                                    offset: const Offset(2, 3),
                                    blurRadius: 2,
                                    spreadRadius: 1)
                              ],
                              color: Theme.of(context).colorScheme.surfaceContainer,
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(15), bottomRight: Radius.circular(15))),
                          child: const DrawerWidget(expanded: true)),
                      Container(
                          height: 100,
                          width: 25,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Theme.of(context).colorScheme.shadow,
                                    offset: const Offset(2, 3),
                                    blurRadius: 2,
                                    spreadRadius: 1)
                              ],
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(8), bottomRight: Radius.circular(8))),
                          child: Center(
                              child: Icon(Icons.arrow_back_ios_new,
                                  size: 20, color: Theme.of(context).colorScheme.surfaceContainer))),
                    ],
                  )))
        ]
      ]),
    );
  }
}
