import '../../imports.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key, required this.home, required this.profile});
  final bool home;
  final bool profile;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: RepaintBoundary(
        child: Text('The Golden House',
            style: GoogleFonts.inter(
              fontSize: 24.w,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
              letterSpacing: -2,
            )),
      ),
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
  final List<String> tags = [
    'All',
    'Verified',
    'Melt',
    'Vaporize',
    'Mono Element',
    'Spread',
    'Aggravate',
    'Eletro Charged',
    'AMC',
  ];
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: widget.preferredSize,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List<Widget>.generate(
              tags.length,
              (index) => TagsChip(
                  selected: index == activeIndex,
                  text: tags[index],
                  onTap: () => setState(() {
                        activeIndex = index;
                      }))),
        ),
      ),
    );
  }
}
