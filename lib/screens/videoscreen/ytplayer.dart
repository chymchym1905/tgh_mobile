import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:tgh_mobile/imports.dart';

class YTPlayer extends ConsumerStatefulWidget {
  const YTPlayer({super.key, required this.metadata});
  final VideoMetadata metadata;

  @override
  ConsumerState<YTPlayer> createState() => _YTPlayerState();
}

class _YTPlayerState extends ConsumerState<YTPlayer> {
  late final YoutubePlayerController _controller = YoutubePlayerController(
      params: const YoutubePlayerParams(showControls: true, mute: false, showFullscreenButton: true, loop: false));
  @override
  void initState() {
    super.initState();
    log(widget.metadata.id, name: 'YTPlayer video id');
    _controller.setFullScreenListener((isFullScreen) {
      log('${isFullScreen ? 'Entered' : 'Exited'} Fullscreen.');
      if (isFullScreen) {
        SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.transparent,
          ),
        );
      } else {
        final theme = ref.read(themeNotifierProvider);
        ref.read(themeNotifierProvider.notifier).updateSystemUIOverlay(theme);
      }
    });
    _controller.loadVideoById(videoId: widget.metadata.id);
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerScaffold(
        controller: _controller,
        aspectRatio: widget.metadata.aspectRatio,
        goRouter: true,
        builder: (context, player) {
          return Scaffold(body: LayoutBuilder(builder: (context, constraints) {
            if (constraints.maxWidth > kMaxWidthTablet) {
              return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(flex: 3, child: Column(children: [player])),
                Expanded(flex: 2, child: Column(children: [Container()]))
              ]);
            } else {
              return ListView(children: [
                player,
                16.verticalSpace,
                Center(child: InkWellTextButton(onTap: () => context.pop(), text: 'Back'))
              ]);
            }
          }));
        });
  }
}
