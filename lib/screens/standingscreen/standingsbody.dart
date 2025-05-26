import 'package:collection/collection.dart';
import 'package:tgh_mobile/imports.dart';
import 'table/tableheader_standings.dart';
import 'table/tablerow_standings.dart';

class StandingsBody extends ConsumerStatefulWidget {
  const StandingsBody({super.key});

  @override
  ConsumerState<StandingsBody> createState() => _StandingsBodyState();
}

class _StandingsBodyState extends ConsumerState<StandingsBody> {
  String _currentAbyssVersion = ABYSS_VERSION_HISTORY.last;
  List<String> ABYSS_VERSIONS_REVERSED = ABYSS_VERSION_HISTORY.reversed.toList();

  int limit = 50;
  int page = 0;

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
    final standings = ref.watch(fetchSpeedrunLeaderboardProvider(
      _currentAbyssVersion,
    ));

    return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(15.wr),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.wr, vertical: 16.wr),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Abyss Version', style: GoogleFonts.inter(fontSize: 18.wr, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Wrap(
              direction: Axis.horizontal,
              runSpacing: 8,
              children: List<Widget>.generate(
                  ABYSS_VERSIONS_REVERSED.length,
                  (index) => Padding(
                      padding: EdgeInsets.only(right: 8.wr),
                      child: Material(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.wr)),
                          child: InkWell(
                              onTap: () {
                                setState(() {
                                  _currentAbyssVersion = ABYSS_VERSIONS_REVERSED[index];
                                });
                              },
                              borderRadius: BorderRadius.circular(5.wr),
                              splashColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
                              child: Ink(
                                  decoration: BoxDecoration(
                                      color: _currentAbyssVersion == ABYSS_VERSIONS_REVERSED[index]
                                          ? Theme.of(context).colorScheme.secondaryFixedDim
                                          : Theme.of(context).colorScheme.surfaceContainerHighest,
                                      borderRadius: BorderRadius.circular(5.wr)),
                                  padding: EdgeInsets.only(right: 10.wr, left: 8.wr, bottom: 4.wr, top: 4.wr),
                                  child: Text(ABYSS_VERSIONS_REVERSED[index],
                                      style: TextStyle(
                                          fontSize: 12.wr,
                                          fontWeight: FontWeight.bold,
                                          color: _currentAbyssVersion == ABYSS_VERSIONS_REVERSED[index]
                                              ? Theme.of(context).colorScheme.onPrimary
                                              : Theme.of(context).colorScheme.onSurface)))))))),
          const SizedBox(height: 8),
          Divider(color: Theme.of(context).colorScheme.outline, height: 32),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: standings.when(
                data: (data) {
                  final spots = ref.watch(fetchSpeedrunLeaderboardSpotsProvider(data.instanceId,
                      page: page, daysElapse: 1, sortBy: 'rank', sortDir: 'asc', limit: limit));

                  return Column(children: [
                    Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceDim,
                          borderRadius: BorderRadius.circular(5.wr),
                          border: Border.all(color: Theme.of(context).colorScheme.outline),
                        ),
                        width: double.infinity,
                        child: Column(children: [
                          ClipRRect(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(5.wr)),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surfaceContainerLowest,
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: const TableHeaderStandings(),
                              )),
                          Divider(color: Theme.of(context).colorScheme.outline, thickness: 1, height: 0),
                          ClipRRect(
                              borderRadius: BorderRadius.vertical(bottom: Radius.circular(5.wr)),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.onInverseSurface,
                                ),
                                child: spots.when(
                                    data: (data) {
                                      if (data.$2.isEmpty) {
                                        return Center(
                                            child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 10),
                                                child: Text(
                                                  "No information to display",
                                                  style: TextStyle(fontSize: 14.wr),
                                                )));
                                      }
                                      return Column(
                                          children: List<Widget>.generate(data.$2.length, (index) {
                                        final value = data.$1[index];
                                        final charUsageCompetitor = data.$2.firstWhereOrNull(
                                            (element) => element.competitorId == data.$1[index].competitor.id);
                                        return TableRowStandings(
                                            spot: value, characterUsage: charUsageCompetitor?.characterUsage ?? []);
                                      }));
                                    },
                                    error: (error, stackTrace) => Center(
                                        child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 10),
                                            child: Text(
                                              "No information to display",
                                              style: TextStyle(fontSize: 14.wr),
                                            ))),
                                    loading: () => _shimmerTable()),
                              ))
                        ])),
                    10.verticalSpace,
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
                                    limit = p0!;
                                    page = 0;
                                  });
                                },
                                initialItem: limit))
                      ]),
                      spots.when(
                          data: (data) {
                            final hasNextPage = (page + 1) * limit < data.$1.length;
                            return Row(children: [
                              SizedBox(
                                  width: 20.wr,
                                  height: 20.wr,
                                  child: IconButton(
                                      padding: const EdgeInsets.all(0),
                                      iconSize: 16.wr,
                                      onPressed: page > 0
                                          ? () => setState(() {
                                                page--;
                                              })
                                          : null,
                                      icon: const Icon(Icons.chevron_left))),
                              SizedBox(width: 2.wr),
                              Text('${page + 1}', style: TextStyle(fontSize: 10.wr)),
                              SizedBox(width: 2.wr),
                              SizedBox(
                                  width: 20.wr,
                                  height: 20.wr,
                                  child: IconButton(
                                      padding: const EdgeInsets.all(0),
                                      iconSize: 16.wr,
                                      onPressed: hasNextPage
                                          ? () => setState(() {
                                                page++;
                                              })
                                          : null,
                                      icon: const Icon(Icons.chevron_right))),
                              Text(
                                  '${(page * limit) + 1}-${(page + 1) * limit > data.$1.length ? data.$1.length : (page + 1) * limit} of ${data.$1.length}',
                                  style: TextStyle(fontSize: 10.wr))
                            ]);
                          },
                          error: (_, __) => const SizedBox.shrink(),
                          loading: () =>
                              SizedBox(width: 20.wr, height: 20.wr, child: const CircularProgressIndicator()))
                    ])
                  ]);
                },
                error: (error, stackTrace) => Center(
                    child: Center(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "No information to display",
                              style: TextStyle(fontSize: 14.wr),
                            )))),
                loading: () => Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceDim,
                      borderRadius: BorderRadius.circular(5.wr),
                      border: Border.all(color: Theme.of(context).colorScheme.outline),
                    ),
                    width: double.infinity,
                    child: Column(children: [
                      ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(5.wr)),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surfaceContainerLowest,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: const TableHeaderStandings(),
                          )),
                      Divider(color: Theme.of(context).colorScheme.outline, thickness: 1, height: 0),
                      ClipRRect(
                          borderRadius: BorderRadius.vertical(bottom: Radius.circular(5.wr)),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onInverseSurface,
                            ),
                            child: _shimmerTable(),
                          ))
                    ])),
              ))
        ]));
  }
}
