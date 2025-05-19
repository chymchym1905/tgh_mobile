import '../../imports.dart';

class MyAppBar extends StatefulWidget {
  const MyAppBar({super.key, required this.title, required this.leading});
  final Widget title;
  final Widget leading;

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  bool _appBarExpanded = false;

  @override
  Widget build(BuildContext context) {
    return PinnedHeaderSliver(
      child: SizedBox(
          height: kToolbarHeight,
          child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _appBarExpanded == false
                  ? Row(children: [
                      Row(mainAxisAlignment: MainAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                        if (MediaQuery.of(context).size.width > kMaxWidthTablet) widget.leading,
                        const SizedBox(width: 8),
                        Padding(
                            padding: EdgeInsets.only(
                                top: 0, left: MediaQuery.of(context).size.width > kMaxWidthTablet ? 0 : 8, right: 10),
                            child: widget.title)
                      ]),
                      if (MediaQuery.of(context).size.width > 460)
                        Expanded(
                            child: Align(
                          alignment: Alignment.centerLeft,
                          child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 460),
                              child: const Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: SearchBox())),
                        ))
                      else
                        const Spacer(),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (MediaQuery.of(context).size.width <= 460) ...[
                              SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: Center(
                                      child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _appBarExpanded = true;
                                            });
                                          },
                                          icon: const Icon(Icons.search, size: 30)))),
                              SizedBox(width: 10.wr)
                            ] else ...[
                              const SizedBox(width: 10)
                            ],
                            Consumer(builder: (context, ref, child) {
                              final auth = ref.watch(authNotifierProvider);
                              return auth.maybeWhen(
                                  orElse: () => const UniformCircleAvatar(url: '', radius: 20),
                                  data: (data) {
                                    switch (data) {
                                      case AuthStateAuthenticated(:final user):
                                        return UniformCircleAvatar(url: pfpUrl(user.competitor?.id ?? ''), radius: 20);
                                      default:
                                        return const UniformCircleAvatar(url: '', radius: 20);
                                    }
                                  });
                            }),
                            const SizedBox(width: 10)
                          ])
                    ])
                  : ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
                      child: Row(children: [
                        SizedBox(width: 5.wr),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                _appBarExpanded = false;
                              });
                            },
                            icon: const Icon(Icons.arrow_back, size: 24)),
                        SizedBox(width: 5.wr),
                        SizedBox(
                            width: MediaQuery.of(context).size.width - 40 - 10.wr - 16.wr, child: const SearchBox())
                      ]),
                    ))),
    );
  }
}

class Bottom extends StatefulWidget implements PreferredSizeWidget {
  const Bottom({super.key});

  @override
  State<Bottom> createState() => _BottomState();

  @override
  Size get preferredSize => const Size.fromHeight(24);
}

class _BottomState extends State<Bottom> {
  final List<String> _tags = ['All', 'Verified', 'Outside', 'Unverified'];
  int _activeIndex = 0;
  OverlayEntry? _filterOverlay;
  bool _filterApplied = false;
  void _filterChanged(bool applied) {
    _filterApplied = applied;
  }

  void _showFilterOverlay() {
    if (_filterOverlay?.mounted ?? false) {
      _filterOverlay?.remove();
      return;
    }
    _filterOverlay = OverlayEntry(
        builder: (context) => Stack(children: [
              GestureDetector(
                  onTap: () {
                    _showFilterOverlay();
                  },
                  child: Opacity(
                      opacity: 0.5, child: Container(color: Theme.of(context).colorScheme.surfaceContainerLowest))),
              Center(
                  child: Container(
                color: Theme.of(context).colorScheme.surfaceContainerLowest,
              ))
            ]));
    Overlay.of(context).insert(_filterOverlay!);
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: widget.preferredSize,
      child: Container(
        color: Theme.of(context).colorScheme.surface,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.start, children: [
            IconButton(
                onPressed: _showFilterOverlay,
                icon: _filterApplied ? const Icon(Icons.filter_alt) : const Icon(Icons.filter_alt_off)),
            ...List<Widget>.generate(
              _tags.length,
              (index) => Padding(
                padding: const EdgeInsets.only(left: 8),
                child: TagsChip(
                  selected: index == _activeIndex,
                  text: _tags[index],
                  onTap: () => setState(() {
                    _activeIndex = index;
                  }),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
