// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tgh_mobile/imports.dart';

class OverlayBase extends StatelessWidget {
  const OverlayBase({
    super.key,
    required this.child,
    required this.title,
    required this.footer,
    this.width,
    this.height,
  });
  final double? width;
  final double? height;
  final Widget child;
  final String title;
  final Widget footer;
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.cover,
      child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceBright,
            border: Border.all(color: Theme.of(context).colorScheme.outline.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(children: [
            Align(
                alignment: const Alignment(-0.95, 0),
                child: Container(
                    padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 4),
                    child: Text(title, style: Theme.of(context).textTheme.titleLarge))),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Divider(color: Theme.of(context).colorScheme.outline)),
            child,
            Align(
              alignment: const Alignment(0.95, 0),
              child: Padding(padding: const EdgeInsets.all(16), child: footer),
            )
          ])),
    );
  }
}
