import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../imports.dart';

class HomeBody extends ConsumerWidget {
  const HomeBody({super.key, required this.pagingController});
  final PagingController<int, Feed> pagingController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PagingListener(
      controller: pagingController,
      builder: (context, state, fetchNextPage) => PagedSliverList<int, Feed>(
        state: state,
        fetchNextPage: fetchNextPage,
        builderDelegate: PagedChildBuilderDelegate(
          firstPageErrorIndicatorBuilder: (context) => Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                const Text('Error loading data'),
                ElevatedButton(
                    onPressed: () {
                      pagingController.refresh();
                    },
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.primary),
                        foregroundColor: const WidgetStatePropertyAll(Colors.white),
                        textStyle: WidgetStatePropertyAll(Theme.of(context).textTheme.titleMedium),
                        overlayColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
                          if (states.contains(WidgetState.pressed)) {
                            return Colors.white.withOpacity(0.3);
                          }
                          return null; // Defer to the widget's default.
                        })),
                    child: const Text('Retry'))
              ])),
          itemBuilder: (context, item, index) {
            return Center(
              child: Text(
                switch (item) {
                  SpeedrunFeed() => 'Speedrun: ${item.videoMetadata?.title}, index: $index',
                  DPSFeed() => 'DPS: ${item.videoMetadata?.title}, index: $index',
                  _ => 'Unknown: ${item.videoMetadata?.title}, index: $index'
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
