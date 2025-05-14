import 'package:tgh_mobile/imports.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({super.key, required this.name, required this.selected, required this.onTap});
  final String name;
  final bool selected;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.wr)),
        child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(5.wr),
            splashColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
            child: Ink(
                decoration: BoxDecoration(
                    color: selected
                        ? Theme.of(context).colorScheme.secondaryFixedDim
                        : Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(5.wr)),
                padding: EdgeInsets.only(right: 10.wr, left: 8.wr, bottom: 4.wr, top: 4.wr),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Image.asset(ASSET_MAPPING[name]!, width: 20.wr, height: 20.wr),
                  const SizedBox(width: 8),
                  Text(name,
                      style: TextStyle(
                          fontSize: 12.wr,
                          fontWeight: FontWeight.bold,
                          color: selected
                              ? Theme.of(context).colorScheme.onPrimary
                              : Theme.of(context).colorScheme.onSurface))
                ]))));
  }
}
