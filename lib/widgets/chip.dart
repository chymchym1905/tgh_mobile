import '../../imports.dart';

class TagsChip extends StatelessWidget {
  const TagsChip(
      {super.key,
      required this.selected,
      required this.text,
      required this.onTap,
      this.fontSize = 12,
      this.selectedColor,
      this.unselectedColor,
      this.borderRadius = 10});
  final bool selected;
  final String text;
  final double? fontSize;
  final Color? selectedColor;
  final Color? unselectedColor;
  final double? borderRadius;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    final color = selected
        ? selectedColor ?? Theme.of(context).colorScheme.primary
        : unselectedColor ?? Theme.of(context).colorScheme.surfaceContainerHigh;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius!),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Text(
          text,
          style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: selected ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSurface),
        ),
      ),
    );
  }
}

class RoleChip extends StatelessWidget {
  final Color color;
  final String label;
  const RoleChip(this.label, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.wr),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.wr, vertical: 4.wr),
      child: Text(label, style: TextStyle(fontSize: 12.wr, fontWeight: FontWeight.bold, color: Colors.black)),
    );
  }
}
