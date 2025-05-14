import 'package:tgh_mobile/imports.dart';

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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text('Standings', style: TextStyle(fontSize: 16.wr, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
