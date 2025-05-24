import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tgh_mobile/imports.dart';
import 'package:tgh_mobile/screens/homescreen/homebody.dart';
import 'package:tgh_mobile/screens/profilescreen/profilescreen_not_current.dart';
import 'package:tgh_mobile/screens/settingscreen/cachesetting.dart';
import 'package:tgh_mobile/utils/observer.dart';
part 'router.g.dart';

// Custom observer to track navigation event

final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'shellHome');
final _shellNavigatorLeaderboardKey = GlobalKey<NavigatorState>(debugLabel: 'shellLeaderboard');
final _shellNavigatorStandingsKey = GlobalKey<NavigatorState>(debugLabel: 'shellStandings');
final _shellNavigatorProfileKey = GlobalKey<NavigatorState>(debugLabel: 'shellProfile');

@riverpod
GoRouter router(Ref ref) {
  final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'rootNavigatorKey');
  final authStateNotifier = ValueNotifier<AuthState?>(null); // Start with null instead of LoggedOut
  ref.onDispose(authStateNotifier.dispose);
  ref.listen(authNotifierProvider, (_, next) {
    next.whenData((authState) {
      authStateNotifier.value = authState;
    });
  });
  final router = GoRouter(
      initialLocation: Routes.home,
      debugLogDiagnostics: true,
      restorationScopeId: 'router',
      navigatorKey: rootNavigatorKey,
      refreshListenable: authStateNotifier,
      // ignore: body_might_complete_normally_nullable
      redirect: (context, state) {
        if (authStateNotifier.value == null) {
          return null;
        }
        print(state.uri.path);
        if (authStateNotifier.value is AuthStateLoggedOut && RouteMap.private.allowedRoutes.contains(state.uri.path)) {
          // Store the requested path in query parameter for later redirection
          final uri = Uri(path: Routes.login, queryParameters: {'from': state.uri.path});
          return uri.toString();
        } else if (authStateNotifier.value is AuthStateAuthenticated) {
          if (state.uri.path == Routes.login) {
            // If there's a 'from' parameter, redirect to that path after login
            final fromPath = state.uri.queryParameters['from'];
            return fromPath ?? RouteMap.public.redirectPath;
          }
        } else if (authStateNotifier.value is AuthStateError) {
          return null;
        }
        return null;
      },
      observers: [GoRouterObserver()],
      routes: [
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return HomeScreen(navigationShell: navigationShell);
          },
          restorationScopeId: 'shell',
          branches: [
            StatefulShellBranch(
              restorationScopeId: 'home',
              navigatorKey: _shellNavigatorHomeKey,
              routes: [
                GoRoute(
                  path: Routes.home,
                  builder: (context, state) => const HomeBody(),
                ),
              ],
            ),
            StatefulShellBranch(
              restorationScopeId: 'leaderboard',
              navigatorKey: _shellNavigatorLeaderboardKey,
              routes: [
                GoRoute(
                  path: Routes.leaderboard,
                  builder: (context, state) => const LeaderboardScreen(),
                ),
              ],
            ),
            StatefulShellBranch(
              restorationScopeId: 'standings',
              navigatorKey: _shellNavigatorStandingsKey,
              routes: [
                GoRoute(
                  path: Routes.standings,
                  builder: (context, state) => const StandingsScreen(),
                ),
              ],
            ),
            StatefulShellBranch(
              restorationScopeId: 'profile',
              navigatorKey: _shellNavigatorProfileKey,
              routes: [
                GoRoute(
                  path: Routes.profile,
                  builder: (context, state) => const ProfileScreen(),
                  routes: [
                    GoRoute(
                      path: 'settings',
                      builder: (context, state) => const SettingsScreen(),
                      routes: [
                        GoRoute(
                          path: 'clear-cache',
                          builder: (context, state) => const ClearCacheScreen(),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: Routes.login,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: Routes.register,
          builder: (context, state) => const SignUpScreen(),
        ),
        GoRoute(
          path: Routes.videoPath,
          name: 'video',
          builder: (context, state) {
            final id = state.pathParameters['id'] ?? '';
            return VideoScreen(id: id);
          },
        ),
        GoRoute(
          path: Routes.profileNonCurrent,
          name: 'profileNonCurrent',
          builder: (context, state) {
            final alias = state.pathParameters['alias'] ?? '';
            return ProfileScreenNonCurrent(competitorAlias: alias);
          },
        ),
        GoRoute(path: Routes.submitSpeedrun, builder: (context, state) => const SubmitSpeedrunScreen()),
        GoRoute(path: Routes.submitDps, builder: (context, state) => const SubmitDpsScreen()),
        GoRoute(path: Routes.submitRestrictedDps, builder: (context, state) => const SubmitRestrictedDpsScreen()),
      ],
      extraCodec: const MyExtraCodec());
  ref.onDispose(router.dispose);

  return router;
}
