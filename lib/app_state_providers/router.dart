import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:tgh_mobile/imports.dart';
import 'package:tgh_mobile/screens/homescreen/homebody.dart';

part 'router.g.dart';

final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'shellHome');
final _shellNavigatorLeaderboardKey = GlobalKey<NavigatorState>(debugLabel: 'shellLeaderboard');
final _shellNavigatorStandingsKey = GlobalKey<NavigatorState>(debugLabel: 'shellStandings');
final _shellNavigatorProfileKey = GlobalKey<NavigatorState>(debugLabel: 'shellProfile');

@riverpod
GoRouter router(Ref ref) {
  final authState = ValueNotifier<AuthState?>(const AuthStateInitial());
  ref
    ..onDispose(authState.dispose)
    ..listen(authNotifierProvider, (_, next) {
      authState.value = next.value;
    });

  final router =
      GoRouter(initialLocation: Routes.home, debugLogDiagnostics: true, restorationScopeId: 'router', routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => HomeScreen(navigationShell: navigationShell),
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
  ]);
  return router;
}
