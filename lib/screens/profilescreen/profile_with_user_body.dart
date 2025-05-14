import 'package:tgh_mobile/imports.dart';
import 'package:tgh_mobile/screens/profilescreen/section/speedrun.dart';
import 'section/dps.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key, required this.user, required this.userProfileInfo});
  final User user;
  final UserProfileInfo userProfileInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///Speedrun section
        SpeedrunSection(competitorId: user.competitor!.id),
        50.verticalSpace,

        ///DPS section
        DpsSection(competitorId: user.competitor!.id)
      ],
    );
  }
}
