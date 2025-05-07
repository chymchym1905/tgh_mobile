// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tgh_mobile/imports.dart';

class OverlayBase extends StatelessWidget {
  const OverlayBase({
    super.key,
    required this.submit,
    required this.child,
    required this.title,
    this.width,
    this.height,
  });
  final double? width;
  final double? height;
  final Widget child;
  final String title;
  final void Function() submit;
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.cover,
      child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceBright,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(children: [
            Align(
                alignment: const Alignment(-0.95, 0),
                child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    child: Text(title, style: Theme.of(context).textTheme.titleLarge))),
            child,
            Align(
              alignment: const Alignment(0.95, 0),
              child: Padding(padding: const EdgeInsets.all(16), child: InkWellTextButton(onTap: submit, text: 'Close')),
            )
          ])),
    );
  }
}
