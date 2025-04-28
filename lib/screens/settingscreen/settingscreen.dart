import 'package:go_router/go_router.dart';
import 'package:tgh_mobile/imports.dart';
import 'package:tgh_mobile/screens/settingscreen/themesetting.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          forceMaterialTransparency: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
        ),
        body: ListView(children: [
          const ThemeSettingsTile(),
          ListTile(
            leading: const Icon(Icons.cached),
            title: Text('Clear preferences', style: Theme.of(context).textTheme.titleMedium),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push(Routes.clearCache),
          ),
          Consumer(builder: (context, ref, child) {
            final authState = ref.watch(authNotifierProvider);
            return ListTile(
              leading: authState is AuthStateAuthenticated ? const Icon(Icons.logout) : const Icon(Icons.login),
              title: Text(authState is AuthStateAuthenticated ? 'Logout' : 'Login',
                  style: Theme.of(context).textTheme.titleMedium),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => authState is AuthStateAuthenticated
                  ? ref.read(authNotifierProvider.notifier).logout()
                  : context.go(Routes.login),
            );
          }),
        ]));
  }
}
