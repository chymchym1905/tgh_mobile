class Routes {
  static const String home = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String profile = '/profile';
  static const String profileNonCurrent = '/public-profile/:alias';
  static String profileNonCurrentWithAlias(String alias) => '/public-profile/$alias';
  static const String settings = '/profile/settings';
  static const String theme = '/profile/settings/theme';
  static const String clearCache = '/profile/settings/clear-cache';
  static const String leaderboard = '/leaderboard';
  static const String standings = '/standings';
  static const String submit = '/submit';
  static const String submitSpeedrun = '/submit-run';
  static const String submitDps = '/submit-dps';
  static const String submitRestrictedDps = '/submit-restricted-dps';
  static const String dashBoard = '/admin-dashboard';
  static const String agentDashboard = '/agent-dashboard';
  static String video(String id) => '/video/$id';
  static const String videoPath = '/video/:id';
}
