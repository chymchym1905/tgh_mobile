import '../../imports.dart';

class ThemeSettingOverlay extends ConsumerWidget {
  const ThemeSettingOverlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeNotifierProvider);
    return OverlayBase(
        width: 300.w,
        title: 'Appearance',
        footer: InkWellTextButton(
            onTap: () {
              Navigator.pop(context);
            },
            text: 'Close'),
        child: Column(
          children: [
            ListTile(
              leading: Radio(
                value: ThemeMode.dark,
                groupValue: theme,
                onChanged: (value) {
                  ref.read(themeNotifierProvider.notifier).toggleTheme(ThemeMode.dark);
                },
              ),
              title: Text('Dark', style: Theme.of(context).textTheme.titleMedium),
              onTap: () {
                ref.read(themeNotifierProvider.notifier).toggleTheme(ThemeMode.dark);
              },
            ),
            ListTile(
              leading: Radio(
                value: ThemeMode.light,
                groupValue: theme,
                onChanged: (value) {
                  ref.read(themeNotifierProvider.notifier).toggleTheme(ThemeMode.light);
                },
              ),
              title: Text('Light', style: Theme.of(context).textTheme.titleMedium),
              onTap: () {
                ref.read(themeNotifierProvider.notifier).toggleTheme(ThemeMode.light);
              },
            ),
            ListTile(
              leading: Radio(
                value: ThemeMode.system,
                groupValue: theme,
                onChanged: (value) {
                  ref.read(themeNotifierProvider.notifier).toggleTheme(ThemeMode.system);
                },
              ),
              title: Text('Use system settings', style: Theme.of(context).textTheme.titleMedium),
              onTap: () {
                ref.read(themeNotifierProvider.notifier).toggleTheme(ThemeMode.system);
              },
            ),
          ],
        ));
  }
}
