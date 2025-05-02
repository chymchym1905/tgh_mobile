import 'package:tgh_mobile/imports.dart';

class ProfileWithUser extends StatefulWidget {
  const ProfileWithUser({super.key, required this.user, required this.userProfileInfo});
  final User user;
  final UserProfileInfo userProfileInfo;

  @override
  State<ProfileWithUser> createState() => _ProfileWithUserState();
}

class _ProfileWithUserState extends State<ProfileWithUser> {
  double _scrollProgress = 0.0;
  final double _scrollThreshold = 100.0;

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
    final competitor = widget.user.competitor!;
    final profileInfo = widget.userProfileInfo;

    return Stack(
      children: [
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
        CustomScrollView(
          clipBehavior: Clip.none,
          controller: _mainScrollController,
          slivers: [
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
            SliverToBoxAdapter(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 512),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        120.verticalSpace,
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surfaceContainer,
                            borderRadius: BorderRadius.circular(15.wr),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 20.wr, vertical: 16.wr),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        width: 2.wr,
                                        color: Theme.of(context).colorScheme.primary,
                                      ),
                                    ),
                                    child: UniformCircleAvatar(
                                      url: pfpUrl(competitor.id),
                                      radius: 26.wr,
                                    ),
                                  ),
                                  10.horizontalSpace,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(competitor.alias, style: TextStyle(fontSize: 16.wr)),
                                        5.wr.verticalSpace,
                                        Text(
                                          profileInfo.accountSnapshot?.signature ??
                                              'This user has not left a signature',
                                          style: TextStyle(
                                            fontSize: 12.wr,
                                            color: Theme.of(context).extension<TextColors>()!.textSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              10.verticalSpace,
                              Wrap(
                                direction: Axis.horizontal,
                                spacing: 10.wr,
                                children: [
                                  RoleChip(widget.user.role.toCapitalized(), const Color.fromARGB(255, 245, 161, 93)),
                                  if (competitor.speedrunner == true)
                                    const RoleChip('Speedrunner', Color.fromARGB(255, 99, 190, 158)),
                                  if (competitor.dpser == true)
                                    const RoleChip('DPSer', Color.fromARGB(255, 246, 157, 251)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 512),
                        child: ListTile(
                          title: Text(
                            'Item $index',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          subtitle: Text(
                            'This is a description for item $index',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          leading: CircleAvatar(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            child: Text('${index + 1}'),
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: 100,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
