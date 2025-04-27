import 'package:tgh_mobile/imports.dart';
import 'package:tgh_mobile/widgets/shimmer.dart';

class FeedEntryCard extends StatelessWidget {
  const FeedEntryCard({super.key, required this.feeditem});
  final Feed feeditem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(feeditem.videoMetadata?.thumbnail ?? '',
            loadingBuilder: (context, child, loadingProgress) => ShimmerComponent.regtangular(radius: 10),
            errorBuilder: (context, error, stackTrace) => Center(child: Text(error.toString()))),
        Row(
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
                          child: Image.network(pfpUrl(feeditem.competitor.id), fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                            return const Padding(padding: EdgeInsets.all(4), child: Icon(Icons.person_2_rounded));
                          })))),
            ),
            Column(children: [
              Text(feeditem.videoMetadata?.title ?? 'Video title not found',
                  maxLines: 2, overflow: TextOverflow.ellipsis),
              Text(feeditem.competitor.alias, maxLines: 1, overflow: TextOverflow.ellipsis)
            ]),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: feeditem.approved
                    ? const Icon(Icons.verified, fill: 1, color: Colors.green)
                    : const Icon(Icons.cancel_rounded, fill: 1, color: Colors.red))
          ],
        )
      ],
    );
  }
}
