import '../constant/filter constants.dart';

String uidToRegion(String uid) {
  if (uid.startsWith('6')) {
    return REGIONS[0];
  } else if (uid.startsWith('7')) {
    return REGIONS[2];
  } else if (uid.startsWith('9')) {
    return REGIONS[4];
  } else if (uid.startsWith('8')) {
    return REGIONS[3];
  } else if (uid.startsWith('18')) {
    if (uid.length == 10) {
      return REGIONS[3];
    } else {
      return REGIONS[1];
    }
  } else if (uid.startsWith('1') || uid.startsWith('2') || uid.startsWith('3') || uid.startsWith('5')) {
    return REGIONS[1];
  } else {
    return REGIONS[0];
  }
}
