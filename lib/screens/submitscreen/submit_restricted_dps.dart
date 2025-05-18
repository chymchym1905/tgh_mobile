import 'package:tgh_mobile/imports.dart';

class SubmitRestrictedDpsScreen extends ConsumerStatefulWidget {
  const SubmitRestrictedDpsScreen({super.key});

  @override
  ConsumerState<SubmitRestrictedDpsScreen> createState() => _SubmitSpeedrunScreenState();
}

class _SubmitSpeedrunScreenState extends ConsumerState<SubmitRestrictedDpsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Submit Speedrun')),
    );
  }
}
