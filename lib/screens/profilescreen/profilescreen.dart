import 'package:tgh_mobile/imports.dart';
import 'profile_no_user.dart';
import 'profile_with_user.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(authNotifierProvider).when(
          data: (authState) => authState.when(
            authenticated: (user, authToken) {
              if (user.competitor?.id == null) {
                return ProfileNoUser(name: user.name);
              }
              final userProfileInfo = ref.watch(fetchAccountInfoProvider(user.id));
              return userProfileInfo.when(
                data: (data) => ProfileWithUser(user: user, userProfileInfo: data),
                error: (error, stack) => AppErrorWidget(message: [error.toString(), stack.toString()]),
                loading: () => Center(child: Sumerucart(width: 300.wr)),
              );
            },
            error: (error) => AppErrorWidget(message: [error.toString()]),
            loggedOut: () => const ProfileNoUser(),
          ),
          loading: () => Center(child: Sumerucart(width: 300.wr)),
          error: (error, stack) => AppErrorWidget(message: [error.toString(), stack.toString()]),
        );
  }
}
