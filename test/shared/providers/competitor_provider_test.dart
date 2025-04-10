import 'dart:developer' as developer;
import 'dart:math';

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

String generateRandomAlias([String? exclude]) {
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  final random = Random();
  String result;

  do {
    final buffer = StringBuffer();
    // First character must be a letter
    buffer.write(chars[random.nextInt(26)]);

    // Rest can be alphanumeric
    final length = random.nextInt(5) + 8; // 8-12 characters
    for (var i = 1; i < length; i++) {
      buffer.write(chars[random.nextInt(chars.length)]);
    }
    result = buffer.toString();
  } while (exclude != null && result == exclude);

  return result;
}

void main() {
  group('CompetitorProvider Tests - Sequential Flow', () {
    late ProviderContainer container;
    var competitorId = '';
    final testAlias = generateRandomAlias();
    final testUpdatedAlias = generateRandomAlias(testAlias);
    developer.log('Test Alias: $testAlias');
    developer.log('Test Updated Alias: $testUpdatedAlias');

    setUpAll(() async {
      WidgetsFlutterBinding.ensureInitialized();
      SharedPreferences.setMockInitialValues({});
      container = createContainer(
        overrides: [
          sharedPrefInstanceProvider.overrideWithValue(await SharedPreferences.getInstance()),
          dioNetworkServiceProvider.overrideWithValue(DioNetworkService(Dio())),
        ],
      );
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
    });

    test('1. Create and link new competitor profile to a user', () async {
      final states = List<AsyncValue<User>>.empty(growable: true);
      final provider = createCompetitorProvider({
        'alias': testAlias,
        'discord_tag': 'chymchym1905',
        'account_uid': '123456789',
        'deleted_at': DateTime.now().subtract(const Duration(days: 29, hours: 23, minutes: 57)).toIso8601String(),
      });
      final subscription = container.listen(
        provider,
        (previous, next) => states.add(next),
        fireImmediately: true,
      );

      await container.read(provider.future);
      subscription.close();

      final user = states.last.value;
      developer.log(states.toString());
      expect(user, isNotNull);
      expect(user?.competitor?.alias, testAlias);
      expect(user?.competitor?.discordtag, 'chymchym1905');
      expect(user?.competitor?.uid, 123456789);
      competitorId = user?.competitor?.id ?? '';
      developer.log('Competitor ID: $competitorId, Alias: $testAlias, Discord ID: chymchym1905, UID: 123456789');
    });

    test('2. Unlink competitor profile from a user', () async {
      final states = List<AsyncValue<void>>.empty(growable: true);
      final provider = unsetCompetitorProvider;
      final subscription = container.listen(
        provider,
        (previous, next) => states.add(next),
        fireImmediately: true,
      );

      await container.read(provider.future);
      subscription.close();

      developer.log(states.toString());
      developer.log('Competitor unlinked successfully');
    });

    test('3. Relink the same competitor profile to the user again', () async {
      final states = List<AsyncValue<User?>>.empty(growable: true);
      final provider = updateCompetitorForCurrentUserProvider({
        'competitor': competitorId,
      });
      final subscription = container.listen(
        provider,
        (previous, next) => states.add(next),
        fireImmediately: true,
      );

      await container.read(provider.future);
      subscription.close();

      final user = states.last.value;
      developer.log(states.toString());
      expect(user, isNotNull);
      expect(user?.competitor?.alias, testAlias);
      developer.log('Competitor $competitorId linked successfully');
    });

    test('4. Update the competitor profile', () async {
      final states = List<AsyncValue<Competitor?>>.empty(growable: true);
      final provider = updateCompetitorInfoProvider({
        'alias': testUpdatedAlias,
        'discord_tag': 'updatedchymchym1905',
        'account_uid': '987654321',
      });
      final subscription = container.listen(
        provider,
        (previous, next) => states.add(next),
        fireImmediately: true,
      );

      await container.read(provider.future);
      subscription.close();

      final competitor = states.last.value;
      developer.log(states.toString());
      expect(competitor?.alias, testUpdatedAlias);
      developer.log('Competitor $testAlias updated to $testUpdatedAlias successfully');

      // Unlink competitor after update
      final unsetStates = List<AsyncValue<void>>.empty(growable: true);
      final unsetProvider = unsetCompetitorProvider;
      final unsetSubscription = container.listen(
        unsetProvider,
        (previous, next) => unsetStates.add(next),
        fireImmediately: true,
      );

      await container.read(unsetProvider.future);
      unsetSubscription.close();

      developer.log(unsetStates.toString());
      developer.log('Competitor $competitorId unlinked successfully');
    });

    test('5. getCompetitorByAlias fetches competitor profile', () async {
      final states = List<AsyncValue<Competitor>>.empty(growable: true);
      final provider = getCompetitorByAliasProvider(testUpdatedAlias);
      final subscription = container.listen(
        provider,
        (previous, next) => states.add(next),
        fireImmediately: true,
      );

      await container.read(provider.future);
      subscription.close();

      final competitor = states.last.value;
      developer.log(states.toString());
      expect(competitor?.uid, equals(null));
      developer.log('Competitor ID: ${competitor?.id}');
      developer.log('Alias: ${competitor?.alias}');
      developer.log('Discord ID: ${competitor?.discordtag}');
    });
  });
}
