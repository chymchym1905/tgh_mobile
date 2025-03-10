import '../../imports.dart';

class Sumerucart extends StatelessWidget {
  const Sumerucart({super.key});

  @override
  Widget build(BuildContext context) {
    const html = '''
<img src="asset:assets/gifs/spine_128.png">
''';
    const html_loop = '''
<img src="asset:assets/gifs/spine_128_loop.png">
''';
    return FutureBuilder(
        future: Future.delayed(const Duration(milliseconds: 6000)),
        builder: (context, snapshot) {
          return Stack(
            children: [
              Opacity(
                  opacity: snapshot.connectionState == ConnectionState.done ? 1 : 0,
                  child: const HtmlWidget(html_loop)),
              Opacity(opacity: snapshot.connectionState == ConnectionState.done ? 0 : 1, child: const HtmlWidget(html)),
            ],
          );
        });
  }
}
