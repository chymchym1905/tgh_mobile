import 'package:tgh_mobile/imports.dart';
import 'package:tgh_mobile/screens/leaderboardscreen/filter.dart';
import 'filteroverlay.dart';

class LeaderboardBody extends ConsumerStatefulWidget {
  const LeaderboardBody({super.key, required this.currentLeaderboardCategory});
  final String currentLeaderboardCategory;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LeaderboardBodyState();
}

class _LeaderboardBodyState extends ConsumerState<LeaderboardBody> {
  int limitSpeedrun = 10;
  int pageSpeedrun = 0;
  int _speedrunCategoryIndex = 0;
  String _currentSpeedrunCategory = 'Abyss';

  int limitDps = 10;
  int pageDps = 0;
  int _dpsCategoryIndex = 0;
  String _currentDpsCategory = 'Overworld';

  Map<String, dynamic> _filter = {};
  OverlayEntry? _filterOverlay;

  @override
  Widget build(BuildContext context) {
    final speedruns = ref.watch(fetchSpeedrunProvider(
        sortBy: 'time', sortDir: 'asc', page: pageSpeedrun, limit: limitSpeedrun, approved: true, queryParam: _filter));
    final dps = ref.watch(fetchDpsProvider(
        sortBy: 'time', sortDir: 'asc', page: pageDps, limit: limitDps, approved: true, queryParam: _filter));
    return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(15.wr),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.wr, vertical: 16.wr),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Wrap(
              direction: Axis.horizontal,
              runSpacing: 8,
              children: widget.currentLeaderboardCategory == 'Speedrun'
                  ? List<Widget>.generate(
                      SPEEDRUN_CATEGORY_ORDER.length,
                      (index) => Padding(
                          padding: EdgeInsets.only(right: 8.wr),
                          child: CategoryTab(
                              name: SPEEDRUN_CATEGORY_ORDER[index],
                              selected: _speedrunCategoryIndex == index,
                              onTap: () => setState(() {
                                    _speedrunCategoryIndex = index;
                                    _currentSpeedrunCategory = SPEEDRUN_CATEGORY_ORDER[index];
                                  }))))
                  : List<Widget>.generate(
                      DPS_CATEGORY_ORDER.length,
                      (index) => Padding(
                          padding: EdgeInsets.only(right: 8.wr),
                          child: CategoryTab(
                              name: DPS_CATEGORY_ORDER[index],
                              selected: _dpsCategoryIndex == index,
                              onTap: () => setState(() {
                                    _dpsCategoryIndex = index;
                                    _currentDpsCategory = DPS_CATEGORY_ORDER[index];
                                  }))))),
          const SizedBox(height: 8),
          Divider(color: Theme.of(context).colorScheme.outline, height: 32),
          if (MediaQuery.of(context).size.width <= 565)
            SizedBox(
                width: 30.wr,
                height: 30.wr,
                child: IconButton(
                    onPressed: _showFilterOverlay,
                    icon: _filter.isNotEmpty
                        ? Icon(Icons.filter_alt, size: 16.wr)
                        : Icon(Icons.filter_alt_off, size: 16.wr)))
          else
            Filter(
                type: widget.currentLeaderboardCategory,
                category:
                    widget.currentLeaderboardCategory == 'Speedrun' ? _currentSpeedrunCategory : _currentDpsCategory),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(5.wr),
                  ),
                  width: double.infinity,
                  child: Column(children: [])))
        ]));
  }

  void _filterChanged(Map<String, dynamic> applied) {
    _filter = applied;
  }

  void _showFilterOverlay() {
    if (_filterOverlay?.mounted ?? false) {
      _filterOverlay?.remove();
      return;
    }
    _filterOverlay = OverlayEntry(
        builder: (context) => Stack(children: [
              GestureDetector(
                  onTap: () {
                    _showFilterOverlay();
                  },
                  child: Opacity(
                      opacity: 0.5, child: Container(color: Theme.of(context).colorScheme.surfaceContainerLowest))),
              Center(
                  child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainerLowest,
                        borderRadius: BorderRadius.circular(15.wr),
                      ),
                      child: FilterOverlay(
                          type: widget.currentLeaderboardCategory,
                          category: widget.currentLeaderboardCategory == 'Speedrun'
                              ? _currentSpeedrunCategory
                              : _currentDpsCategory,
                          onFilterChanged: _filterChanged)))
            ]));
    Overlay.of(context).insert(_filterOverlay!);
  }
}
