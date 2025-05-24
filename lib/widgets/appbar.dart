import '../../imports.dart';

class MyAppBar extends StatefulWidget {
  const MyAppBar({super.key, required this.title, required this.leading});
  final Widget title;
  final Widget leading;

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  final customPopupMenuController = CustomPopupMenuController();
  final pfpPopupMenuController = CustomPopupMenuController();
  bool _appBarExpanded = false;

  @override
  Widget build(BuildContext context) {
    return PinnedHeaderSliver(
      child: Container(
          color: Theme.of(context).colorScheme.surface,
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
                              child: const Padding(padding: EdgeInsets.symmetric(horizontal: 20), child: SearchBox())),
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
                                          icon: const Icon(Icons.search, size: 24)))),
                              SizedBox(width: 10.wr),
                            ] else if (MediaQuery.of(context).size.width > kMaxWidthTablet) ...[
                              CustomPopupMenu(
                                  controller: customPopupMenuController,
                                  hoverColor: Theme.of(context).colorScheme.surfaceContainer,
                                  showArrow: false,
                                  radius: 25,
                                  menuBuilder: () => SubmitMenu(customPopupMenuController: customPopupMenuController),
                                  pressType: PressType.singleClick,
                                  child: Container(
                                      width: 100,
                                      height: 40,
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).colorScheme.surfaceContainerHigh,
                                          borderRadius: BorderRadius.circular(25)),
                                      child: const Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [Icon(Icons.add, size: 24), Text('Submit')]))),
                              const SizedBox(width: 20)
                            ],
                            Consumer(builder: (context, ref, child) {
                              final auth = ref.watch(authNotifierProvider);
                              return CustomPopupMenu(
                                pressType: PressType.singleClick,
                                controller: pfpPopupMenuController,
                                arrowColor: Theme.of(context).colorScheme.surfaceContainerHigh,
                                menuBuilder: () => Container(
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.surfaceContainerHigh,
                                        borderRadius: BorderRadius.circular(5.wr)),
                                    child: Consumer(
                                      builder: (context, ref, child) {
                                        return Material(
                                            color: Colors.transparent,
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.wr)),
                                            child: IntrinsicWidth(
                                                child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                                    children: [
                                                  InkWell(
                                                      onTap: () {
                                                        pfpPopupMenuController.hideMenu();
                                                        context.go(Routes.settings);
                                                      },
                                                      child: Padding(
                                                          padding: const EdgeInsets.only(
                                                              left: 10, right: 10, top: 8, bottom: 4),
                                                          child: Row(children: [
                                                            Icon(Icons.settings,
                                                                size: 24,
                                                                color: Theme.of(context).colorScheme.onSurface),
                                                            const SizedBox(width: 8),
                                                            Text('Settings',
                                                                style: TextStyle(
                                                                    fontSize: 12.wr,
                                                                    color: Theme.of(context).colorScheme.onSurface))
                                                          ]))),
                                                  InkWell(
                                                      onTap: () {
                                                        auth.maybeWhen(orElse: () {
                                                          pfpPopupMenuController.hideMenu();
                                                          context.go(Routes.login);
                                                        }, data: (data) {
                                                          switch (data) {
                                                            case AuthStateAuthenticated():
                                                              pfpPopupMenuController.hideMenu();
                                                              ref.watch(authNotifierProvider.notifier).logout();
                                                              context.go(Routes.login);
                                                            default:
                                                              pfpPopupMenuController.hideMenu();
                                                              context.go(Routes.login);
                                                          }
                                                        });
                                                      },
                                                      child: Padding(
                                                          padding: const EdgeInsets.only(
                                                              left: 10, right: 10, top: 4, bottom: 8),
                                                          child: Row(children: [
                                                            Icon(
                                                                auth.maybeWhen(
                                                                    orElse: () => Icons.login,
                                                                    data: (data) {
                                                                      switch (data) {
                                                                        case AuthStateAuthenticated():
                                                                          return Icons.logout;
                                                                        default:
                                                                          return Icons.login;
                                                                      }
                                                                    }),
                                                                size: 24,
                                                                color: Theme.of(context).colorScheme.onSurface),
                                                            const SizedBox(width: 8),
                                                            Text(
                                                                auth.maybeWhen(
                                                                    orElse: () => 'Login',
                                                                    data: (data) {
                                                                      switch (data) {
                                                                        case AuthStateAuthenticated():
                                                                          return 'Logout';
                                                                        default:
                                                                          return 'Login';
                                                                      }
                                                                    }),
                                                                style: TextStyle(
                                                                    fontSize: 12.wr,
                                                                    color: Theme.of(context).colorScheme.onSurface))
                                                          ]))),
                                                ])));
                                      },
                                    )),
                                child: auth.maybeWhen(
                                    orElse: () => const UniformCircleAvatar(url: '', radius: 20),
                                    data: (data) {
                                      switch (data) {
                                        case AuthStateAuthenticated(:final user):
                                          return UniformCircleAvatar(
                                              url: pfpUrl(user.competitor?.id ?? ''), radius: 20);
                                        default:
                                          return const UniformCircleAvatar(url: '', radius: 20);
                                      }
                                    }),
                              );
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
