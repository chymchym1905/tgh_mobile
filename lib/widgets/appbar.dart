import 'package:tgh_mobile/widgets/overlays/filteroverlay.dart';

import '../../imports.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key, required this.profile, this.onTap});
  final bool profile;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: Text('The Golden House',
                style: GoogleFonts.inter(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                  letterSpacing: -2,
                )),
          )),
      pinned: true,
      floating: true,
      centerTitle: false,
      elevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      backgroundColor: Theme.of(context).colorScheme.surface,
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        if (profile) IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
      ],
    );
  }

  @override
  Size get preferredSize {
    final height = AppBar().preferredSize.height;
    return Size.fromHeight(height);
  }
}

class Bottom extends StatefulWidget implements PreferredSizeWidget {
  const Bottom({super.key});

  @override
  State<Bottom> createState() => _BottomState();

  @override
  Size get preferredSize => Size.fromHeight(24);
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
              Positioned(
                top: 100.h,
                left: 30.w,
                right: 30.w,
                bottom: 100.h,
                child: Container(
                    color: Theme.of(context).colorScheme.surfaceContainerLowest,
                    child: FilterOverlay(onFilterChanged: _filterChanged)),
              )
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
                (index) => TagsChip(
                    selected: index == _activeIndex,
                    text: _tags[index],
                    onTap: () => setState(() {
                          _activeIndex = index;
                        })))
          ]),
        ),
      ),
    );
  }
}
