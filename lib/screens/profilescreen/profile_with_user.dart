import 'package:flutter/gestures.dart';
import 'package:tgh_mobile/imports.dart';
import 'profile_with_user_body.dart';

class ProfileWithUser extends StatefulWidget {
  const ProfileWithUser({super.key, required this.user, required this.userProfileInfo});
  final User user;
  final UserProfileInfo userProfileInfo;

  @override
  State<ProfileWithUser> createState() => _ProfileWithUserState();
}

class _ProfileWithUserState extends State<ProfileWithUser> {
  double _scrollProgress = 0.0;
  final double _scrollThreshold = 200.0;

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
      Theme.of(context).colorScheme.surface,
      _scrollProgress,
    );
    final competitor = widget.user.competitor!;
    final profileInfo = widget.userProfileInfo;

    return SafeArea(
      child: Stack(
        children: [
          SizedBox(
            height: 400,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  bannerUrl(widget.user.id),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/tghbanner.png',
                      fit: BoxFit.cover,
                    );
                  },
                ),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Color.fromARGB(155, 0, 0, 0), Colors.black],
                      stops: [0.3, 0.8, 1.0],
                    ),
                  ),
                ),
              ],
            ),
          ),
          CustomScrollView(
            controller: _mainScrollController,
            slivers: [
              PinnedHeaderSliver(
                child: Container(
                    height: kToolbarHeight.swr,
                    decoration: BoxDecoration(color: backgroundColor),
                    child: Row(mainAxisAlignment: MainAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                      if (MediaQuery.of(context).size.width > kMaxWidthTablet &&
                          MediaQuery.of(context).size.width < kMaxWidthTabletLandscape)
                        SizedBox(
                            width: 70,
                            child: Center(
                                child: SizedBox(
                                    width: 56,
                                    height: 56,
                                    child: IconButton(
                                        onPressed: () {
                                          Scaffold.of(context).openDrawer();
                                        },
                                        icon: const Icon(Icons.dehaze,
                                            size: 30, weight: 700, grade: 200, opticalSize: 24))))),
                      SizedBox(width: 8.wr),
                      Visibility(
                          visible: _scrollProgress == 1,
                          child: Row(children: [
                            Container(
                                decoration: BoxDecoration(
                                    border: Border.all(width: 2, color: Theme.of(context).colorScheme.onSurface),
                                    shape: BoxShape.circle),
                                child: UniformCircleAvatar(url: pfpUrl(competitor.id), radius: 16.swr)),
                            SizedBox(width: 10.wr),
                            Text(competitor.alias, style: TextStyle(fontSize: 16.swr))
                          ])),
                      const Spacer(),
                      SizedBox(
                          width: 40,
                          height: 40,
                          child: IconButton(
                              onPressed: () {
                                context.go(Routes.settings);
                              },
                              icon: Icon(Icons.settings, size: 24.swr))),
                      SizedBox(width: 10.wr),
                    ])),
              ),
              // SliverAppBar(
              //     pinned: true,
              //     shadowColor: Colors.transparent,
              //     centerTitle: false,
              //     toolbarHeight: 50.wr,
              //     title: Visibility(
              //       visible: _scrollProgress == 1,
              //       child: Row(
              //         children: [
              //           Container(
              //               decoration: BoxDecoration(
              //                   border: Border.all(width: 2, color: Theme.of(context).colorScheme.onSurface),
              //                   shape: BoxShape.circle),
              //               child: UniformCircleAvatar(url: pfpUrl(competitor.id), radius: 16.wr)),
              //           SizedBox(width: 10.wr),
              //           Text(competitor.alias, style: TextStyle(fontSize: 16.wr)),
              //         ],
              //       ),
              //     ),
              //     backgroundColor: backgroundColor,
              //     elevation: 10,
              //     actions: [
              //       IconButton(
              //         onPressed: () {
              //           context.go(Routes.settings);
              //         },
              //         icon: const Icon(Icons.settings),
              //       ),
              //     ]),
              SliverToBoxAdapter(
                  child: Center(
                      child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: kMaxWidthTabletLandscape.toDouble()),
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.wr),
                              child: Column(children: [
                                120.verticalSpace,
                                Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.surfaceContainer,
                                      borderRadius: BorderRadius.circular(15.wr),
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 20.wr, vertical: 16.wr),
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                        Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    width: 2.wr, color: Theme.of(context).colorScheme.primary)),
                                            child: UniformCircleAvatar(url: pfpUrl(competitor.id), radius: 26.wr)),
                                        SizedBox(width: 10.wr),
                                        Expanded(
                                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                          Text(competitor.alias, style: TextStyle(fontSize: 16.wr)),
                                          5.wr.verticalSpace,
                                          Text(
                                              profileInfo.accountSnapshot?.signature ??
                                                  'This user has not left a signature',
                                              style: TextStyle(
                                                  fontSize: 12.wr,
                                                  color: Theme.of(context).extension<TextColors>()!.textSecondary)),
                                          10.wr.verticalSpace,
                                          Wrap(direction: Axis.horizontal, runSpacing: 4.wr, spacing: 10.wr, children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(horizontal: 10.wr, vertical: 4.wr),
                                              decoration: BoxDecoration(
                                                color: Theme.of(context).colorScheme.surfaceBright,
                                                borderRadius: BorderRadius.circular(10.wr),
                                              ),
                                              child: Row(mainAxisSize: MainAxisSize.min, children: [
                                                Image.asset('assets/icons/Ui_SystemOpenIcon_Obscurae.webp',
                                                    color: Theme.of(context).colorScheme.onSurface, width: 20.wr),
                                                5.horizontalSpace,
                                                Text('WL ${profileInfo.accountSnapshot?.worldLevel}',
                                                    style: TextStyle(
                                                        fontSize: 12.wr,
                                                        color:
                                                            Theme.of(context).extension<TextColors>()!.textSecondary))
                                              ]),
                                            ),
                                            Container(
                                                padding: EdgeInsets.symmetric(horizontal: 10.wr, vertical: 4.wr),
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context).colorScheme.surfaceBright,
                                                  borderRadius: BorderRadius.circular(10.wr),
                                                ),
                                                child: Row(mainAxisSize: MainAxisSize.min, children: [
                                                  Image.asset('assets/icons/UI_AchievementIcon_O001.webp',
                                                      width: 20.wr),
                                                  5.horizontalSpace,
                                                  Text('${profileInfo.accountSnapshot?.achievementCount} achievements',
                                                      style: TextStyle(
                                                          fontSize: 12.wr,
                                                          color:
                                                              Theme.of(context).extension<TextColors>()!.textSecondary))
                                                ])),
                                          ])
                                        ])),
                                        Column(children: [
                                          SizedBox(
                                              width: 35.wr,
                                              height: 35.wr,
                                              child: IconButton(onPressed: () {}, icon: Icon(Icons.edit, size: 16.wr)))
                                        ])
                                      ]),
                                      20.verticalSpace,
                                      Wrap(direction: Axis.horizontal, spacing: 10.wr, children: [
                                        RoleChip(
                                            widget.user.role.toCapitalized(), const Color.fromARGB(255, 245, 161, 93)),
                                        if (competitor.speedrunner == true)
                                          const RoleChip('Speedrunner', Color.fromARGB(255, 99, 190, 158)),
                                        if (competitor.dpser == true)
                                          const RoleChip('DPSer', Color.fromARGB(255, 246, 157, 251))
                                      ]),
                                      10.verticalSpace,
                                      Align(
                                          alignment: Alignment.centerRight,
                                          child: RichText(
                                              text: TextSpan(children: [
                                            TextSpan(
                                                text: 'View Character showcase',
                                                style: TextStyle(
                                                    fontSize: 12.wr,
                                                    decoration: TextDecoration.underline,
                                                    color: Theme.of(context).extension<TextColors>()!.textSecondary),
                                                recognizer: TapGestureRecognizer()..onTap = () {}),
                                          ]))),
                                    ])),
                                10.verticalSpace,
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.surfaceContainer,
                                    borderRadius: BorderRadius.circular(15.wr),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 20.wr, vertical: 16.wr),
                                  child: ProfileBody(user: widget.user, userProfileInfo: widget.userProfileInfo),
                                ),
                                10.verticalSpace,
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.surfaceContainer,
                                    borderRadius: BorderRadius.circular(15.wr),
                                  ),
                                  height: 1000,
                                )
                              ])))))
            ],
          ),
        ],
      ),
    );
  }
}
