import 'package:tgh_mobile/imports.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key, required this.error});
  final List<String> error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset('assets/icons/Qiqiqdead.jpg'),
          8.verticalSpace,
          Text(error.join('\n'), textAlign: TextAlign.start),
          8.verticalSpace,
          InkWellTextButton(onTap: () => context.pop(), text: 'Back'),
        ],
      ),
    );
  }
}
