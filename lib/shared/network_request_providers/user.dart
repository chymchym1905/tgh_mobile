import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../providers/dio.dart';
import '../api/index.dart';

part 'user.g.dart';

@riverpod
UserApiBase userApi(Ref ref) {
  final networkService = ref.watch(dioNetworkServiceProvider);
  return UserApi(networkService);
}
