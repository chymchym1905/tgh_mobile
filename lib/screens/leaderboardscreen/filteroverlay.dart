import 'package:tgh_mobile/imports.dart';
import 'filter.dart';

class FilterOverlay extends ConsumerStatefulWidget {
  const FilterOverlay(
      {super.key,
      required this.type,
      required this.category,
      required this.onFilterChanged,
      required this.popCallback,
      required this.filterStateKey});
  final Function(Map<String, dynamic>) onFilterChanged;
  final void Function() popCallback;
  final String type;
  final String category;
  final GlobalKey<FilterState> filterStateKey;

  @override
  ConsumerState<FilterOverlay> createState() => _FilterOverlayState();
}

class _FilterOverlayState extends ConsumerState<FilterOverlay> {
  Map<String, dynamic> _filter = {};

  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   final filterStorage = ref.read(speedrunLeaderboardFilterNotifierProvider);
    //   if (widget.type == 'Speedrun') {
    //     if (widget.category == 'Abyss') {
    //       if (filterStorage.defaultAppliedFilter['Abyss'] != filterStorage.appliedFilter) {
    //         _filter = filterStorage.appliedFilter['Abyss'] as Map<String, dynamic>;
    //       } else {
    //         _filter = filterStorage.defaultFitlerValuesAbyss['Abyss'] as Map<String, dynamic>;
    //       }
    //     } else if (widget.category == 'Domain') {
    //       if (filterStorage.defaultAppliedFilter['Domain'] != filterStorage.appliedFilter) {
    //         _filter = filterStorage.appliedFilter['Domain'] as Map<String, dynamic>;
    //       } else {
    //         _filter = filterStorage.defaultFitlerValuesDomain['Domain'] as Map<String, dynamic>;
    //       }
    //     } else if (widget.category == 'Event') {
    //       if (filterStorage.defaultAppliedFilter['Event'] != filterStorage.appliedFilter) {
    //         _filter = filterStorage.appliedFilter['Event'] as Map<String, dynamic>;
    //       } else {
    //         _filter = filterStorage.defaultFitlerValuesEvent['Event'] as Map<String, dynamic>;
    //       }
    //     } else if (widget.category == 'Weekly Boss') {
    //       if (filterStorage.defaultAppliedFilter['Weekly Boss'] != filterStorage.appliedFilter) {
    //         _filter = filterStorage.appliedFilter['Weekly Boss'] as Map<String, dynamic>;
    //       } else {
    //         _filter = filterStorage.defaultFitlerValuesWeeklyBoss['Weekly Boss'] as Map<String, dynamic>;
    //       }
    //     } else if (widget.category == 'World Boss') {
    //       if (filterStorage.defaultAppliedFilter['World Boss'] != filterStorage.appliedFilter) {
    //         _filter = filterStorage.appliedFilter['World Boss'] as Map<String, dynamic>;
    //       } else {
    //         _filter = filterStorage.defaultFitlerValuesWorldBoss['World Boss'] as Map<String, dynamic>;
    //       }
    //     }
    //   }
    // });
    super.initState();
  }

  void updateFilter(Map<String, dynamic> filter) {
    _filter = filter;
  }

  @override
  Widget build(BuildContext context) {
    return OverlayBase(
        width: 300.w,
        title: 'Filter',
        footer: Row(mainAxisSize: MainAxisSize.min, children: [
          InkWellTextButtonSecondary(
              onTap: () {
                widget.filterStateKey.currentState?.resetFilter();
                widget.onFilterChanged(_filter);
                widget.popCallback();
              },
              text: 'Reset'),
          SizedBox(width: 10.wr),
          InkWellTextButton(
              onTap: () {
                if (_filter.isEmpty) {
                  _filter = widget.filterStateKey.currentState!.localFilter;
                }
                widget.onFilterChanged(_filter);
                widget.popCallback();
              },
              text: 'Apply')
        ]),
        child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 350.h, minHeight: 200.h),
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.wr, vertical: 10),
                child: Filter(
                    key: widget.filterStateKey,
                    type: widget.type,
                    category: widget.category,
                    onFilterChanged: updateFilter))));
  }
}
