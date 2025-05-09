import 'package:tgh_mobile/imports.dart';

class InkWellTextButton extends StatelessWidget {
  const InkWellTextButton({super.key, required this.onTap, required this.text, this.fontSize = 16});
  final void Function() onTap;
  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          splashColor: colorScheme.onPrimary.withOpacity(0.5),
          child: Ink(
              decoration: BoxDecoration(color: colorScheme.primaryContainer, borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  text,
                  style: TextStyle(fontSize: fontSize, color: colorScheme.onPrimaryContainer),
                ),
              ))),
    );
  }
}

class InkWellTextButtonSecondary extends StatelessWidget {
  const InkWellTextButtonSecondary({super.key, required this.onTap, required this.text, this.fontSize = 16});
  final void Function() onTap;
  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          splashColor: colorScheme.onPrimary.withOpacity(0.5),
          child: Ink(
              decoration: BoxDecoration(
                  color: colorScheme.surfaceDim.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: colorScheme.outline.withOpacity(0.5))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  text,
                  style: TextStyle(fontSize: fontSize, color: Theme.of(context).extension<TextColors>()!.textSecondary),
                ),
              ))),
    );
  }
}
