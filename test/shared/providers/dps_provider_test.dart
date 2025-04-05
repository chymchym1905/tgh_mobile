import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tgh_mobile/shared/network_request_providers/dps.dart';

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
  group('DpsProvider Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = createContainer();
    });

    test('fetchCompetitorDps returns valid dps entries', () async {
      final api = container.read(dpsApiProvider);
      final result = await api.fetchCompetitorDps(
        '621336b43e8e7f7628dce587',
        'created_at',
        'desc',
        0,
        10,
        approved: true,
      );

      result.fold(
        (failure) => fail('API call failed: ${failure.toString()}'),
        (dpsEntries) {
          expect(dpsEntries, isNotNull);
          for (final dps in dpsEntries) {
            expect(dps.id, isNotEmpty);
            expect(dps.competitor.alias, equals('chymchym1905'));
            log('DPS ID: ${dps.id}');
            log('Enenmy: ${dps.enemy}');
            log('Video: ${dps.videolink}');
          }
        },
      );
    });

    test('fetchDps returns paginated dps entries', () async {
      final api = container.read(dpsApiProvider);
      final result = await api.fetchDps(
        'created_at',
        'desc',
        0,
        5,
        approved: true,
        queryParam: {'dps_category': 'Overworld'},
      );

      result.fold(
        (failure) => fail('API call failed: ${failure.toString()}'),
        (dpsEntries) {
          expect(dpsEntries.length, lessThanOrEqualTo(5));
          for (final dps in dpsEntries) {
            expect(dps.approved, isTrue);
            log('DPS ID: ${dps.id}');
            log('Created at: ${dps.createdAt}');
            log('Enenmy: ${dps.enemy}');
            log('Video: ${dps.videolink}');
          }
        },
      );
    });

    test('fetchDpsAgent returns agent dps entries', () async {
      final api = container.read(dpsApiProvider);
      final result = await api.fetchDpsAgent(
        'created_at',
        'desc',
        0,
        10,
        approved: true,
        queryParam: {'dps_category': 'Weekly Boss'},
      );

      result.fold(
        (failure) => fail('API call failed: ${failure.toString()}'),
        (dpsEntries) {
          expect(dpsEntries, isNotNull);
          for (final dps in dpsEntries) {
            expect(dps.id, isNotEmpty);
            log('Agent DPS ID: ${dps.id}');
            log('Category: ${dps.dpsCategory}');
            log('Enenmy: ${dps.enemy}');
            log('Video: ${dps.videolink}');
          }
        },
      );
    });
  });
}
