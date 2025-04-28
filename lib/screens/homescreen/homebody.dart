import 'dart:developer';

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
    // Important line to make sure the feed is not broken
    log('''
CardWidth: ${calculateCardWidth(MediaQuery.of(context).size.width, 1 + ((MediaQuery.of(context).size.width - kMaxWidthMobile / 2).abs() / kMaxWidthMobile).round(), 8)}
''', name: 'ViewPortWidth NewsFeed');
    ref.watch(feedNotifierProvider);
    return RefreshIndicator(
      onRefresh: () async {
        _pagingController.refresh();
        return ref.refresh(feedNotifierProvider.future);
      },
      child: CustomScrollView(
        slivers: [
          MyAppBar(
            profile: false,
            onTap: () {
              _pagingController.refresh();
              ref.invalidate(feedNotifierProvider);
            },
          ),
          const PinnedHeaderSliver(child: Bottom()),
          PagingListener(
            controller: _pagingController,
            builder: (context, state, fetchNextPage) => PagedSliverAlignedGrid<int, Feed>(
              state: state,
              fetchNextPage: fetchNextPage,
              showNewPageProgressIndicatorAsGridChild: false,
              gridDelegateBuilder: (_) {
                return SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1 +
                        ((MediaQuery.of(context).size.width - kMaxWidthMobile / 2).abs() / kMaxWidthMobile).round());
              },
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
                firstPageProgressIndicatorBuilder: (context) => const Center(child: Sumerucart(width: 300)),
                newPageProgressIndicatorBuilder: (context) =>
                    const Padding(padding: EdgeInsets.all(16), child: Center(child: Sumerucart(width: 200))),
                itemBuilder: (context, item, index) {
                  return GestureDetector(
                    onTap: () {
                      if (item.videoMetadata == null) {
                        return;
                      }
                      // context.pushNamed('video', queryParameters: {'id': item.id});
                      context.push(Routes.video(item.id));
                    },
                    child: FeedEntryCard(feeditem: item),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
