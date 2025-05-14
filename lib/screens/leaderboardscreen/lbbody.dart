import 'package:collection/collection.dart';
import 'package:tgh_mobile/imports.dart';
import 'package:tgh_mobile/screens/leaderboardscreen/filter.dart';
import 'filteroverlay.dart';
import 'table/tableheader_dps.dart';
import 'table/tableheader_speedrun.dart';
import 'table/tablerow_dps.dart';
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
  String _currentSpeedrunCategory = SPEEDRUN_CATEGORY_ORDER.first;

  int limitDps = 10;
  int pageDps = 0;
  int _dpsCategoryIndex = 0;
  String _currentDpsCategory = DPS_CATEGORY_ORDER.first;

  int pageRestrictedDps = 0;
  int limitRestrictedDps = 10;
  int _restrictedDpsCategoryIndex = 0;
  String _currentRestrictedDpsCategory = RESTRICTED_DPS_CATEGORY_ORDER.first;

  OverlayEntry? _filterOverlay;

  final GlobalKey<FilterState> _filterKey = GlobalKey<FilterState>();

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

  Widget _shimmerTable() {
    return Column(children: [
      Padding(padding: EdgeInsets.symmetric(vertical: 10.wr), child: _shimmerRow()),
      Divider(color: Theme.of(context).colorScheme.outline, thickness: 1, height: 0),
      Padding(padding: EdgeInsets.symmetric(vertical: 10.wr), child: _shimmerRow()),
      Divider(color: Theme.of(context).colorScheme.outline, thickness: 1, height: 0),
      Padding(padding: EdgeInsets.symmetric(vertical: 10.wr), child: _shimmerRow()),
      Divider(color: Theme.of(context).colorScheme.outline, thickness: 1, height: 0),
      Padding(padding: EdgeInsets.symmetric(vertical: 10.wr), child: _shimmerRow()),
      Divider(color: Theme.of(context).colorScheme.outline, thickness: 1, height: 0),
      Padding(padding: EdgeInsets.symmetric(vertical: 10.wr), child: _shimmerRow()),
      Divider(color: Theme.of(context).colorScheme.outline, thickness: 1, height: 0),
      Padding(padding: EdgeInsets.symmetric(vertical: 10.wr), child: _shimmerRow()),
      Divider(color: Theme.of(context).colorScheme.outline, thickness: 1, height: 0),
      Padding(padding: EdgeInsets.symmetric(vertical: 10.wr), child: _shimmerRow()),
      Divider(color: Theme.of(context).colorScheme.outline, thickness: 1, height: 0),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final speedrunFilter = ref.watch(speedrunLeaderboardFilterNotifierProvider);
    final dpsFilter = ref.watch(dpsLeaderboardFilterNotifierProvider);
    final restrictedDpsFilter = ref.watch(restrictedDpsLeaderboardFilterNotifierProvider);
    final speedruns = ref.watch(fetchSpeedrunProvider(
        sortBy: SortBy.time.value,
        sortDir: SortDir.asc.value,
        page: pageSpeedrun,
        limit: limitSpeedrun,
        approved: true,
        queryParam: speedrunFilter.appliedFilter));

    final dps = ref.watch(fetchDpsProvider(
        sortBy: SortBy.damageDealt.value,
        sortDir: SortDir.desc.value,
        page: pageDps,
        limit: limitDps,
        approved: true,
        queryParam: dpsFilter.appliedFilter));

    final restrictedDps = ref.watch(fetchRestrictedDpsProvider(
        sortBy: SortBy.damageDealt.value,
        sortDir: SortDir.desc.value,
        page: pageRestrictedDps,
        limit: limitRestrictedDps,
        approved: true,
        queryParam: restrictedDpsFilter.appliedFilter));

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
                                  ref.read(speedrunLeaderboardFilterNotifierProvider.notifier).updateFilter(
                                      speedrunFilter.defaultAppliedFilter[SPEEDRUN_CATEGORY_ORDER[index]]
                                          as Map<String, dynamic>);
                                  ref.read(appliedDisplayFilterProvider.notifier).state = {};
                                }))))
                : widget.currentLeaderboardCategory == 'DPS'
                    ? List<Widget>.generate(
                        DPS_CATEGORY_ORDER.length,
                        (index) => Padding(
                            padding: EdgeInsets.only(right: 8.wr),
                            child: CategoryTab(
                                name: DPS_CATEGORY_ORDER[index],
                                selected: _dpsCategoryIndex == index,
                                onTap: () => setState(() {
                                      _dpsCategoryIndex = index;
                                      _currentDpsCategory = DPS_CATEGORY_ORDER[index];
                                      ref.read(dpsLeaderboardFilterNotifierProvider.notifier).updateFilter(dpsFilter
                                          .defaultAppliedFilter[DPS_CATEGORY_ORDER[index]] as Map<String, dynamic>);
                                      ref.read(appliedDisplayFilterProvider.notifier).state = {};
                                    }))))
                    : List<Widget>.generate(
                        RESTRICTED_DPS_CATEGORY_ORDER.length,
                        (index) => Padding(
                            padding: EdgeInsets.only(right: 8.wr),
                            child: CategoryTab(
                                name: RESTRICTED_DPS_CATEGORY_ORDER[index],
                                selected: _restrictedDpsCategoryIndex == index,
                                onTap: () => setState(() {
                                      _restrictedDpsCategoryIndex = index;
                                      _currentRestrictedDpsCategory = RESTRICTED_DPS_CATEGORY_ORDER[index];
                                      ref.read(restrictedDpsLeaderboardFilterNotifierProvider.notifier).updateFilter(
                                          restrictedDpsFilter.defaultAppliedFilter[RESTRICTED_DPS_CATEGORY_ORDER[index]]
                                              as Map<String, dynamic>);
                                      ref.read(appliedDisplayFilterProvider.notifier).state = {};
                                    })))),
          ),
          const SizedBox(height: 8),
          Divider(color: Theme.of(context).colorScheme.outline, height: 32),
          if (MediaQuery.of(context).size.width <= 565)
            Wrap(
                direction: Axis.horizontal,
                spacing: 4.wr,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  SizedBox(
                      width: 30.wr,
                      height: 30.wr,
                      child: IconButton(
                          onPressed: _showFilterOverlay,
                          icon: ref.read(appliedDisplayFilterProvider).isEmpty
                              ? Icon(Icons.filter_alt, size: 16.wr)
                              : Icon(Icons.filter_alt_off, size: 16.wr))),
                  ...ref.watch(appliedDisplayFilterProvider).entries.map((e) {
                    final key = e.key;
                    final value = e.value;
                    String displayValue = '';
                    if (key == 'Characters') {
                      displayValue = 'Characters: ${value.join(', ')}';
                    } else if (key == 'Domain') {
                      displayValue = value.toString();
                    } else if (key == 'Event') {
                      displayValue = value.toString();
                    } else if (key == 'Enemy') {
                      displayValue = '$key: ${value.toString()}';
                    } else if (key == 'Region') {
                      displayValue = value.toString();
                    } else if (key == 'Abyss version') {
                      displayValue = '$key ${value.toString()}';
                    } else if (key == 'Attack Type') {
                      displayValue = 'Ability: ${value.toString()}';
                    } else if (key == 'Chamber') {
                      displayValue = '$key ${value.toString()}';
                    } else if (key == 'From competitor') {
                      displayValue = 'From competitor: ${value.toString()}';
                    } else if (key == 'DpsCharacter') {
                      displayValue = 'Nuker: ${value.toString()}';
                    }
                    return Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
                          border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 8.wr, vertical: 6),
                        child: Center(
                            widthFactor: 1,
                            child: Text(displayValue,
                                style: TextStyle(
                                    fontSize: 12.wr, color: Theme.of(context).colorScheme.secondaryFixedDim))));
                  })
                ])
          else
            Filter(
                key: _filterKey,
                type: widget.currentLeaderboardCategory,
                category: widget.currentLeaderboardCategory == 'Speedrun'
                    ? _currentSpeedrunCategory
                    : widget.currentLeaderboardCategory == 'DPS'
                        ? _currentDpsCategory
                        : _currentRestrictedDpsCategory,
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
                            child: widget.currentLeaderboardCategory == 'Speedrun'
                                ? speedruns.when(
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
                                  )
                                : widget.currentLeaderboardCategory == 'DPS'
                                    ? dps.when(
                                        data: (data) {
                                          if (_currentDpsCategory == 'Event') {
                                            return const TableHeaderEvent();
                                          } else if (_currentDpsCategory == 'Domain') {
                                            return const TableHeaderDomain();
                                          } else {
                                            return const TableHeaderDps();
                                          }
                                        },
                                        error: (error, stack) =>
                                            Text(error.toString(), style: TextStyle(fontSize: 12.wr)),
                                        loading: () => _shimmerRow(),
                                      )
                                    : restrictedDps.when(
                                        data: (data) {
                                          if (_currentRestrictedDpsCategory == 'Event') {
                                            return const TableHeaderEvent();
                                          } else if (_currentRestrictedDpsCategory == 'Domain') {
                                            return const TableHeaderDomain();
                                          } else {
                                            return const TableHeaderDps();
                                          }
                                        },
                                        error: (error, stack) =>
                                            Text(error.toString(), style: TextStyle(fontSize: 12.wr)),
                                        loading: () => _shimmerRow(),
                                      ),
                          ),
                        ),
                        Divider(color: Theme.of(context).colorScheme.outline, thickness: 1, height: 0),
                        ClipRRect(
                            borderRadius: BorderRadius.vertical(bottom: Radius.circular(5.wr)),
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.onInverseSurface,
                                ),
                                child: widget.currentLeaderboardCategory == 'Speedrun'
                                    ? speedruns.when(
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
                                            final charUsageCompetitor = data.$3.firstWhereOrNull(
                                                (element) => element.competitorId == data.$2[index].competitor.id);
                                            Widget child;
                                            if (_currentSpeedrunCategory == 'Abyss') {
                                              child = TableRowAbyss(
                                                  speedrun: value,
                                                  rank: (index + 1).toString(),
                                                  characterUsage: charUsageCompetitor?.characterUsage);
                                            } else if (_currentSpeedrunCategory == 'Domain') {
                                              child = TableRowDomain(
                                                  speedrun: value,
                                                  rank: (index + 1).toString(),
                                                  characterUsage: charUsageCompetitor?.characterUsage);
                                            } else if (_currentSpeedrunCategory == 'Event') {
                                              child = TableRowEvent(
                                                  speedrun: value,
                                                  rank: (index + 1).toString(),
                                                  characterUsage: charUsageCompetitor?.characterUsage);
                                            } else {
                                              child = TableRowBoss(
                                                  speedrun: value,
                                                  rank: (index + 1).toString(),
                                                  characterUsage: charUsageCompetitor?.characterUsage);
                                            }
                                            return _tableRowSpeedrun(child, value);
                                          }));
                                        },
                                        error: (error, stackTrace) => Center(
                                            child: AppErrorWidget(message: [error.toString(), stackTrace.toString()])),
                                        loading: () => _shimmerTable())
                                    : widget.currentLeaderboardCategory == 'DPS'
                                        ? dps.when(
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
                                                final charUsageCompetitor = data.$3.firstWhereOrNull(
                                                    (element) => element.competitorId == data.$2[index].competitor.id);
                                                Widget child;
                                                if (_currentSpeedrunCategory == 'Event') {
                                                  child = TableRowDpsEvent(
                                                      dps: value,
                                                      rank: (index + 1).toString(),
                                                      characterUsage: charUsageCompetitor?.characterUsage);
                                                } else if (_currentSpeedrunCategory == 'Domain') {
                                                  child = TableRowDpsDomain(
                                                      dps: value,
                                                      rank: (index + 1).toString(),
                                                      characterUsage: charUsageCompetitor?.characterUsage);
                                                } else {
                                                  child = TableRowDps(
                                                      dps: value,
                                                      rank: (index + 1).toString(),
                                                      characterUsage: charUsageCompetitor?.characterUsage);
                                                }
                                                return _tableRowDps(child, value);
                                              }));
                                            },
                                            error: (error, stackTrace) => Center(
                                                child:
                                                    AppErrorWidget(message: [error.toString(), stackTrace.toString()])),
                                            loading: () => _shimmerTable())
                                        : restrictedDps.when(
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
                                                final charUsageCompetitor = data.$3.firstWhereOrNull(
                                                    (element) => element.competitorId == data.$2[index].competitor.id);
                                                Widget child;
                                                if (_currentRestrictedDpsCategory == 'Event') {
                                                  child = TableRowDpsEvent(
                                                      dps: value,
                                                      rank: (index + 1).toString(),
                                                      characterUsage: charUsageCompetitor?.characterUsage);
                                                } else if (_currentRestrictedDpsCategory == 'Domain') {
                                                  child = TableRowDpsDomain(
                                                      dps: value,
                                                      rank: (index + 1).toString(),
                                                      characterUsage: charUsageCompetitor?.characterUsage);
                                                } else {
                                                  child = TableRowDps(
                                                      dps: value,
                                                      rank: (index + 1).toString(),
                                                      characterUsage: charUsageCompetitor?.characterUsage);
                                                }
                                                return _tableRowDps(child, value);
                                              }));
                                            },
                                            error: (error, stackTrace) => Center(
                                                child:
                                                    AppErrorWidget(message: [error.toString(), stackTrace.toString()])),
                                            loading: () => _shimmerTable())))
                      ]))))
        ]));
  }

  void _filterChanged(Map<String, dynamic> applied) {
    if (widget.currentLeaderboardCategory == 'Speedrun') {
      setState(() {
        ref.read(speedrunLeaderboardFilterNotifierProvider.notifier).updateFilter(applied);
      });
    } else if (widget.currentLeaderboardCategory == 'DPS') {
      setState(() {
        ref.read(dpsLeaderboardFilterNotifierProvider.notifier).updateFilter(applied);
      });
    } else {
      setState(() {
        ref.read(restrictedDpsLeaderboardFilterNotifierProvider.notifier).updateFilter(applied);
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
                          filterStateKey: _filterKey,
                          type: widget.currentLeaderboardCategory,
                          popCallback: () => _showFilterOverlay(),
                          category: widget.currentLeaderboardCategory == 'Speedrun'
                              ? _currentSpeedrunCategory
                              : _currentDpsCategory,
                          onFilterChanged: _filterChanged)))
            ]));
    Overlay.of(context).insert(_filterOverlay!);
  }

  Widget _tableRowSpeedrun(Widget child, Speedrun value) {
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
                border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
                borderRadius: BorderRadius.circular(5.wr)),
            child: Material(
                color: Colors.transparent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.wr)),
                child: IntrinsicWidth(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                      InkWell(
                          onTap: () {},
                          highlightColor: Theme.of(context).colorScheme.surfaceContainerHigh,
                          splashColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5.wr),
                              topRight: Radius.circular(5.wr),
                              bottomLeft: value.accountSnapshot != null && value.accountSnapshot!.isNotEmpty
                                  ? const Radius.circular(0)
                                  : Radius.circular(5.wr),
                              bottomRight: value.accountSnapshot != null && value.accountSnapshot!.isNotEmpty
                                  ? const Radius.circular(0)
                                  : Radius.circular(5.wr)),
                          child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.wr, horizontal: 10.wr),
                              child: Row(children: [
                                Icon(Icons.flag, size: 16.wr),
                                SizedBox(width: 5.wr),
                                Text('Report', style: TextStyle(fontSize: 12.wr))
                              ]))),
                      if (value.accountSnapshot != null && value.accountSnapshot!.isNotEmpty)
                        InkWell(
                            onTap: () {},
                            highlightColor: Theme.of(context).colorScheme.surfaceContainerHigh,
                            splashColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5.wr), bottomRight: Radius.circular(5.wr)),
                            child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.wr, horizontal: 10.wr),
                                child: Row(children: [
                                  Icon(Icons.zoom_in, size: 16.wr),
                                  SizedBox(width: 5.wr),
                                  Text('View Builds', style: TextStyle(fontSize: 12.wr))
                                ]))),
                    ])))),
        child: child);
  }

  Widget _tableRowDps(Widget child, DPS value) {
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
                border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
                borderRadius: BorderRadius.circular(5.wr)),
            child: Material(
                color: Colors.transparent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.wr)),
                child: IntrinsicWidth(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                      InkWell(
                          onTap: () {},
                          highlightColor: Theme.of(context).colorScheme.surfaceContainerHigh,
                          splashColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5.wr),
                              topRight: Radius.circular(5.wr),
                              bottomLeft: value.accountSnapshot != null && value.accountSnapshot!.isNotEmpty
                                  ? const Radius.circular(0)
                                  : Radius.circular(5.wr),
                              bottomRight: value.accountSnapshot != null && value.accountSnapshot!.isNotEmpty
                                  ? const Radius.circular(0)
                                  : Radius.circular(5.wr)),
                          child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.wr, horizontal: 10.wr),
                              child: Row(children: [
                                Icon(Icons.flag, size: 16.wr),
                                SizedBox(width: 5.wr),
                                Text('Report', style: TextStyle(fontSize: 12.wr))
                              ]))),
                      if (value.accountSnapshot != null && value.accountSnapshot!.isNotEmpty)
                        InkWell(
                            onTap: () {},
                            highlightColor: Theme.of(context).colorScheme.surfaceContainerHigh,
                            splashColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5.wr), bottomRight: Radius.circular(5.wr)),
                            child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.wr, horizontal: 10.wr),
                                child: Row(children: [
                                  Icon(Icons.zoom_in, size: 16.wr),
                                  SizedBox(width: 5.wr),
                                  Text('View Builds', style: TextStyle(fontSize: 12.wr))
                                ]))),
                    ])))),
        child: child);
  }
}
