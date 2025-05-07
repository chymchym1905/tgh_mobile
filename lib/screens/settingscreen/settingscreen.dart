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
            return authState.when(
              data: (data) {
                final loginTile = ListTile(
                    leading: const Icon(Icons.login),
                    title: Text('Login', style: Theme.of(context).textTheme.titleMedium),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.go(Routes.login));
                return data.when(
                    authenticated: (user, authToken) => ListTile(
                          leading: const Icon(Icons.logout),
                          title: Text('Logout', style: Theme.of(context).textTheme.titleMedium),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {
                            ref.read(authNotifierProvider.notifier).logout();
                            context.go(Routes.login);
                          },
                        ),
                    error: (error) => loginTile,
                    loggedOut: () => loginTile);
              },
              error: (error, stack) => const SizedBox.shrink(),
              loading: () => const SizedBox.shrink(),
            );
          }),
        ]));
  }
}
