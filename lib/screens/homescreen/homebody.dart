import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tgh_mobile/widgets/providers/tags.dart';

import '../../imports.dart';

class HomeBody extends ConsumerStatefulWidget {
  const HomeBody({super.key});

  @override
  ConsumerState<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends ConsumerState<HomeBody> {
  late final PagingController<int, Feed> _pagingController = PagingController<int, Feed>(
    value: ref.watch(feedNotifierProvider).map(
        loading: (s) => null,
        loaded: (state) {
          if (state.feedLists.isEmpty) {
            return PagingState<int, Feed>();
          }
          return PagingState<int, Feed>(keys: state.pages, pages: state.feedLists);
        },
        error: (s) => PagingState<int, Feed>(error: s.exception)),
    getNextPageKey: (state) {
      return (state.keys?.last ?? 0) + 1;
    },
    fetchPage: (pageKey) async {
      final filter = ref.watch(appliedFilterProvider);
      final response = await ref.watch(feedNotifierProvider.notifier).fetchFeed(filter);
      return response;
    },
  );
  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(feedNotifierProvider);
    return CustomScrollView(
      slivers: [
        const MyAppBar(profile: false),
        const PinnedHeaderSliver(child: Bottom()),
        PagingListener(
          controller: _pagingController,
          builder: (context, state, fetchNextPage) => PagedSliverGrid<int, Feed>(
            state: state,
            fetchNextPage: fetchNextPage,
            showNewPageProgressIndicatorAsGridChild: false,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  1 + ((MediaQuery.of(context).size.width - kMaxWidthMobile / 2).abs() / kMaxWidthMobile).round(),
              childAspectRatio: 1920 / 1080,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            builderDelegate: PagedChildBuilderDelegate(
              firstPageErrorIndicatorBuilder: (context) => Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                    const Text('Error loading data'),
                    ElevatedButton(
                        onPressed: () {
                          _pagingController.refresh();
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
                return Container(
                  color: Colors.red,
                  child: Center(
                    child: Text(
                      switch (item) {
                        SpeedrunFeed() => 'Speedrun: ${item.videoMetadata?.title}, index: $index',
                        DPSFeed() => 'DPS: ${item.videoMetadata?.title}, index: $index',
                        _ => 'Unknown: ${item.videoMetadata?.title}, index: $index'
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
