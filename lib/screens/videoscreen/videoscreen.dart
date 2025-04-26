import 'package:tgh_mobile/imports.dart';
import 'bilbiliplayer.dart';
import 'ytplayer.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key, required this.feedItem});
  final Feed feedItem;

  @override
  Widget build(BuildContext context) {
    if (feedItem.videoMetadata?.type == 'bili') {
      return BiliVideoScreen(metadata: feedItem.videoMetadata!);
    } else if (feedItem.videoMetadata?.type == 'youtube') {
      return YTPlayer(metadata: feedItem.videoMetadata!);
    } else {
      return ErrorScreen(error: ['No video found', (feedItem.videoMetadata?.toString() ?? 'No metadata found')]);
    }
  }
}
