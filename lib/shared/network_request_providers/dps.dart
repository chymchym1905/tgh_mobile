import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../providers/dio.dart';
import '../api/index.dart';

part 'dps.g.dart';

@riverpod
DpsApiBase dpsApi(Ref ref) {
  final networkService = ref.watch(dioNetworkServiceProvider);
  return DpsApi(networkService);
}
