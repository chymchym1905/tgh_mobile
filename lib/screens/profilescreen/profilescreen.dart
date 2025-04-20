import 'package:go_router/go_router.dart';
import 'package:tgh_mobile/imports.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverAppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
              onPressed: () {
                context.go(Routes.settings);
              },
              icon: const Icon(Icons.settings)),
        ],
      )
    ]);
  }
}
