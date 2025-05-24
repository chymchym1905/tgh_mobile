import 'package:tgh_mobile/imports.dart';

class ProfileInformation extends ConsumerWidget {
  const ProfileInformation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(15.wr),
        border: Border.all(color: Theme.of(context).colorScheme.outline),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.wr, vertical: 10.wr),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ref.watch(authNotifierProvider).when(
              data: (authState) => authState.when(
                authenticated: (user, authToken) {
                  if (user.competitor != null) {
                    return Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 2, color: Theme.of(context).colorScheme.primary)),
                        child: UniformCircleAvatar(url: pfpUrl(user.competitor!.id), radius: 24.swr));
                  }
                  return Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 2, color: Theme.of(context).colorScheme.primary)),
                      child: UniformCircleAvatar(url: '', radius: 24.swr));
                },
                error: (error) => const SizedBox.shrink(),
                loggedOut: () => const SizedBox.shrink(),
              ),
              error: (error, stack) => const SizedBox.shrink(),
              loading: () => ShimmerComponent.circular(height: 24.swr * 2 + 4, width: 24.swr * 2 + 4),
            ),
        const SizedBox(width: 10),
        ref.watch(authNotifierProvider).when(
              data: (authState) => authState.when(
                authenticated: (user, authToken) {
                  if (user.competitor != null) {
                    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(user.competitor!.alias,
                          style: TextStyle(fontSize: 16.swr, color: Theme.of(context).extension<TextColors>()!.text)),
                      const SizedBox(height: 8),
                      Row(children: [
                        SvgPicture.asset('assets/icons/discord.svg',
                            height: 16.swr,
                            colorFilter: const ColorFilter.mode(Color.fromARGB(255, 97, 105, 229), BlendMode.srcIn)),
                        const SizedBox(width: 4),
                        Text(user.competitor!.discordtag.toString(),
                            style: TextStyle(
                                fontSize: 16.swr, color: Theme.of(context).extension<TextColors>()!.textSecondary))
                      ]),
                      const SizedBox(height: 8),
                      Text(user.competitor!.uid.toString(),
                          style: TextStyle(
                              fontSize: 16.swr, color: Theme.of(context).extension<TextColors>()!.textSecondary)),
                    ]);
                  }
                  return Expanded(
                    child: Text('You have not created a competitor profile, please create one to start submitting',
                        style: TextStyle(fontSize: 16.swr, color: Theme.of(context).extension<TextColors>()!.text)),
                  );
                },
                error: (error) => const SizedBox.shrink(),
                loggedOut: () => const SizedBox.shrink(),
              ),
              error: (error, stack) => const SizedBox.shrink(),
              loading: () => Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(children: [
                      Flexible(flex: 4, child: ShimmerComponent.regtangular(height: 16.swr)),
                      const Spacer(flex: 1)
                    ]),
                    const SizedBox(height: 8),
                    Row(children: [
                      Flexible(flex: 3, child: ShimmerComponent.regtangular(height: 16.swr)),
                      const Spacer(flex: 1)
                    ]),
                    const SizedBox(height: 8),
                    Row(children: [
                      Flexible(flex: 2, child: ShimmerComponent.regtangular(height: 16.swr)),
                      const Spacer(flex: 1)
                    ]),
                  ],
                ),
              ),
            )
      ]),
    );
  }
}
