import 'package:tgh_mobile/imports.dart';
import 'package:tgh_mobile/screens/leaderboardscreen/filter.dart';
import 'filteroverlay.dart';
import 'table/tableheader_speedrun.dart';
import 'table/tablerow_speedrun.dart';

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

  Map<String, dynamic> _speedrunFilter = {
    'speedrun_category': 'Abyss',
    'abyss_version': ABYSS_VERSION_HISTORY.last,
  };
  Map<String, dynamic> _dpsFilter = {
    'dps_category': 'Overworld',
  };
  OverlayEntry? _filterOverlay;

  Widget _shimmerRow() {
    return Row(
      children: [
        SizedBox(width: 10.wr),
        ShimmerComponent.circular(height: 26.wr, width: 26.wr),
        SizedBox(width: 10.wr),
        Expanded(flex: 4, child: ShimmerComponent.regtangular(height: 26.wr)),
        SizedBox(width: 10.wr),
        Expanded(flex: 4, child: ShimmerComponent.regtangular(height: 26.wr)),
        SizedBox(width: 10.wr),
        Expanded(flex: 3, child: ShimmerComponent.regtangular(height: 26.wr)),
        SizedBox(width: 10.wr),
        Expanded(flex: 2, child: ShimmerComponent.regtangular(height: 26.wr)),
        SizedBox(width: 10.wr),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final speedruns = ref.watch(fetchSpeedrunProvider(
        sortBy: 'time',
        sortDir: 'asc',
        page: pageSpeedrun,
        limit: limitSpeedrun,
        approved: true,
        queryParam: _speedrunFilter));
    final dps = ref.watch(fetchDpsProvider(
        sortBy: 'time', sortDir: 'asc', page: pageDps, limit: limitDps, approved: true, queryParam: _dpsFilter));
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
                                    _speedrunFilter['speedrun_category'] = SPEEDRUN_CATEGORY_ORDER[index];
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
                                    _dpsFilter['dps_category'] = DPS_CATEGORY_ORDER[index];
                                  }))))),
          const SizedBox(height: 8),
          Divider(color: Theme.of(context).colorScheme.outline, height: 32),
          if (MediaQuery.of(context).size.width <= 565)
            SizedBox(
                width: 30.wr,
                height: 30.wr,
                child: IconButton(
                    onPressed: _showFilterOverlay,
                    icon: _speedrunFilter.isNotEmpty
                        ? Icon(Icons.filter_alt, size: 16.wr)
                        : Icon(Icons.filter_alt_off, size: 16.wr)))
          else
            Filter(
                type: widget.currentLeaderboardCategory,
                category:
                    widget.currentLeaderboardCategory == 'Speedrun' ? _currentSpeedrunCategory : _currentDpsCategory,
                onFilterChanged: _filterChanged),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceDim,
                    borderRadius: BorderRadius.circular(5.wr),
                  ),
                  width: double.infinity,
                  child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceDim,
                        borderRadius: BorderRadius.circular(5.wr),
                        border: Border.all(color: Theme.of(context).colorScheme.outline),
                      ),
                      child: Column(children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(5.wr)),
                          child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surfaceContainerLowest,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: speedruns.when(
                                data: (data) {
                                  if (_currentSpeedrunCategory == 'Abyss') {
                                    return const TableHeaderAbyss();
                                  } else if (_currentSpeedrunCategory == 'Domain') {
                                    return const TableHeaderDomain();
                                  } else if (_currentSpeedrunCategory == 'Event') {
                                    return const TableHeaderEvent();
                                  } else if (_currentSpeedrunCategory == 'Weekly Boss') {
                                    return const TableHeaderBoss();
                                  } else {
                                    return const TableHeaderBoss();
                                  }
                                },
                                error: (error, stack) => Text(error.toString(), style: TextStyle(fontSize: 12.wr)),
                                loading: () => _shimmerRow(),
                              )),
                        ),
                        Divider(color: Theme.of(context).colorScheme.outline, thickness: 1, height: 0),
                        ClipRRect(
                            borderRadius: BorderRadius.vertical(bottom: Radius.circular(5.wr)),
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.onInverseSurface,
                                ),
                                child: speedruns.when(
                                    data: (data) {
                                      if (data.$2.isEmpty) {
                                        return Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 10),
                                            child: Text(
                                              "No information to display",
                                              style: TextStyle(fontSize: 14.wr),
                                            ),
                                          ),
                                        );
                                      }

                                      return Column(
                                          children: List.generate(data.$2.length, (index) {
                                        final value = data.$2[index];
                                        final charUsageCompetitor = data.$3.firstWhere(
                                            (element) => element.competitorId == data.$2[index].competitor.id);
                                        Widget child;
                                        if (_currentSpeedrunCategory == 'Abyss') {
                                          child = TableRowAbyss(
                                              speedrun: value,
                                              rank: (index + 1).toString(),
                                              characterUsage: charUsageCompetitor.characterUsage);
                                        } else if (_currentSpeedrunCategory == 'Domain') {
                                          child = TableRowDomain(
                                              speedrun: value,
                                              rank: (index + 1).toString(),
                                              characterUsage: charUsageCompetitor.characterUsage);
                                        } else if (_currentSpeedrunCategory == 'Event') {
                                          child = TableRowEvent(
                                              speedrun: value,
                                              rank: (index + 1).toString(),
                                              characterUsage: charUsageCompetitor.characterUsage);
                                        } else {
                                          child = TableRowBoss(
                                              speedrun: value,
                                              rank: (index + 1).toString(),
                                              characterUsage: charUsageCompetitor.characterUsage);
                                        }
                                        return CustomPopupMenu(
                                            pressType: PressType.longPress,
                                            position: PreferredPosition.bottom,
                                            verticalMargin: 0,
                                            horizontalMargin: 0,
                                            arrowColor: Theme.of(context).colorScheme.surfaceContainerLowest,
                                            onTap: () {
                                              context.push(Routes.video(value.id));
                                            },
                                            menuBuilder: () => Container(
                                                decoration: BoxDecoration(
                                                    color: Theme.of(context).colorScheme.surfaceContainerLowest,
                                                    border:
                                                        Border.all(color: Theme.of(context).colorScheme.outlineVariant),
                                                    borderRadius: BorderRadius.circular(5.wr)),
                                                child: Material(
                                                    color: Colors.transparent,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(5.wr)),
                                                    child: IntrinsicWidth(
                                                        child: Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                                            children: [
                                                          InkWell(
                                                              onTap: () {},
                                                              highlightColor:
                                                                  Theme.of(context).colorScheme.surfaceContainerHigh,
                                                              splashColor:
                                                                  Theme.of(context).colorScheme.surfaceContainerHighest,
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft: Radius.circular(5.wr),
                                                                  topRight: Radius.circular(5.wr),
                                                                  bottomLeft: value.accountSnapshot != null &&
                                                                          value.accountSnapshot!.isNotEmpty
                                                                      ? const Radius.circular(0)
                                                                      : Radius.circular(5.wr),
                                                                  bottomRight: value.accountSnapshot != null &&
                                                                          value.accountSnapshot!.isNotEmpty
                                                                      ? const Radius.circular(0)
                                                                      : Radius.circular(5.wr)),
                                                              child: Padding(
                                                                  padding: EdgeInsets.symmetric(
                                                                      vertical: 10.wr, horizontal: 10.wr),
                                                                  child: Row(children: [
                                                                    Icon(Icons.flag, size: 16.wr),
                                                                    SizedBox(width: 5.wr),
                                                                    Text('Report', style: TextStyle(fontSize: 12.wr))
                                                                  ]))),
                                                          if (value.accountSnapshot != null &&
                                                              value.accountSnapshot!.isNotEmpty)
                                                            InkWell(
                                                                onTap: () {},
                                                                highlightColor:
                                                                    Theme.of(context).colorScheme.surfaceContainerHigh,
                                                                splashColor: Theme.of(context)
                                                                    .colorScheme
                                                                    .surfaceContainerHighest,
                                                                borderRadius: BorderRadius.only(
                                                                    bottomLeft: Radius.circular(5.wr),
                                                                    bottomRight: Radius.circular(5.wr)),
                                                                child: Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        vertical: 10.wr, horizontal: 10.wr),
                                                                    child: Row(children: [
                                                                      Icon(Icons.zoom_in, size: 16.wr),
                                                                      SizedBox(width: 5.wr),
                                                                      Text('View Builds',
                                                                          style: TextStyle(fontSize: 12.wr))
                                                                    ]))),
                                                        ])))),
                                            child: child);
                                      }));
                                    },
                                    error: (error, stackTrace) => Center(
                                        child: AppErrorWidget(message: [error.toString(), stackTrace.toString()])),
                                    loading: () => Column(children: [
                                          Padding(padding: EdgeInsets.symmetric(vertical: 10.wr), child: _shimmerRow()),
                                          Divider(
                                              color: Theme.of(context).colorScheme.outline, thickness: 1, height: 0),
                                          Padding(padding: EdgeInsets.symmetric(vertical: 10.wr), child: _shimmerRow()),
                                          Divider(
                                              color: Theme.of(context).colorScheme.outline, thickness: 1, height: 0),
                                          Padding(padding: EdgeInsets.symmetric(vertical: 10.wr), child: _shimmerRow()),
                                          Divider(
                                              color: Theme.of(context).colorScheme.outline, thickness: 1, height: 0),
                                          Padding(padding: EdgeInsets.symmetric(vertical: 10.wr), child: _shimmerRow()),
                                          Divider(
                                              color: Theme.of(context).colorScheme.outline, thickness: 1, height: 0),
                                          Padding(padding: EdgeInsets.symmetric(vertical: 10.wr), child: _shimmerRow()),
                                          Divider(
                                              color: Theme.of(context).colorScheme.outline, thickness: 1, height: 0),
                                          Padding(padding: EdgeInsets.symmetric(vertical: 10.wr), child: _shimmerRow()),
                                          Divider(
                                              color: Theme.of(context).colorScheme.outline, thickness: 1, height: 0),
                                          Padding(padding: EdgeInsets.symmetric(vertical: 10.wr), child: _shimmerRow()),
                                          Divider(
                                              color: Theme.of(context).colorScheme.outline, thickness: 1, height: 0),
                                        ]))))
                      ]))))
        ]));
  }

  void _filterChanged(Map<String, dynamic> applied) {
    if (widget.currentLeaderboardCategory == 'Speedrun') {
      setState(() {
        _speedrunFilter = applied;
      });
    } else {
      setState(() {
        _dpsFilter = applied;
      });
    }
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
