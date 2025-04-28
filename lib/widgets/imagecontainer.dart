// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:ui' as ui;
import '../imports.dart';

class ImageContainer extends StatefulWidget {
  final String url;
  const ImageContainer({
    super.key,
    required this.url,
  });

  @override
  State<ImageContainer> createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Image image = Image.network(widget.url, fit: BoxFit.cover);
    Completer<ui.Image> completer = Completer<ui.Image>();
    image.image.resolve(const ImageConfiguration()).addListener(ImageStreamListener((info, synchronousCall) {
      completer.complete(info.image);
    }));
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: FutureBuilder(
          future: completer.future,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const AppErrorWidget(message: 'Video Unavailable');
            } else if (snapshot.hasData) {
              return image;
            } else {
              return const AppErrorWidget(message: 'Video Unavailable');
            }
          }),
    );
  }
}
