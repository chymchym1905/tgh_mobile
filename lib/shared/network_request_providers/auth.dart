import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tgh_mobile/shared/shared_pref.dart';

import '../../imports.dart';
import '../exception.dart';
import '../network.dart';

part 'auth.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  late final AuthApi _authApi = AuthApi(_dioNetworkService);
  late final StorageService _sharedPrefs = ref.watch(sharedPrefsServiceProvider);
  late final NetworkService _dioNetworkService = ref.watch(dioNetworkServiceProvider);

  @override
  Future<AuthState> build() async {
    final localAuthToken = _sharedPrefs.get(APP_AUTH_TOKEN_STORAGE_KEY) as String?;

    if (localAuthToken != null) {
      _dioNetworkService.updateHeaders(localAuthToken);
      final cancelToken = await ref.cancelToken();
      final currentUser = await _authApi.checkAuth(cancelToken: cancelToken);
      return currentUser.fold(
        (failure) {
          _dioNetworkService.removeAuthHeader();
          _sharedPrefs.remove(APP_AUTH_TOKEN_STORAGE_KEY);
          return const AuthStateLoggedOut();
        },
        (success) => AuthState.authenticated(success, localAuthToken),
      );
    }
    return const AuthStateLoggedOut();
  }

  Future<AuthState> login(String email, String password) async {
    state = const AsyncValue.loading();
    final cancelToken = await ref.cancelToken();
    final result = await _authApi.login(email, password, cancelToken: cancelToken);
    return result.fold(
      (failure) {
        final exception = AppException(message: failure.toString(), code: '1');
        state = AsyncValue.error(AuthStateError(exception), StackTrace.current);
        return AuthState.error(exception);
      },
      (success) async {
        final localAuthToken = _dioNetworkService.headers['Authorization'] as String?;
        if (localAuthToken != null) {
          await _sharedPrefs.set(APP_AUTH_TOKEN_STORAGE_KEY, localAuthToken);
        }
        final value = AuthState.authenticated(success, localAuthToken ?? '');
        state = AsyncValue.data(value);
        return value;
      },
    );
  }

  Future<AuthState> checkAuth() async {
    state = const AsyncValue.loading();
    final cancelToken = await ref.cancelToken();
    final result = await _authApi.checkAuth(cancelToken: cancelToken);

    return result.fold(
      (failure) {
        final exception = AppException(message: failure.toString(), code: '1');
        state = AsyncValue.error(AuthStateError(exception), StackTrace.current);
        return AuthState.error(exception);
      },
      (success) async {
        final localAuthToken = _dioNetworkService.headers['Authorization'] as String?;
        if (localAuthToken != null) {
          await _sharedPrefs.set(APP_AUTH_TOKEN_STORAGE_KEY, localAuthToken);
        }
        final value = AuthState.authenticated(success, localAuthToken ?? '');
        state = AsyncValue.data(value);
        return value;
      },
    );
  }

  void logout() {
    _sharedPrefs.remove(APP_AUTH_TOKEN_STORAGE_KEY);
    _dioNetworkService.removeAuthHeader();
    state = const AsyncValue.data(AuthState.loggedOut());
  }
}
