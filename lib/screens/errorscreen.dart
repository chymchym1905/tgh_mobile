import 'package:tgh_mobile/imports.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key, required this.error});
  final List<String> error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Image.asset('assets/icons/Qiqidead.jpg'),
          8.verticalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(error.join('\n'), textAlign: TextAlign.start),
          ),
          8.verticalSpace,
          Center(child: InkWellTextButton(onTap: () => context.pop(), text: 'Back')),
        ],
      ),
    );
  }
}
