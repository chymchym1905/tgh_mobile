import '../../imports.dart';

class ThemeSettingOverlay extends ConsumerStatefulWidget {
  const ThemeSettingOverlay({super.key, required this.popOverlay});
  final void Function() popOverlay;

  @override
  ConsumerState<ThemeSettingOverlay> createState() => _ThemeSettingOverlayState();
}

class _ThemeSettingOverlayState extends ConsumerState<ThemeSettingOverlay> {
  late ThemeMode selectedTheme = ref.watch(themeNotifierProvider);
  @override
  Widget build(BuildContext context) {
    return OverlayBase(
        width: 300.w,
        title: 'Appearance',
        footer: InkWellTextButton(
            onTap: () {
              ref.read(themeNotifierProvider.notifier).toggleTheme(selectedTheme);
            },
            text: 'Apply'),
        child: Column(
          children: [
            ListTile(
              leading: Radio(
                value: ThemeMode.dark,
                groupValue: selectedTheme,
                onChanged: (value) {
                  setState(() {
                    selectedTheme = value!;
                  });
                },
              ),
              title: Text('Dark', style: Theme.of(context).textTheme.titleMedium),
              onTap: () {
                setState(() {
                  selectedTheme = ThemeMode.dark;
                });
              },
            ),
            ListTile(
              leading: Radio(
                value: ThemeMode.light,
                groupValue: selectedTheme,
                onChanged: (value) {
                  setState(() {
                    selectedTheme = value!;
                  });
                },
              ),
              title: Text('Light', style: Theme.of(context).textTheme.titleMedium),
              onTap: () {
                setState(() {
                  selectedTheme = ThemeMode.light;
                });
              },
            ),
            ListTile(
              leading: Radio(
                value: ThemeMode.system,
                groupValue: selectedTheme,
                onChanged: (value) {
                  setState(() {
                    selectedTheme = value!;
                  });
                },
              ),
              title: Text('Use system settings', style: Theme.of(context).textTheme.titleMedium),
              onTap: () {
                setState(() {
                  selectedTheme = ThemeMode.system;
                });
              },
            ),
          ],
        ));
  }
}
