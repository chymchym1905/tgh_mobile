import 'package:tgh_mobile/widgets/filteroverlay.dart';

import '../../imports.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key, required this.home, required this.profile});
  final bool home;
  final bool profile;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text('The Golden House',
          style: GoogleFonts.inter(
            fontSize: 24.w,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
            letterSpacing: -2,
          )),
      centerTitle: false,
      pinned: false,
      floating: true,
      snap: true,
      bottom: home ? Bottom() : null,
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        if (profile) IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
      ],
    );
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
  final List<String> _tags = [
    'All',
    'Verified',
    'Outside',
    'Unverified',
  ];
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
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: [
          8.horizontalSpace,
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
    );
  }
}
