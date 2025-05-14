import 'package:tgh_mobile/imports.dart';

class ProfileNoUser extends StatefulWidget {
  const ProfileNoUser({super.key, this.name});
  final String? name;

  @override
  State<ProfileNoUser> createState() => _ProfileNoUserState();
}

class _ProfileNoUserState extends State<ProfileNoUser> {
  double _scrollProgress = 0.0;
  final double _scrollThreshold = 100.0;
  // bool _expanded = false;

  late final ScrollController _mainScrollController = ScrollController()
    ..addListener(() {
      final progress = (_mainScrollController.position.pixels / _scrollThreshold).clamp(0.0, 1.0);
      if (progress != _scrollProgress) {
        setState(() {
          _scrollProgress = progress;
        });
      }
    });

  @override
  void dispose() {
    _mainScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Color.lerp(
      Colors.transparent,
      Theme.of(context).colorScheme.surfaceContainerLowest,
      _scrollProgress,
    );
    return Stack(children: [
      Container(
        height: 400,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/tghbanner.png'),
            fit: BoxFit.cover,
            opacity: 1,
          ),
        ),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Color.fromARGB(191, 0, 0, 0), Colors.black],
              stops: [0.3, 0.8, 1.0],
            ),
          ),
        ),
      ),
      CustomScrollView(clipBehavior: Clip.none, controller: _mainScrollController, slivers: [
        SliverAppBar(
          pinned: true,
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
          backgroundColor: backgroundColor,
          actions: [
            IconButton(
              onPressed: () {
                context.go(Routes.settings);
              },
              icon: const Icon(Icons.settings),
            ),
          ],
        ),
        SliverToBoxAdapter(child: 120.verticalSpace),
        SliverToBoxAdapter(
            child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 512),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.wr),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainer,
                        borderRadius: BorderRadius.circular(15.wr),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20.wr, vertical: 16.wr),
                      child: Row(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(width: 2.wr, color: Theme.of(context).colorScheme.primary),
                              ),
                              child: UniformCircleAvatar(
                                url: '',
                                radius: 26.wr,
                              )),
                          10.horizontalSpace,
                          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(widget.name ?? 'Guest User', style: TextStyle(fontSize: 16.wr)),
                            5.wr.verticalSpace,
                            widget.name == null
                                ? Text('Create account to get started',
                                    style: TextStyle(
                                        fontSize: 12.wr,
                                        color: Theme.of(context).extension<TextColors>()!.textSecondary),
                                    overflow: TextOverflow.ellipsis)
                                : Text('Create a competitor profile to get started',
                                    style: TextStyle(
                                        fontSize: 12.wr,
                                        color: Theme.of(context).extension<TextColors>()!.textSecondary),
                                    overflow: TextOverflow.ellipsis),
                          ])
                        ],
                      ),
                    ))),
          ),
        )),
        SliverToBoxAdapter(child: 40.verticalSpace),
        SliverToBoxAdapter(
            child: Center(
                child: Column(children: [
          InkWellTextButton(
              onTap: () {
                if (widget.name == null) {
                  context.go(Routes.register);
                } else {}
              },
              text: widget.name == null ? 'Create account' : 'Create competitor profile',
              fontSize: 16.wr),
        ])))
      ])
    ]);
  }
}
