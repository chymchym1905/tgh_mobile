// ignore: file_names
import 'package:tgh_mobile/configs.dart';

String pfpUrl(String competitorId) {
  return '${AppConfig.googleCloudBaseUrl}/$competitorId/img/profile-picture';
}

String bannerUrl(String competitorId) {
  return '${AppConfig.googleCloudBaseUrl}/$competitorId/img/banner';
}
