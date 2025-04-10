import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tgh_mobile/imports.dart';

part 'dps.g.dart';

@riverpod
DpsApiBase dpsApi(Ref ref) {
  final networkService = ref.watch(dioNetworkServiceProvider);
  return DpsApi(networkService);
}

@riverpod
Future<List<DPS>> fetchCompetitorDps(
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

  final api = ref.watch(dpsApiProvider);
  final result = await api.fetchCompetitorDps(
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
Future<List<DPS>> fetchDps(
  Ref ref, {
  required String sortBy,
  required String sortDir,
  required int page,
  required int limit,
  bool? approved,
  Map<String, dynamic>? queryParam,
}) async {
  final cancelToken = await ref.cancelToken();

  final api = ref.watch(dpsApiProvider);
  final result = await api.fetchDps(
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
Future<List<DPS>> fetchDpsAgent(
  Ref ref, {
  required String sortBy,
  required String sortDir,
  required int page,
  required int limit,
  bool? approved,
  Map<String, dynamic>? queryParam,
}) async {
  final cancelToken = await ref.cancelToken();

  final api = ref.watch(dpsApiProvider);
  final result = await api.fetchDpsAgent(
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
