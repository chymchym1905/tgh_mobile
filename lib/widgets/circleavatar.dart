import 'package:tgh_mobile/imports.dart';

class UniformCircleAvatar extends StatelessWidget {
  const UniformCircleAvatar({super.key, required this.url, required this.radius});
  final String url;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: CircleAvatar(
            radius: radius,
            backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
            child: SizedBox(
                width: radius * 2,
                height: radius * 2,
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.person, size: radius * 2 - 2.wr * 2);
                  },
                ))));
  }
}
