import 'package:tgh_mobile/imports.dart';
import 'standingsbody.dart';

class StandingsScreen extends StatefulWidget {
  const StandingsScreen({super.key});

  @override
  State<StandingsScreen> createState() => _StandingsScreenState();
}

class _StandingsScreenState extends State<StandingsScreen> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      MyAppBar(
          title: Text('Abyss Standings',
              style: GoogleFonts.inter(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                  letterSpacing: -2)),
          leading: SizedBox(
              width: 70,
              child: Center(
                  child: SizedBox(
                      width: 56,
                      height: 56,
                      child: IconButton(
                          onPressed: () {
                            if (MediaQuery.of(context).size.width > kMaxWidthTabletLandscape) {
                              setState(() {
                                _expanded = !_expanded;
                              });
                            } else {
                              Scaffold.of(context).openDrawer();
                            }
                          },
                          icon: const Icon(Icons.dehaze, size: 30, weight: 700, grade: 200, opticalSize: 24)))))),
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
                      child: DrawerWidget(
                        key: ValueKey<bool>(_expanded),
                        expanded: _expanded,
                      ),
                    ),
                  ),
                  SizedBox(width: 8)
                ] else if (MediaQuery.of(context).size.width > kMaxWidthTablet &&
                    MediaQuery.of(context).size.width < kMaxWidthTabletLandscape) ...[
                  const SizedBox(width: 70, child: DrawerWidget(expanded: false)),
                  SizedBox(width: 8)
                ],
                Expanded(
                    child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                        child: Center(
                            child: ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: 1680 - (_expanded ? 200 : 70)),
                                child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width > kMaxWidthMobile ? 32.wr : 16.wr),
                                    child: const StandingsBody())))),
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
                  ],
                ))
              ]))),
    ]);
  }
}
