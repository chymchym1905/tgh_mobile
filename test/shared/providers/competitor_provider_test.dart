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
  group('CompetitorProvider Tests', () {
    late ProviderContainer container;
    var competitorId = '';
    final testAlias = generateRandomAlias();
    final testUpdatedAlias = generateRandomAlias(testAlias);
    developer.log('Test Alias: $testAlias');
    developer.log('Test Updated Alias: $testUpdatedAlias');

    setUp(() async {
      WidgetsFlutterBinding.ensureInitialized();
      // Must have line to run test
      SharedPreferences.setMockInitialValues({});
      container = createContainer(
        overrides: [
          sharedPrefInstanceProvider.overrideWithValue(await SharedPreferences.getInstance()),
          dioNetworkServiceProvider.overrideWithValue(DioNetworkService(Dio())),
        ],
      );
      await container
          .read(authNotifierProvider.notifier)
          .login('leyeuttoteuhau-8698@yopmail.com', 'SecurePassword123\\');
    });

    test('createCompetitor creates new competitor', () async {
      final authState = await container.read(authNotifierProvider.future);
      expect(authState, isA<AuthStateAuthenticated>());

      /// Create and link competitor profile to a user
      final api = container.read(competitorApiProvider);
      final result = await api.createCompetitor({
        'alias': testAlias,
        'discord_tag': 'chymchym1905',
        'account_uid': '123456789',
        'deleted_at': DateTime.now().subtract(const Duration(days: 29, hours: 23, minutes: 57)).toIso8601String(),
      });

      result.fold(
        (failure) => fail('API call failed: ${failure.toString()}'),
        (success) {
          expect(success.competitor?.alias, testAlias);
          expect(success.competitor?.discordtag, 'chymchym1905');
          expect(success.competitor?.uid, 123456789);
          competitorId = success.competitor?.id ?? '';
          developer.log('Competitor ID: $competitorId, Alias: $testAlias, Discord ID: chymchym1905, UID: 123456789');
        },
      );
    });

    test('unsetCompetitor removes competitor link', () async {
      final authState = await container.read(authNotifierProvider.future);
      expect(authState, isA<AuthStateAuthenticated>());

      /// Unlink competitor profile from a user
      final api = container.read(userApiProvider);
      final result = await api.unsetCompetitor();

      result.fold(
        (failure) => fail('API call failed: ${failure.toString()}'),
        (success) {
          developer.log('Competitor unlinked successfully');
        },
      );
    });

    test('Relink the competitor profile to the user', () async {
      final authState = await container.read(authNotifierProvider.future);
      expect(authState, isA<AuthStateAuthenticated>());

      /// Link competitor profile to the user again
      final api = container.read(userApiProvider);
      final result = await api.updateCompetitorForCurrentUser({
        'competitor': competitorId,
      });

      result.fold(
        (failure) => fail('API call failed: ${failure.toString()}'),
        (user) {
          expect(user, isNotNull);
          expect(user?.competitor?.alias, testAlias);
          developer.log('Competitor $competitorId linked successfully');
        },
      );
    });

    test('Update the competitor profile', () async {
      final authState = await container.read(authNotifierProvider.future);
      expect(authState, isA<AuthStateAuthenticated>());

      /// Modify competitor profile
      final api = container.read(competitorApiProvider);
      final result = await api.updateCompetitorInfo({
        'alias': testUpdatedAlias,
        'discord_tag': 'updatedchymchym1905',
        'account_uid': '987654321',
      });

      result.fold(
        (failure) => fail('API call failed: ${failure.toString()}'),
        (competitor) {
          expect(competitor?.alias, testUpdatedAlias);
          developer.log('Competitor $testAlias updated to $testUpdatedAlias successfully');
        },
      );
      final userApi = container.read(userApiProvider);
      final result2 = await userApi.unsetCompetitor();

      result2.fold(
        (failure) => fail('API call failed: ${failure.toString()}'),
        (success) {
          developer.log('Competitor $competitorId unlinked successfully');
        },
      );
    });

    test('getCompetitorByAlias fetches competitor profile', () async {
      final api = container.read(competitorApiProvider);
      final result = await api.getCompetitorByAlias(testUpdatedAlias);

      result.fold(
        (failure) => fail('API call failed: ${failure.toString()}'),
        (competitor) {
          expect(competitor.uid, equals(null));
          developer.log('Competitor ID: ${competitor.id}');
          developer.log('Alias: ${competitor.alias}');
          developer.log('Discord ID: ${competitor.discordtag}');
        },
      );
    });
  });
}
