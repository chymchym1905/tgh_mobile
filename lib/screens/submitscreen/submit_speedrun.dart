import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:tgh_mobile/imports.dart';
import 'submit_speedrun_body.dart';

class SubmitSpeedrunScreen extends ConsumerStatefulWidget {
  const SubmitSpeedrunScreen({super.key});

  @override
  ConsumerState<SubmitSpeedrunScreen> createState() => _SubmitSpeedrunScreenState();
}

class _SubmitSpeedrunScreenState extends ConsumerState<SubmitSpeedrunScreen> {
  bool _isHovered = false;
  final GlobalKey _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                child: const SubmitSpeedrunBody(),
              ),
            ),
          )),
          SliverToBoxAdapter(child: const SizedBox(height: 500))
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
