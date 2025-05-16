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
    final standings = ref.watch(fetchSpeedrunLeaderboardProvider(_currentAbyssVersion));
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
                      child: Column(
                        children: [
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
                                child: standings.when(
                                    data: (data) {
                                      final spots = ref.watch(fetchSpeedrunLeaderboardSpotsProvider(data.instanceId,
                                          page: 0, daysElapse: 1, sortBy: 'rank', sortDir: 'asc'));
                                      return spots.when(
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
                                                  spot: value,
                                                  characterUsage: charUsageCompetitor?.characterUsage ?? []);
                                            }));
                                          },
                                          error: (error, stackTrace) => Center(
                                              child: Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                                  child: Text(
                                                    "No information to display",
                                                    style: TextStyle(fontSize: 14.wr),
                                                  ))),
                                          loading: () => _shimmerTable());
                                    },
                                    error: (error, stackTrace) => Center(
                                        child: Center(
                                            child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 10),
                                                child: Text(
                                                  "No information to display",
                                                  style: TextStyle(fontSize: 14.wr),
                                                )))),
                                    loading: () => _shimmerTable()),
                              ))
                        ],
                      ))))
        ]));
  }
}
