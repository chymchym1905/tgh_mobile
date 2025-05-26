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
                                            loading: () => _shimmerTable()))),
                      ])))),
          10.verticalSpace,
          widget.currentLeaderboardCategory == 'Speedrun'
              ? Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Row(children: [
                    Text('Rows per page:', style: TextStyle(fontSize: 10.wr)),
                    SizedBox(width: 5.wr),
                    SizedBox(
                        width: 60.wr,
                        child: CustomDropdown(
                            decoration: CustomDropdownDecoration(
                              expandedShadow: [
                                BoxShadow(
                                    color: Theme.of(context).colorScheme.shadow,
                                    offset: const Offset(0, 3),
                                    blurRadius: 6,
                                    spreadRadius: 0)
                              ],
                              closedFillColor: Theme.of(context).colorScheme.surfaceContainerLow,
                              closedBorder: Border.all(color: Theme.of(context).colorScheme.outline),
                              expandedBorder: Border.all(color: Theme.of(context).colorScheme.outline),
                              expandedFillColor: Theme.of(context).colorScheme.surfaceContainerHigh,
                              listItemStyle: TextStyle(fontSize: 10.wr),
                              headerStyle: TextStyle(fontSize: 10.wr),
                              expandedSuffixIcon: Icon(Icons.arrow_drop_up, size: 10.wr),
                              closedSuffixIcon: Icon(Icons.arrow_drop_down, size: 10.wr),
                            ),
                            // hideSelectedFieldWhenExpanded: true,
                            closedHeaderPadding: EdgeInsets.symmetric(horizontal: 10.wr, vertical: 5.wr),
                            expandedHeaderPadding: EdgeInsets.symmetric(horizontal: 10.wr, vertical: 5.wr),
                            itemsListPadding: const EdgeInsets.all(0),
                            listItemPadding: EdgeInsets.symmetric(horizontal: 10.wr, vertical: 5.wr),
                            items: const [10, 20, 50, 100],
                            onChanged: (p0) {
                              setState(() {
                                limitSpeedrun = p0!;
                                pageSpeedrun = 0;
                              });
                            },
                            initialItem: limitSpeedrun))
                  ]),
                  speedruns.when(
                      data: (data) {
                        final hasNextPage = (pageSpeedrun + 1) * limitSpeedrun < data.$1;
                        return Row(children: [
                          SizedBox(
                              width: 20.wr,
                              height: 20.wr,
                              child: IconButton(
                                  padding: const EdgeInsets.all(0),
                                  iconSize: 16.wr,
                                  onPressed: pageSpeedrun > 0
                                      ? () => setState(() {
                                            pageSpeedrun--;
                                          })
                                      : null,
                                  icon: const Icon(Icons.chevron_left))),
                          SizedBox(width: 2.wr),
                          Text('${pageSpeedrun + 1}', style: TextStyle(fontSize: 10.wr)),
                          SizedBox(width: 2.wr),
                          SizedBox(
                              width: 20.wr,
                              height: 20.wr,
                              child: IconButton(
                                  padding: const EdgeInsets.all(0),
                                  iconSize: 16.wr,
                                  onPressed: hasNextPage
                                      ? () => setState(() {
                                            pageSpeedrun++;
                                          })
                                      : null,
                                  icon: const Icon(Icons.chevron_right))),
                          Text(
                              '${(pageSpeedrun * limitSpeedrun) + 1}-${(pageSpeedrun + 1) * limitSpeedrun > data.$1 ? data.$1 : (pageSpeedrun + 1) * limitSpeedrun} of ${data.$1}',
                              style: TextStyle(fontSize: 10.wr))
                        ]);
                      },
                      error: (_, __) => const SizedBox.shrink(),
                      loading: () => SizedBox(width: 20.wr, height: 20.wr, child: const CircularProgressIndicator()))
                ])
              : widget.currentLeaderboardCategory == 'DPS'
                  ? Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Row(children: [
                        Text('Rows per page:', style: TextStyle(fontSize: 10.wr)),
                        SizedBox(width: 5.wr),
                        SizedBox(
                            width: 60.wr,
                            child: CustomDropdown(
                                decoration: CustomDropdownDecoration(
                                  expandedShadow: [
                                    BoxShadow(
                                        color: Theme.of(context).colorScheme.shadow,
                                        offset: const Offset(0, 3),
                                        blurRadius: 6,
                                        spreadRadius: 0)
                                  ],
                                  closedFillColor: Theme.of(context).colorScheme.surfaceContainerLow,
                                  closedBorder: Border.all(color: Theme.of(context).colorScheme.outline),
                                  expandedBorder: Border.all(color: Theme.of(context).colorScheme.outline),
                                  expandedFillColor: Theme.of(context).colorScheme.surfaceContainerHigh,
                                  listItemStyle: TextStyle(fontSize: 10.wr),
                                  headerStyle: TextStyle(fontSize: 10.wr),
                                  expandedSuffixIcon: Icon(Icons.arrow_drop_up, size: 10.wr),
                                  closedSuffixIcon: Icon(Icons.arrow_drop_down, size: 10.wr),
                                ),
                                closedHeaderPadding: EdgeInsets.symmetric(horizontal: 10.wr, vertical: 5.wr),
                                expandedHeaderPadding: EdgeInsets.symmetric(horizontal: 10.wr, vertical: 5.wr),
                                itemsListPadding: const EdgeInsets.all(0),
                                listItemPadding: EdgeInsets.symmetric(horizontal: 10.wr, vertical: 5.wr),
                                items: const [10, 20, 50, 100],
                                onChanged: (p0) {
                                  setState(() {
                                    limitDps = p0!;
                                    pageDps = 0;
                                  });
                                },
                                initialItem: limitDps))
                      ]),
                      dps.when(
                          data: (data) {
                            final hasNextPage = (pageDps + 1) * limitDps < data.$1;
                            return Row(
                              children: [
                                SizedBox(
                                    width: 20.wr,
                                    height: 20.wr,
                                    child: IconButton(
                                        padding: const EdgeInsets.all(0),
                                        iconSize: 16.wr,
                                        onPressed: pageDps > 0
                                            ? () => setState(() {
                                                  pageDps--;
                                                })
                                            : null,
                                        icon: const Icon(Icons.chevron_left))),
                                SizedBox(width: 2.wr),
                                Text('${pageDps + 1}', style: TextStyle(fontSize: 10.wr)),
                                SizedBox(width: 2.wr),
                                SizedBox(
                                    width: 20.wr,
                                    height: 20.wr,
                                    child: IconButton(
                                        padding: const EdgeInsets.all(0),
                                        iconSize: 16.wr,
                                        onPressed: hasNextPage
                                            ? () => setState(() {
                                                  pageDps++;
                                                })
                                            : null,
                                        icon: const Icon(Icons.chevron_right))),
                                Text(
                                    '${(pageDps * limitDps) + 1}-${(pageDps + 1) * limitDps > data.$1 ? data.$1 : (pageDps + 1) * limitDps} of ${data.$1}',
                                    style: TextStyle(fontSize: 10.wr))
                              ],
                            );
                          },
                          error: (_, __) => const SizedBox.shrink(),
                          loading: () =>
                              SizedBox(width: 20.wr, height: 20.wr, child: const CircularProgressIndicator()))
                    ])
                  : Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Row(children: [
                        Text('Rows per page:', style: TextStyle(fontSize: 10.wr)),
                        SizedBox(width: 5.wr),
                        SizedBox(
                            width: 60.wr,
                            child: CustomDropdown(
                                decoration: CustomDropdownDecoration(
                                  expandedShadow: [
                                    BoxShadow(
                                        color: Theme.of(context).colorScheme.shadow,
                                        offset: const Offset(0, 3),
                                        blurRadius: 6,
                                        spreadRadius: 0)
                                  ],
                                  closedFillColor: Theme.of(context).colorScheme.surfaceContainerLow,
                                  closedBorder: Border.all(color: Theme.of(context).colorScheme.outline),
                                  expandedBorder: Border.all(color: Theme.of(context).colorScheme.outline),
                                  expandedFillColor: Theme.of(context).colorScheme.surfaceContainerHigh,
                                  listItemStyle: TextStyle(fontSize: 10.wr),
                                  headerStyle: TextStyle(fontSize: 10.wr),
                                  expandedSuffixIcon: Icon(Icons.arrow_drop_up, size: 10.wr),
                                  closedSuffixIcon: Icon(Icons.arrow_drop_down, size: 10.wr),
                                ),
                                closedHeaderPadding: EdgeInsets.symmetric(horizontal: 10.wr, vertical: 5.wr),
                                expandedHeaderPadding: EdgeInsets.symmetric(horizontal: 10.wr, vertical: 5.wr),
                                itemsListPadding: const EdgeInsets.all(0),
                                listItemPadding: EdgeInsets.symmetric(horizontal: 10.wr, vertical: 5.wr),
                                items: const [10, 20, 50, 100],
                                onChanged: (p0) {
                                  setState(() {
                                    limitRestrictedDps = p0!;
                                    pageRestrictedDps = 0;
                                  });
                                },
                                initialItem: limitRestrictedDps))
                      ]),
                      restrictedDps.when(
                          data: (data) {
                            final hasNextPage = (pageRestrictedDps + 1) * limitRestrictedDps < data.$1;
                            return Row(
                              children: [
                                SizedBox(
                                    width: 20.wr,
                                    height: 20.wr,
                                    child: IconButton(
                                        padding: const EdgeInsets.all(0),
                                        iconSize: 16.wr,
                                        onPressed: pageRestrictedDps > 0
                                            ? () => setState(() {
                                                  pageRestrictedDps--;
                                                })
                                            : null,
                                        icon: const Icon(Icons.chevron_left))),
                                SizedBox(width: 2.wr),
                                Text('${pageDps + 1}', style: TextStyle(fontSize: 10.wr)),
                                SizedBox(width: 2.wr),
                                SizedBox(
                                    width: 20.wr,
                                    height: 20.wr,
                                    child: IconButton(
                                        padding: const EdgeInsets.all(0),
                                        iconSize: 16.wr,
                                        onPressed: hasNextPage
                                            ? () => setState(() {
                                                  pageRestrictedDps++;
                                                })
                                            : null,
                                        icon: const Icon(Icons.chevron_right))),
                                Text(
                                    '${(pageRestrictedDps * limitRestrictedDps) + 1}-${(pageRestrictedDps + 1) * limitRestrictedDps > data.$1 ? data.$1 : (pageRestrictedDps + 1) * limitRestrictedDps} of ${data.$1}',
                                    style: TextStyle(fontSize: 10.wr))
                              ],
                            );
                          },
                          error: (_, __) => const SizedBox.shrink(),
                          loading: () =>
                              SizedBox(width: 20.wr, height: 20.wr, child: const CircularProgressIndicator()))
                    ]),
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
