import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../providers/dio.dart';
import '../api/index.dart';

part 'competitor.g.dart';

@riverpod
CompetitorApiBase competitorApi(Ref ref) {
  final networkService = ref.watch(dioNetworkServiceProvider);
  return CompetitorApi(networkService);
}
