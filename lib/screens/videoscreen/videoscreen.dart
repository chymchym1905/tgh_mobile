import 'package:tgh_mobile/imports.dart';
import 'bilbiliplayer.dart';
import 'ytplayer.dart';

class VideoScreen extends ConsumerWidget {
  const VideoScreen({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedItem = ref.watch(fetchFeedByIdProvider(id));
    return feedItem.when(
      data: (data) {
        if (data.videoMetadata == null) {
          return ErrorScreen(error: ['No video found', (data.toString())]);
        } else if (data.videoMetadata?.type == 'bili') {
          return BiliVideoScreen(metadata: data.videoMetadata!);
        } else if (data.videoMetadata?.type == 'youtube') {
          return YTPlayer(metadata: data.videoMetadata!);
        }
        return const ErrorScreen(error: ['No video found', 'No metadata found']);
      },
      error: (error, stack) => ErrorScreen(error: ['Error: $error', 'Stack: $stack']),
      loading: () => const Scaffold(body: Center(child: Sumerucart(width: 300))),
    );
  }
}
