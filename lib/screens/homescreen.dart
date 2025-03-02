import '../imports.dart';
import 'package:spine_flutter/spine_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = SpineWidgetController(onInitialized: (controller) {
      // Set the animation to play and loop
      controller.animationState.setAnimationByName(0, "rotate", true);
    });

    return Scaffold(
      body: Center(
        // Center widget added for better positioning
        child: SpineWidget.fromAsset(
          'assets/spine/Eff_UI_LanV5PuzzleLoadingPage_Spine1.atlas', // Make sure path is correct
          'assets/spine/Eff_UI_LanV5PuzzleLoadingPage_Spine1.skel', // Make sure path is correct
          controller,
        ),
      ),
    );
  }
}

// [{"skel":"Eff_UI_LanV5PuzzleLoadingPage_Spine1","atlas":"","animation_index":0,"scale":0.3,"coordinate":[0,0],"color":"00000000","ui":true,"hide":null,"bg":null,"dark":null,"inject_js":null}]