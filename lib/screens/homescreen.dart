import '../imports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('test')),
        body: Center(
            child: Container(
          width: 200,
          height: 200,
          color: Colors.red,
          child: Center(
            child: InAppWebView(
              initialFile: "assets/spines/sumeru_cart_loading.html",
              initialSettings: InAppWebViewSettings(
                allowsInlineMediaPlayback: true, // Enables animations
                javaScriptEnabled: true, // Required for PixiJS to run
              ),
            ),
          ),
        )));
  }
}
