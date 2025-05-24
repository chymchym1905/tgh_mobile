import 'package:tgh_mobile/imports.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key, required this.error});
  final List<String> error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Center(
                child: SizedBox(
                    width: MediaQuery.of(context).size.height * 0.5,
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Image.asset('assets/icons/Qiqidead.jpg'))),
            8.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: SelectableText(error.join('\n'), textAlign: TextAlign.start))),
            ),
            8.verticalSpace,
            Center(child: InkWellTextButton(onTap: () => context.pop(), text: 'Back')),
          ],
        ),
      ),
    );
  }
}
