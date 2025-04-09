import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tgh_mobile/shared/api/index.dart';
import 'package:tgh_mobile/shared/shared_pref.dart';

import '../../imports.dart';
import '../../app_state_providers/dio.dart';
import '../../app_state_providers/shared_pref.dart';
import '../exception.dart';

part 'auth.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  late AuthApi _authApi;
  late StorageService _sharedPrefs;

  @override
  FutureOr<AuthState> build() async {
    final dioNetworkService = ref.watch(dioNetworkServiceProvider);
    _authApi = AuthApi(dioNetworkService);
    _sharedPrefs = ref.watch(sharedPrefsServiceProvider);

    final localAuthToken = _sharedPrefs.get(APP_AUTH_TOKEN_STORAGE_KEY) as String?;

    if (localAuthToken != null) {
      dioNetworkService.updateHeaders(localAuthToken);
      final currentUser = await _authApi.checkAuth();
      return currentUser.fold(
        (failure) => const AuthStateInitial(),
        (success) => AuthState.authenticated(success, localAuthToken),
      );
    }
    return const AuthStateInitial();
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    final dioNetworkService = ref.read(dioNetworkServiceProvider);
    final result = await _authApi.login(email, password);

    result.fold(
      (failure) => state =
          AsyncValue.error(AuthStateError(AppException(message: failure.toString(), code: '1')), StackTrace.current),
      (success) async {
        final localAuthToken = dioNetworkService.headers['Authorization'] as String?;
        if (localAuthToken != null) {
          await _sharedPrefs.set(APP_AUTH_TOKEN_STORAGE_KEY, localAuthToken);
        }
        state = AsyncValue.data(AuthState.authenticated(success, localAuthToken ?? ''));
      },
    );
  }

  Future<void> checkAuth() async {
    state = const AsyncValue.loading();
    final dioNetworkService = ref.read(dioNetworkServiceProvider);
    final result = await _authApi.checkAuth();

    result.fold(
      (failure) => state =
          AsyncValue.error(AuthStateError(AppException(message: failure.toString(), code: '1')), StackTrace.current),
      (success) async {
        final localAuthToken = dioNetworkService.headers['Authorization'] as String?;
        if (localAuthToken != null) {
          await _sharedPrefs.set(APP_AUTH_TOKEN_STORAGE_KEY, localAuthToken);
        }
        state = AsyncValue.data(AuthState.authenticated(success, localAuthToken ?? ''));
      },
    );
  }
}
