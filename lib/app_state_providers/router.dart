import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tgh_mobile/imports.dart';
import 'package:tgh_mobile/screens/homescreen/homebody.dart';
import 'package:tgh_mobile/screens/settingscreen/cachesetting.dart';
import 'package:tgh_mobile/screens/videoscreen/videoscreen.dart';
import 'dart:developer' as dev;

part 'router.g.dart';

// Custom observer to track navigation events
class GoRouterObserver extends NavigatorObserver {
  void _log(String message, Map<String, dynamic> data) {
    dev.log(message, name: 'Navigation');
    dev.log(data.toString(), name: 'Navigation');
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _log('New route pushed', {
      'current_route': route.settings.name,
      'previous_route': previousRoute?.settings.name,
      'arguments': route.settings.arguments,
    });
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _log('Route popped', {
      'popped_route': route.settings.name,
      'returning_to': previousRoute?.settings.name,
    });
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _log('Route removed', {
      'removed_route': route.settings.name,
      'new_top_route': previousRoute?.settings.name,
    });
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    _log('Route replaced', {
      'old_route': oldRoute?.settings.name,
      'new_route': newRoute?.settings.name,
      'arguments': newRoute?.settings.arguments,
    });
  }

  @override
  void didStartUserGesture(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _log('User gesture started', {
      'current_route': route.settings.name,
      'target_route': previousRoute?.settings.name,
    });
  }

  @override
  void didStopUserGesture() {
    _log('User gesture stopped', {});
  }
}

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

  final router = GoRouter(
      initialLocation: Routes.home,
      debugLogDiagnostics: true,
      restorationScopeId: 'router',
      observers: [GoRouterObserver()],
      routes: [
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
        GoRoute(
          path: Routes.videoPath,
          builder: (context, state) {
            final videoId = state.pathParameters['videoId']!;
            final routeData = state.extra as VideoRouteData;

            return VideoScreen(
              id: videoId,
              metadata: routeData.metadata,
              videos: routeData.relatedVideos,
            );
          },
        ),
      ],
      extraCodec: const MyExtraCodec());
  return router;
}
