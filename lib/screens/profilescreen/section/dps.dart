import 'package:flutter/foundation.dart';
import 'package:tgh_mobile/imports.dart';
import '../table/tablerow_dps.dart';
import '../table/tableheader_dps.dart';

class DpsSection extends ConsumerStatefulWidget {
  const DpsSection({super.key, required this.competitorId});
  final String competitorId;

  @override
  ConsumerState<DpsSection> createState() => _DpsSectionState();
}

class _DpsSectionState extends ConsumerState<DpsSection> {
  ScrollController dpsCategoryScrollController = ScrollController();
  int limitDps = 10;
  int pageDps = 0;
  int _dpsCategoryIndex = 0;
  String _currentDpsCategory = 'Overworld';
  bool _init = false;

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
    final dps = ref.watch(fetchCompetitorDpsProvider(
        competitorId: widget.competitorId,
        sortBy: SortBy.createdAt.value,
        sortDir: SortDir.desc.value,
        page: pageDps,
        limit: limitDps));
    return Container(
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
              if (_init == false) _currentDpsCategory = uniqueCategories[0];
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
                                          onTap: () {
                                            setState(() {
                                              _dpsCategoryIndex = index;
                                              _currentDpsCategory = uniqueCategories[index];
                                            });
                                          }),
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
                            return const TableHeaderDpsEvent();
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
                              _init = true;
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
                                                  border:
                                                      Border.all(color: Theme.of(context).colorScheme.outlineVariant),
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
                loading: () => SizedBox(width: 20.wr, height: 20.wr, child: const CircularProgressIndicator()))
          ])
        ]));
  }
}
