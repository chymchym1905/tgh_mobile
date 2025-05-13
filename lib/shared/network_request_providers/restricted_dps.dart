import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tgh_mobile/imports.dart';

part 'restricted_dps.g.dart';

@riverpod
RestrictedDpsApiBase restrictedDpsApi(Ref ref) {
  final networkService = ref.watch(dioNetworkServiceProvider);
  return RestrictedDpsApi(networkService);
}

@riverpod
Future<(int count, List<DPS> dps)> fetchCompetitorRestrictedDps(
  Ref ref, {
  required String competitorId,
  required String sortBy,
  required String sortDir,
  required int page,
  required int limit,
  bool? approved,
  Map<String, dynamic>? queryParam,
}) async {
  final cancelToken = await ref.cancelToken();

  final api = ref.watch(restrictedDpsApiProvider);
  final result = await api.fetchCompetitorRestrictedDps(
    competitorId,
    sortBy,
    sortDir,
    page,
    limit,
    approved: approved,
    queryParam: queryParam,
    cancelToken: cancelToken,
  );

  return result.fold(
    (failure) => throw failure,
    (dpsEntries) => dpsEntries,
  );
}

@riverpod
Future<(int count, List<DPS> dps, List<CharUsageLbDisplay> charSnapshots)> fetchRestrictedDps(
  Ref ref, {
  required String sortBy,
  required String sortDir,
  required int page,
  required int limit,
  bool? approved,
  Map<String, dynamic>? queryParam,
}) async {
  final cancelToken = await ref.cancelToken();

  final api = ref.watch(restrictedDpsApiProvider);
  final result = await api.fetchRestrictedDps(
    sortBy,
    sortDir,
    page,
    limit,
    approved: approved,
    queryParam: queryParam,
    cancelToken: cancelToken,
  );

  return result.fold(
    (failure) => throw failure,
    (dpsEntries) => dpsEntries,
  );
}

@riverpod
Future<(int count, List<DPS> dps)> fetchRestrictedDpsAgent(
  Ref ref, {
  required String sortBy,
  required String sortDir,
  required int page,
  required int limit,
  bool? approved,
  Map<String, dynamic>? queryParam,
}) async {
  final cancelToken = await ref.cancelToken();

  final api = ref.watch(restrictedDpsApiProvider);
  final result = await api.fetchRestrictedDpsAgent(
    sortBy,
    sortDir,
    page,
    limit,
    approved: approved,
    queryParam: queryParam,
    cancelToken: cancelToken,
  );

  return result.fold(
    (failure) => throw failure,
    (dpsEntries) => dpsEntries,
  );
}
