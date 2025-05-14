import 'package:flutter/foundation.dart';
import 'package:tgh_mobile/imports.dart';

import 'table/tableheader_dps.dart';
import 'table/tableheader_speedrun.dart';
import 'table/tablerow_dps.dart';
import 'table/tablerow_speedrun.dart';

class ProfileBody extends ConsumerStatefulWidget {
  const ProfileBody({super.key, required this.user, required this.userProfileInfo});
  final User user;
  final UserProfileInfo userProfileInfo;

  @override
  ConsumerState<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends ConsumerState<ProfileBody> {
  ScrollController dpsCategoryScrollController = ScrollController();
  ScrollController speedrunCategoryScrollController = ScrollController();

  int limitSpeedrun = 10;
  int pageSpeedrun = 0;
  int _speedrunCategoryIndex = 0;
  String _currentSpeedrunCategory = 'Abyss';

  int limitDps = 10;
  int pageDps = 0;
  int _dpsCategoryIndex = 0;
  String _currentDpsCategory = 'Overworld';

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
    final speedruns = ref.watch(fetchCompetitorSpeedrunsProvider(
      competitorId: widget.user.competitor!.id,
      sortBy: SortBy.createdAt.value,
      sortDir: SortDir.desc.value,
      page: pageSpeedrun,
      limit: limitSpeedrun,
    ));
    final dps = ref.watch(fetchCompetitorDpsProvider(
        competitorId: widget.user.competitor!.id,
        sortBy: SortBy.createdAt.value,
        sortDir: SortDir.desc.value,
        page: pageDps,
        limit: limitDps));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///Speedrun section
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(10.wr),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              speedruns.when(
                data: (data) {
                  final uniqueCategories = data.$2.map((e) => e.speedrunCategory).toSet().toList()
                    ..sort((a, b) => SPEEDRUN_CATEGORY_ORDER.indexOf(a).compareTo(SPEEDRUN_CATEGORY_ORDER.indexOf(b)));

                  if (uniqueCategories.isEmpty) {
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

                  _currentSpeedrunCategory = uniqueCategories[0];
                  final child = SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      controller: speedrunCategoryScrollController,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List<Widget>.generate(
                              uniqueCategories.length,
                              (index) => Padding(
                                  padding: EdgeInsets.only(right: 8.wr),
                                  child: Column(children: [
                                    CategoryTab(
                                        name: uniqueCategories[index],
                                        selected: _speedrunCategoryIndex == index,
                                        onTap: () => setState(() {
                                              _speedrunCategoryIndex = index;
                                              _currentSpeedrunCategory = uniqueCategories[index];
                                            })),
                                    const SizedBox(height: 10),
                                    Text(
                                        '${data.$2.where((e) => e.speedrunCategory == uniqueCategories[index]).length} entries',
                                        style: TextStyle(fontSize: 12.wr))
                                  ])))));
                  if (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.android) {
                    return child;
                  }
                  return Scrollbar(controller: speedrunCategoryScrollController, child: child);
                },
                error: (error, stack) => AppErrorWidget(message: [error.toString(), stack.toString()]),
                loading: () => SizedBox(
                  width: 20.wr,
                  height: 20.wr,
                  child: const CircularProgressIndicator(),
                ),
              ),
              10.verticalSpace,
              // Table header and body
              Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceDim,
                    borderRadius: BorderRadius.circular(5.wr),
                    border: Border.all(color: Theme.of(context).colorScheme.outline),
                  ),
                  child: Column(children: [
                    // Table header
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
                    // Table body
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
                                      children:
                                          data.$2.where((e) => e.speedrunCategory == _currentSpeedrunCategory).map((e) {
                                    Widget child;
                                    if (_currentSpeedrunCategory == 'Abyss') {
                                      child = TableRowSpeedrunAbyss(speedrun: e);
                                    } else if (_currentSpeedrunCategory == 'Domain') {
                                      child = TableRowSpeedrunDomain(speedrun: e);
                                    } else if (_currentSpeedrunCategory == 'Event') {
                                      child = TableRowSpeedrunEvent(speedrun: e);
                                    } else {
                                      child = TableRowSpeedrunBoss(speedrun: e);
                                    }
                                    return CustomPopupMenu(
                                        pressType: PressType.longPress,
                                        position: PreferredPosition.bottom,
                                        verticalMargin: 0,
                                        horizontalMargin: 0,
                                        arrowColor: Theme.of(context).colorScheme.surfaceContainerLowest,
                                        onTap: () {
                                          context.push(Routes.video(e.id));
                                        },
                                        menuBuilder: () => Container(
                                            decoration: BoxDecoration(
                                                color: Theme.of(context).colorScheme.surfaceContainerLowest,
                                                border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
                                                borderRadius: BorderRadius.circular(5.wr)),
                                            child: Material(
                                                color: Colors.transparent,
                                                shape:
                                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.wr)),
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
                                                              bottomLeft: e.accountSnapshot != null &&
                                                                      e.accountSnapshot!.isNotEmpty
                                                                  ? const Radius.circular(0)
                                                                  : Radius.circular(5.wr),
                                                              bottomRight: e.accountSnapshot != null &&
                                                                      e.accountSnapshot!.isNotEmpty
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
                                                      if (e.accountSnapshot != null && e.accountSnapshot!.isNotEmpty)
                                                        InkWell(
                                                            onTap: () {},
                                                            highlightColor:
                                                                Theme.of(context).colorScheme.surfaceContainerHigh,
                                                            splashColor:
                                                                Theme.of(context).colorScheme.surfaceContainerHighest,
                                                            borderRadius: BorderRadius.only(
                                                                bottomLeft: Radius.circular(5.wr),
                                                                bottomRight: Radius.circular(5.wr)),
                                                            child: Padding(
                                                                padding: EdgeInsets.symmetric(
                                                                    vertical: 10.wr, horizontal: 10.wr),
                                                                child: Row(children: [
                                                                  Icon(Icons.zoom_in, size: 16.wr),
                                                                  SizedBox(width: 5.wr),
                                                                  Text('View Builds', style: TextStyle(fontSize: 12.wr))
                                                                ]))),
                                                    ])))),
                                        child: child);
                                  }).toList());
                                },
                                error: (error, stackTrace) =>
                                    Center(child: AppErrorWidget(message: [error.toString(), stackTrace.toString()])),
                                loading: () => Column(children: [
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
                                    ]))))
                  ])),
              10.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('Rows per page:', style: TextStyle(fontSize: 12.wr)),
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
                              listItemStyle: TextStyle(fontSize: 12.wr),
                              headerStyle: TextStyle(fontSize: 12.wr),
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
                            initialItem: limitSpeedrun),
                      ),
                    ],
                  ),
                  speedruns.when(
                    data: (data) {
                      final hasNextPage = (pageSpeedrun + 1) * limitSpeedrun < data.$1;
                      return Row(
                        children: [
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
                          Text('${pageSpeedrun + 1}', style: TextStyle(fontSize: 12.wr)),
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
                              style: TextStyle(fontSize: 12.wr))
                        ],
                      );
                    },
                    error: (_, __) => const SizedBox.shrink(),
                    loading: () => SizedBox(width: 20.wr, height: 20.wr, child: const CircularProgressIndicator()),
                  ),
                ],
              ),
            ],
          ),
        ),
        50.verticalSpace,

        ///DPS section
        Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(10.wr),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              dps.when(
                data: (data) {
                  final uniqueCategories = data.$2.map((e) => e.dpsCategory).toSet().toList()
                    ..sort((a, b) => DPS_CATEGORY_ORDER.indexOf(a).compareTo(DPS_CATEGORY_ORDER.indexOf(b)));

                  if (uniqueCategories.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  _currentDpsCategory = uniqueCategories[0];
                  final child = SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      controller: dpsCategoryScrollController,
                      child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: List<Widget>.generate(
                                  uniqueCategories.length,
                                  (index) => Padding(
                                      padding: EdgeInsets.only(right: 8.wr),
                                      child: Column(
                                        children: [
                                          CategoryTab(
                                              name: uniqueCategories[index],
                                              selected: _dpsCategoryIndex == index,
                                              onTap: () => setState(() {
                                                    _dpsCategoryIndex = index;
                                                    _currentDpsCategory = uniqueCategories[index];
                                                  })),
                                          const SizedBox(height: 10),
                                          Text(
                                              '${data.$2.where((e) => e.dpsCategory == uniqueCategories[index]).length} entries',
                                              style: TextStyle(fontSize: 12.wr))
                                        ],
                                      ))))));
                  if (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.android) {
                    return child;
                  } else {
                    return Scrollbar(controller: dpsCategoryScrollController, child: child);
                  }
                },
                error: (error, stack) => AppErrorWidget(message: [error.toString(), stack.toString()]),
                loading: () => SizedBox(
                  width: 20.wr,
                  height: 20.wr,
                  child: const CircularProgressIndicator(),
                ),
              ),
              10.verticalSpace,
              10.verticalSpace,
              Container(
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
                          child: dps.when(
                            data: (data) {
                              if (_currentDpsCategory == 'Event') {
                                return const TableHeaderEvent();
                              } else {
                                return const TableHeaderDps();
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
                            child: dps.when(
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
                                      children: data.$2
                                          .where((e) => e.dpsCategory == _currentDpsCategory)
                                          .map((e) => CustomPopupMenu(
                                              pressType: PressType.longPress,
                                              position: PreferredPosition.bottom,
                                              verticalMargin: 0,
                                              horizontalMargin: 0,
                                              arrowColor: Theme.of(context).colorScheme.surfaceContainerLowest,
                                              onTap: () {
                                                context.push(Routes.video(e.id));
                                              },
                                              menuBuilder: () => Container(
                                                  decoration: BoxDecoration(
                                                      color: Theme.of(context).colorScheme.surfaceContainerLowest,
                                                      border: Border.all(
                                                          color: Theme.of(context).colorScheme.outlineVariant),
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
                                                                splashColor: Theme.of(context)
                                                                    .colorScheme
                                                                    .surfaceContainerHighest,
                                                                borderRadius: BorderRadius.only(
                                                                    topLeft: Radius.circular(5.wr),
                                                                    topRight: Radius.circular(5.wr),
                                                                    bottomLeft: e.accountSnapshot != null &&
                                                                            e.accountSnapshot!.isNotEmpty
                                                                        ? const Radius.circular(0)
                                                                        : Radius.circular(5.wr),
                                                                    bottomRight: e.accountSnapshot != null &&
                                                                            e.accountSnapshot!.isNotEmpty
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
                                                            if (e.accountSnapshot != null &&
                                                                e.accountSnapshot!.isNotEmpty)
                                                              InkWell(
                                                                  onTap: () {},
                                                                  highlightColor: Theme.of(context)
                                                                      .colorScheme
                                                                      .surfaceContainerHigh,
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
                                              child: _currentDpsCategory == 'Event'
                                                  ? TableRowDpsEvent(dps: e)
                                                  : TableRowDps(dps: e)))
                                          .toList());
                                },
                                error: (error, stackTrace) =>
                                    Center(child: AppErrorWidget(message: [error.toString(), stackTrace.toString()])),
                                loading: () => Column(children: [
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
                                    ]))))
                  ])),
              10.verticalSpace,
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(
                  children: [
                    Text('Rows per page:', style: TextStyle(fontSize: 12.wr)),
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
                            listItemStyle: TextStyle(fontSize: 12.wr),
                            headerStyle: TextStyle(fontSize: 12.wr),
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
                          initialItem: limitDps),
                    ),
                  ],
                ),
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
                          Text('${pageDps + 1}', style: TextStyle(fontSize: 12.wr)),
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
                              style: TextStyle(fontSize: 12.wr))
                        ],
                      );
                    },
                    error: (_, __) => const SizedBox.shrink(),
                    loading: () => SizedBox(width: 20.wr, height: 20.wr, child: const CircularProgressIndicator()))
              ])
            ])),
      ],
    );
  }
}
