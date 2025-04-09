import 'package:freezed_annotation/freezed_annotation.dart';

import '../../exception.dart';
import '../index.dart';

part 'authstate.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState.initial() = AuthStateInitial;
  const factory AuthState.authenticated(User user, String authToken) = AuthStateAuthenticated;
  const factory AuthState.error(AppException exception) = AuthStateError;
  const factory AuthState.loggedOut() = AuthStateLoggedOut;
}
