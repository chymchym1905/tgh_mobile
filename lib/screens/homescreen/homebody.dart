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
  TextEditingController searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
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
    final auth = ref.watch(authNotifierProvider);

    return CustomScrollView(
      slivers: [
        PinnedHeaderSliver(
            child: SizedBox(
                height: kToolbarHeight,
                child: Row(children: [
                  Expanded(
                      flex: MediaQuery.of(context).size.width > kMaxWidthTablet ? 1 : 4,
                      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                        if (MediaQuery.of(context).size.width > kMaxWidthTablet)
                          SizedBox(
                              width: 70,
                              child: Center(
                                  child: SizedBox(
                                      width: 56,
                                      height: 56,
                                      child: IconButton(
                                          onPressed: () {
                                            if (MediaQuery.of(context).size.width > kMaxWidthTabletLandscape) {
                                              setState(() {
                                                _expanded = !_expanded;
                                              });
                                            } else {
                                              Scaffold.of(context).openDrawer();
                                            }
                                          },
                                          icon: const Icon(Icons.dehaze,
                                              size: 30, weight: 700, grade: 200, opticalSize: 24))))),
                        const SizedBox(width: 8),
                        Padding(
                            padding: EdgeInsets.only(
                                top: 0, left: MediaQuery.of(context).size.width > kMaxWidthTablet ? 0 : 8),
                            child: RichText(
                                text: TextSpan(
                                    text: 'The Golden House',
                                    style: GoogleFonts.inter(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).colorScheme.primary,
                                      letterSpacing: -2,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        _pagingController.refresh();
                                        ref.invalidate(feedNotifierProvider);
                                      })))
                      ])),
                  Expanded(
                      flex: MediaQuery.of(context).size.width > kMaxWidthTablet ? 2 : 6,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (MediaQuery.of(context).size.width <= 200) ...[
                              SizedBox(
                                  width: 32,
                                  height: 32,
                                  child: Center(
                                      child: IconButton(onPressed: () {}, icon: const Icon(Icons.search, size: 16)))),
                              SizedBox(width: 10.wr)
                            ] else ...[
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(maxWidth: 460),
                                    child: AsyncTextFormField(
                                      validator: (value) async {
                                        try {
                                          await ref.read(searchUsersProvider(value).future);
                                          return true;
                                        } catch (e) {
                                          debugPrint("Search error: ${e.toString()}");
                                          return true;
                                        }
                                      },
                                      height: 40,
                                      focusNode: _focusNode,
                                      validationDebounce: const Duration(milliseconds: 500),
                                      controller: searchController,
                                      hintText: 'Find a user',
                                      keyboardType: TextInputType.text,
                                      padding: EdgeInsets.zero,
                                      canEmpty: true,
                                      // suffixIcon: Icon(Icons.search, size: 20),
                                      decoration: InputDecoration(
                                          prefixIcon: const Padding(
                                              padding: EdgeInsetsDirectional.only(start: 10, end: 10),
                                              child: Icon(Icons.search, size: 30)),
                                          filled: true,
                                          fillColor: Theme.of(context).colorScheme.surfaceContainerLow,
                                          floatingLabelBehavior: FloatingLabelBehavior.never,
                                          errorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(25),
                                              borderSide: const BorderSide(color: Colors.red, width: 2)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(25),
                                              borderSide:
                                                  BorderSide(color: Theme.of(context).colorScheme.outline, width: 2)),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(25),
                                              borderSide: BorderSide(color: Theme.of(context).colorScheme.outline)),
                                          labelStyle: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(color: const Color.fromARGB(255, 117, 117, 117)),
                                          contentPadding: const EdgeInsets.only(left: 16, right: 8)),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.wr)
                            ],
                            auth.maybeWhen(
                                orElse: () => const UniformCircleAvatar(url: '', radius: 20),
                                data: (data) {
                                  switch (data) {
                                    case AuthStateAuthenticated(:final user):
                                      return UniformCircleAvatar(url: pfpUrl(user.competitor?.id ?? ''), radius: 20);
                                    default:
                                      return const UniformCircleAvatar(url: '', radius: 20);
                                  }
                                }),
                            SizedBox(width: 10.wr)
                          ]))
                ]))),
        // SliverAppBar(
        //   title: Padding(
        //       padding: const EdgeInsets.only(top: 0),
        //       child: RichText(
        //           text: TextSpan(
        //               text: 'The Golden House',
        //               style: GoogleFonts.inter(
        //                 fontSize: 24,
        //                 fontWeight: FontWeight.bold,
        //                 color: Theme.of(context).colorScheme.primary,
        //                 letterSpacing: -2,
        //               ),
        //               recognizer: TapGestureRecognizer()
        //                 ..onTap = () {
        //                   _pagingController.refresh();
        //                   ref.invalidate(feedNotifierProvider);
        //                 }))),
        //   pinned: true,
        //   floating: true,
        //   centerTitle: false,
        //   leading: MediaQuery.of(context).size.width > kMaxWidthTablet
        //       ? IconButton(
        //           onPressed: () {
        //             if (MediaQuery.of(context).size.width > kMaxWidthTabletLandscape) {
        //               setState(() {
        //                 _expanded = !_expanded;
        //               });
        //             } else {
        //               Scaffold.of(context).openDrawer();
        //             }
        //           },
        //           icon: const Icon(Icons.dehaze, size: 30, weight: 700, grade: 200, opticalSize: 24))
        //       : null,
        //   elevation: 0,
        //   shadowColor: Colors.transparent,
        //   surfaceTintColor: Colors.transparent,
        //   backgroundColor: Theme.of(context).colorScheme.surface,
        //   actions: [
        //     8.horizontalSpace,
        //     IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        //   ],
        // ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - kToolbarHeight,
            child: Row(children: [
              if (MediaQuery.of(context).size.width > kMaxWidthTabletLandscape) ...[
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: _expanded ? 200 : 70,
                  child: AnimatedSwitcher(
                    duration: _expanded ? const Duration(milliseconds: 200) : const Duration(milliseconds: 500),
                    child: DrawerWidget(
                      key: ValueKey<bool>(_expanded),
                      expanded: _expanded,
                    ),
                  ),
                ),
                const SizedBox(width: 8)
              ] else if (MediaQuery.of(context).size.width > kMaxWidthTablet &&
                  MediaQuery.of(context).size.width < kMaxWidthTabletLandscape) ...[
                const SizedBox(width: 70, child: DrawerWidget(expanded: false)),
                const SizedBox(width: 8)
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
