import 'package:tgh_mobile/imports.dart';
import 'filter.dart';

class FilterOverlay extends StatelessWidget {
  const FilterOverlay({super.key, required this.type, required this.category, required this.onFilterChanged});
  final Function(Map<String, dynamic>) onFilterChanged;
  final String type;
  final String category;

  @override
  Widget build(BuildContext context) {
    return OverlayBase(
        width: 300.w,
        title: 'Filter',
        footer: Row(mainAxisSize: MainAxisSize.min, children: [
          InkWellTextButtonSecondary(onTap: () {}, text: 'Reset'),
          SizedBox(width: 10.wr),
          InkWellTextButton(
              onTap: () {
                Navigator.pop(context);
              },
              text: 'Apply')
        ]),
        child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 350.h, minHeight: 200.h),
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.wr, vertical: 10),
                child: Filter(type: type, category: category))));
  }
}
