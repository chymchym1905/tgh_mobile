import 'package:tgh_mobile/imports.dart';
import 'package:tgh_mobile/screens/profilescreen/table/tableheader_standings.dart';
import 'package:tgh_mobile/screens/profilescreen/table/tablerow_standings.dart';

class StandingsSection extends ConsumerStatefulWidget {
  const StandingsSection({super.key, required this.userProfileInfo});
  final UserProfileInfo userProfileInfo;

  @override
  ConsumerState<StandingsSection> createState() => _StandingsSectionState();
}

class _StandingsSectionState extends ConsumerState<StandingsSection> {
  ScrollController speedrunCategoryScrollController = ScrollController();

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
    return Container(
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
                child: const TableheaderStandings()),
          ),
          Divider(color: Theme.of(context).colorScheme.outline, thickness: 1, height: 0),
          ClipRRect(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(5.wr)),
              child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onInverseSurface,
                  ),
                  child: Column(
                    children: widget.userProfileInfo.rankInfo
                            ?.map(
                              (e) => Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                      hoverColor: Theme.of(context).colorScheme.surfaceContainerLow,
                                      focusColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      child: TableRowStandings(rankInfo: e))),
                            )
                            .toList() ??
                        [
                          Center(
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Text("No information to display", style: TextStyle(fontSize: 14.wr))))
                        ],
                  )))
        ],
      ),
    );
  }
}
