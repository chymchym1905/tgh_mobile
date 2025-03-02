import 'imports.dart';

void main() {
  runApp(const Root());
}

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreen());
  }
}
