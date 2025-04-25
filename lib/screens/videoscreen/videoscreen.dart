import 'package:tgh_mobile/imports.dart';
import 'bilbiliplayer.dart';
import 'ytplayer.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key, required this.id, required this.metadata, required this.videos});
  final String id;
  final VideoMetadata metadata;
  final List<VideoMetadata> videos;

  @override
  Widget build(BuildContext context) {
    if (metadata.type == 'bili') {
      return BiliVideoScreen(metadata: metadata);
    } else {
      return YTPlayer(metadata: metadata);
    }
  }
}
