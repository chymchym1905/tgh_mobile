import 'package:flutter/gestures.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tgh_mobile/widgets/providers/tags.dart';

import '../../imports.dart';

class HomeBody extends ConsumerStatefulWidget {
  const HomeBody({super.key});

  @override
  ConsumerState<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends ConsumerState<HomeBody> {
  bool _expanded = false;
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
    ref.watch(feedNotifierProvider);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: GestureDetector(
              onTap: () {
                _pagingController.refresh();
                ref.invalidate(feedNotifierProvider);
              },
              child: Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: RichText(
                      text: TextSpan(
                          text: 'The Golden House',
                          style: GoogleFonts.inter(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                            letterSpacing: -2,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {})))),
          pinned: true,
          floating: true,
          centerTitle: false,
          leading: MediaQuery.of(context).size.width > kMaxWidthTablet
              ? IconButton(
                  onPressed: () {
                    if (MediaQuery.of(context).size.width > kMaxWidthTabletLandscape) {
                      setState(() {
                        _expanded = !_expanded;
                      });
                    } else {
                      Scaffold.of(context).openDrawer();
                    }
                  },
                  icon: const Icon(Icons.dehaze, size: 30, weight: 700, grade: 200, opticalSize: 24))
              : null,
          elevation: 0,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          backgroundColor: Theme.of(context).colorScheme.surface,
          actions: [
            8.horizontalSpace,
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          ],
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - kToolbarHeight - 24,
            child: Row(children: [
              if (MediaQuery.of(context).size.width > kMaxWidthTabletLandscape) ...[
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: _expanded ? 200 : 56,
                  child: AnimatedSwitcher(
                    duration: _expanded ? const Duration(milliseconds: 200) : const Duration(milliseconds: 500),
                    child: DrawerWidget(
                      key: ValueKey<bool>(_expanded),
                      expanded: _expanded,
                    ),
                  ),
                ),
                SizedBox(width: 10.wr)
              ] else if (MediaQuery.of(context).size.width > kMaxWidthTablet &&
                  MediaQuery.of(context).size.width < kMaxWidthTabletLandscape) ...[
                const SizedBox(width: 56, child: DrawerWidget(expanded: false)),
                SizedBox(width: 10.wr)
              ],
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    _pagingController.refresh();
                    return ref.refresh(feedNotifierProvider.future);
                  },
                  child: CustomScrollView(
                    slivers: [
                      const PinnedHeaderSliver(child: Bottom()),
                      PagingListener(
                          controller: _pagingController,
                          builder: (context, state, fetchNextPage) => PagedSliverAlignedGrid<int, Feed>(
                              state: state,
                              fetchNextPage: fetchNextPage,
                              showNewPageProgressIndicatorAsGridChild: false,
                              gridDelegateBuilder: (_) {
                                final width = MediaQuery.of(context).size.width;
                                return SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: width > kMaxWidthTabletLandscape
                                        ? 1 + ((width - 200 - kMaxWidthMobile / 2).abs() / kMaxWidthMobile).round()
                                        : 1 + ((width - kMaxWidthMobile / 2).abs() / kMaxWidthMobile).round());
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
                                                    backgroundColor:
                                                        WidgetStatePropertyAll(Theme.of(context).colorScheme.primary),
                                                    foregroundColor: const WidgetStatePropertyAll(Colors.white),
                                                    textStyle:
                                                        WidgetStatePropertyAll(Theme.of(context).textTheme.titleMedium),
                                                    overlayColor: WidgetStateProperty.resolveWith<Color?>(
                                                        (Set<WidgetState> states) {
                                                      if (states.contains(WidgetState.pressed)) {
                                                        return Colors.white.withOpacity(0.3);
                                                      }
                                                      return null; // Defer to the widget's default.
                                                    })),
                                                child: const Text('Retry'))
                                          ])),
                                  firstPageProgressIndicatorBuilder: (context) =>
                                      Center(child: Sumerucart(width: 300.wr)),
                                  newPageProgressIndicatorBuilder: (context) => Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Center(child: NotesWriting(width: 200.wr))),
                                  itemBuilder: (context, item, index) {
                                    return GestureDetector(
                                        onTap: () {
                                          if (item.videoMetadata == null) {
                                            return;
                                          }
                                          context.push(Routes.video(item.id));
                                        },
                                        child: FeedEntryCard(feeditem: item));
                                  })))
                    ],
                  ),
                ),
              )
            ]),
          ),
        )
      ],
    );
  }
}
