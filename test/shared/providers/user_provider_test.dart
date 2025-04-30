import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';
import 'package:tgh_mobile/imports.dart';
import 'package:tgh_mobile/shared/network.dart';

ProviderContainer createContainer({
  ProviderContainer? parent,
  List<Override> overrides = const [],
  List<ProviderObserver>? observers,
}) {
  final container = ProviderContainer(
    parent: parent,
    overrides: overrides,
    observers: observers,
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  group('UserProvider Tests', () {
    late ProviderContainer container;

    setUpAll(() async {
      WidgetsFlutterBinding.ensureInitialized();
      SharedPreferences.setMockInitialValues({});
      container = createContainer(
        overrides: [
          sharedPrefInstanceProvider.overrideWithValue(await SharedPreferences.getInstance()),
          dioNetworkServiceProvider.overrideWithValue(DioNetworkService(Dio())),
        ],
      );
    });

    test('fetchAccountInfo with empty competitor Profile', () async {
      // Ensure authentication is done once for all tests
      final authStates = List<AsyncValue<AuthState>>.empty(growable: true);
      final authStateSubscription = container.listen(
        authNotifierProvider,
        (previous, next) => authStates.add(next),
        fireImmediately: true,
      );
      await container
          .read(authNotifierProvider.notifier)
          .login('leyeuttoteuhau-8698@yopmail.com', 'SecurePassword123\\');
      expect(authStates.last.value, isA<AuthStateAuthenticated>());
      authStateSubscription.close();

      final userId = authStates.last.value?.map(
        authenticated: (authenticated) => authenticated.user.id,
        error: (error) => '',
        loggedOut: (loggedOut) => '',
      );

      // Fetch public account info
      final states = List<AsyncValue<UserProfileInfo>>.empty(growable: true);
      final provider = fetchAccountInfoProvider(userId ?? '');
      final subscription = container.listen(
        provider,
        (previous, next) => states.add(next),
        fireImmediately: true,
      );
      await container.read(provider.future);
      subscription.close();

      final userProfileInfo = states.last.value;
      log(userProfileInfo.toString());
      expect(userProfileInfo, isA<UserProfileInfo>());
    });

    test('fetchAccountInfo with valid competitor Profile', () async {
      // Ensure authentication is done once for all tests
      final authStates = List<AsyncValue<AuthState>>.empty(growable: true);
      final authStateSubscription = container.listen(
        authNotifierProvider,
        (previous, next) => authStates.add(next),
        fireImmediately: true,
      );
      await container.read(authNotifierProvider.notifier).login('captainjack981@gmail.com', 'SecurePassword123\\');
      expect(authStates.last.value, isA<AuthStateAuthenticated>());
      authStateSubscription.close();

      final userId = authStates.last.value?.map(
        authenticated: (authenticated) => authenticated.user.id,
        error: (error) => '',
        loggedOut: (loggedOut) => '',
      );

      // Fetch public account info
      final states = List<AsyncValue<UserProfileInfo>>.empty(growable: true);
      final provider = fetchAccountInfoProvider(userId ?? '');
      final subscription = container.listen(
        provider,
        (previous, next) => states.add(next),
        fireImmediately: true,
      );
      await container.read(provider.future);
      subscription.close();

      final userProfileInfo = states.last.value;
      log(userProfileInfo.toString());
      expect(userProfileInfo, isA<UserProfileInfo>());
    });
  });
}
