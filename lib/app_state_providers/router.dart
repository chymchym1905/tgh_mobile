import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tgh_mobile/imports.dart';
import 'package:tgh_mobile/screens/homescreen/homebody.dart';
import 'package:tgh_mobile/screens/profilescreen/profilescreen_not_current.dart';
import 'package:tgh_mobile/screens/settingscreen/cachesetting.dart';
import 'package:tgh_mobile/screens/videoscreen/videoscreen.dart';
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
  final authStateNotifier = ValueNotifier<AuthState?>(const AuthStateLoggedOut());
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
        if (authStateNotifier.value is AuthStateLoggedOut && RouteMap.private.allowedRoutes.contains(state.uri.path)) {
          return Routes.login;
        } else if (authStateNotifier.value is AuthStateAuthenticated && state.uri.path == Routes.login) {
          return RouteMap.public.redirectPath;
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
        )
      ],
      extraCodec: const MyExtraCodec());
  ref.onDispose(router.dispose);

  return router;
}
