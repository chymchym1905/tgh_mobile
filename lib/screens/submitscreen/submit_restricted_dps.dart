import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:tgh_mobile/imports.dart';

import 'submit_dps_body.dart';

class SubmitRestrictedDpsScreen extends ConsumerStatefulWidget {
  const SubmitRestrictedDpsScreen({super.key});

  @override
  ConsumerState<SubmitRestrictedDpsScreen> createState() => _SubmitSpeedrunScreenState();
}

class _SubmitSpeedrunScreenState extends ConsumerState<SubmitRestrictedDpsScreen> {
  bool _isHovered = false;
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
              leading: SizedBox(
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
                                  defaultTargetPlatform == TargetPlatform.iOS ? Icons.arrow_back_ios : Icons.arrow_back,
                                  size: 30,
                                  weight: 700,
                                  grade: 200,
                                  opticalSize: 24)))))),
          SliverToBoxAdapter(
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width > kMaxWidthMobile ? 32.wr : 16.wr),
                  child: const SubmitDpsBody()))
        ]),
        if (MediaQuery.of(context).size.width > kMaxWidthTabletLandscape) ...[
          MouseRegion(
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
              width: 30, // small strip to the left
              color: Colors.transparent,
            ),
          ),
          AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              left: _isHovered ? 0 : -200, // hide when not hovered
              top: 0,
              bottom: 0,
              child: MouseRegion(
                  // This ensures the drawer stays visible when mouse is over it
                  onEnter: (_) => setState(() => _isHovered = true),
                  onExit: (p) {
                    // Only exit if mouse is actually leaving the drawer area
                    final RenderBox box = context.findRenderObject() as RenderBox;
                    final position = box.globalToLocal(p.position);
                    if (position.dx < 0 || position.dx > 200) {
                      setState(() => _isHovered = false);
                    }
                  },
                  child: const Drawer(
                      width: 200,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(0))),
                      child: DrawerWidget(expanded: true))))
        ]
      ]),
    );
  }
}
