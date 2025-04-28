import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../constant/routes.dart';
import '../../exception.dart';
import '../index.dart';

part 'authstate.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState.authenticated(User user, String authToken) = AuthStateAuthenticated;
  const factory AuthState.error(AppException exception) = AuthStateError;
  const factory AuthState.loggedOut() = AuthStateLoggedOut;
}

enum RouteMap {
  public(
    redirectPath: '/',
    allowedRoutes: [
      Routes.login,
      Routes.register,
      Routes.forgotPassword,
      Routes.profile,
      Routes.settings,
      Routes.theme,
      Routes.clearCache,
      Routes.home,
      Routes.videoPath,
      Routes.leaderboard,
      Routes.standings,
    ],
  ),

  private(
    redirectPath: '/profile',
    allowedRoutes: [
      Routes.submit,
      Routes.submitSpeedrun,
      Routes.submitDps,
      Routes.submitRestrictedDps,
      Routes.dashBoard,
      Routes.agentDashboard,
    ],
  );

  final String redirectPath;
  final List<String> allowedRoutes;
  const RouteMap({
    required this.redirectPath,
    required this.allowedRoutes,
  });
}
