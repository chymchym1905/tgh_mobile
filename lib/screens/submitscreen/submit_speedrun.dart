import 'package:flutter/gestures.dart';
import 'package:tgh_mobile/imports.dart';
import 'submit_speedrun_body.dart';

class SubmitSpeedrunScreen extends ConsumerStatefulWidget {
  const SubmitSpeedrunScreen({super.key});

  @override
  ConsumerState<SubmitSpeedrunScreen> createState() => _SubmitSpeedrunScreenState();
}

class _SubmitSpeedrunScreenState extends ConsumerState<SubmitSpeedrunScreen> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: MediaQuery.of(context).size.width > kMaxWidthTablet &&
              MediaQuery.of(context).size.width < kMaxWidthTabletLandscape
          ? const Drawer(
              width: 300,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(0))),
              child: DrawerWidget(expanded: true))
          : null,
      body: CustomScrollView(slivers: [
        Builder(builder: (context) {
          return SliverAppBar(
              title: Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: RichText(
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
                              ref.invalidate(feedNotifierProvider);
                            }))),
              pinned: true,
              floating: true,
              centerTitle: false,
              leading: MediaQuery.of(context).size.width > kMaxWidthTablet
                  ? IconButton(
                      onPressed: () {
                        if (MediaQuery.of(context).size.width > kMaxWidthTabletLandscape) {
                          setState(() {
                            _expanded = !_expanded;
                          });
                        } else {
                          Scaffold.of(context).openDrawer();
                        }
                      },
                      icon: const Icon(Icons.dehaze, size: 30, weight: 700, grade: 200, opticalSize: 24))
                  : null,
              elevation: 0,
              shadowColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              backgroundColor: Theme.of(context).colorScheme.surface,
              actions: [
                8.horizontalSpace,
                IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
              ]);
        }),
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
                          child: DrawerWidget(expanded: _expanded),
                        )),
                    SizedBox(width: 10.wr)
                  ] else if (MediaQuery.of(context).size.width > kMaxWidthTablet &&
                      MediaQuery.of(context).size.width < kMaxWidthTabletLandscape) ...[
                    const SizedBox(width: 56, child: DrawerWidget(expanded: false)),
                    SizedBox(width: 10.wr)
                  ],
                  Expanded(
                      child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: MediaQuery.of(context).size.width > kMaxWidthMobile ? 32.wr : 16.wr),
                            child: const SubmitSpeedrunBody()),
                      )
                    ],
                  ))
                ])))
      ]),
    );
  }
}
