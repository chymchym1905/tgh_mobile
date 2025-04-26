import 'package:tgh_mobile/imports.dart';
import 'package:tgh_mobile/widgets/shimmer.dart';

class FeedEntryCard extends StatelessWidget {
  const FeedEntryCard({super.key, required this.feeditem});
  final Feed feeditem;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(Routes.video(feeditem.videoMetadata?.id ?? ''));
      },
      child: Column(
        children: [
          Image.network(feeditem.videoMetadata?.thumbnail ?? '',
              loadingBuilder: (context, child, loadingProgress) => ShimmerComponent.regtangular(radius: 10),
              errorBuilder: (context, error, stackTrace) => Center(child: Text(error.toString()))),
          Row(
            children: [
              GestureDetector(
                onTap: () {},
                child: Text(feeditem.videoMetadata?.title ?? ''),
              )
            ],
          )
        ],
      ),
    );
  }
}
