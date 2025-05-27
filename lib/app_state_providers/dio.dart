import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../imports.dart';
import '../shared/network.dart';

part 'dio.g.dart';

@riverpod
NetworkService dioNetworkService(Ref ref) {
  final dio = Dio();
  return DioNetworkService(dio, AppConfig.apiUrl);
}
