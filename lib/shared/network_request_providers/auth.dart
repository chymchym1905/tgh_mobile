import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tgh_mobile/shared/shared_pref.dart';

import '../../imports.dart';
import '../exception.dart';
import '../network.dart';

part 'auth.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  late AuthApi _authApi;
  late StorageService _sharedPrefs;
  late NetworkService _dioNetworkService;

  @override
  Future<AuthState> build() async {
    _dioNetworkService = ref.watch(dioNetworkServiceProvider);
    _authApi = AuthApi(_dioNetworkService);
    _sharedPrefs = ref.watch(sharedPrefsServiceProvider);

    final localAuthToken = _sharedPrefs.get(APP_AUTH_TOKEN_STORAGE_KEY) as String?;

    if (localAuthToken != null) {
      _dioNetworkService.updateHeaders(localAuthToken);
      final cancelToken = await ref.cancelToken();
      final currentUser = await _authApi.checkAuth(cancelToken: cancelToken);
      return currentUser.fold(
        (failure) => const AuthStateInitial(),
        (success) => AuthState.authenticated(success, localAuthToken),
      );
    }
    return const AuthStateInitial();
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
}
