import 'package:tgh_mobile/imports.dart';

import 'section/dps.dart';
import 'section/speedrun.dart';
import 'section/standings.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key, required this.user, required this.userProfileInfo});
  final User user;
  final UserProfileInfo userProfileInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///Standings section
        StandingsSection(userProfileInfo: userProfileInfo),
        10.verticalSpace,

        ///Speedrun section
        SpeedrunSection(competitorId: user.competitor!.id),
        10.verticalSpace,

        ///DPS section
        DpsSection(competitorId: user.competitor!.id),
      ],
    );
  }
}
