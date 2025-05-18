import 'package:tgh_mobile/imports.dart';

class SubmitDpsScreen extends ConsumerStatefulWidget {
  const SubmitDpsScreen({super.key});

  @override
  ConsumerState<SubmitDpsScreen> createState() => _SubmitSpeedrunScreenState();
}

class _SubmitSpeedrunScreenState extends ConsumerState<SubmitDpsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Submit Speedrun')),
    );
  }
}
