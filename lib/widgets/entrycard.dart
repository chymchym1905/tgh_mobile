import 'dart:developer';

import 'package:tgh_mobile/imports.dart';
import 'package:tgh_mobile/widgets/imagecontainer.dart';

class FeedEntryCard extends StatelessWidget {
  const FeedEntryCard({super.key, required this.feeditem});
  final Feed feeditem;

  @override
  Widget build(BuildContext context) {
    final String pfp = pfpUrl(feeditem.competitor.id);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainer, borderRadius: BorderRadius.circular(15)),
                  child: Image.network(
                    feeditem.videoMetadata?.thumbnail ?? '',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                        color: Theme.of(context).colorScheme.surfaceContainer,
                        child: Center(
                            child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/icons/Qiqidead.jpg', width: 45, fit: BoxFit.contain),
                            const SizedBox(height: 8),
                            const Text('Video Unavailable', style: TextStyle(fontSize: 14))
                          ],
                        ))),
                  ),
                ),
              )),
          Padding(
            padding: EdgeInsets.all(8.sp),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: CircleAvatar(
                          radius: 26,
                          backgroundColor: Theme.of(context).colorScheme.surface,
                          child: SizedBox(
                              width: 52,
                              height: 52,
                              child: Image.network(pfp, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.person, size: 52);
                              })))),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        feeditem.videoMetadata?.title ?? 'Video title not found',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        feeditem.competitor.alias,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12, color: Theme.of(context).extension<TextColors>()!.textSecondary),
                      ),
                      const SizedBox(height: 2),
                      Text(
                          '${views(feeditem.videoMetadata?.views)} • ${formatDate(feeditem.createdAt)} • ${feedType(feeditem)}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style:
                              TextStyle(fontSize: 12, color: Theme.of(context).extension<TextColors>()!.textSecondary))
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.sp),
                    child: feeditem.approved
                        ? const Icon(Icons.verified, fill: 1, color: Colors.green)
                        : const Icon(Icons.cancel_rounded, fill: 1, color: Colors.red))
              ],
            ),
          )
        ],
      ),
    );
  }
}
