import 'package:tgh_mobile/shared/data_model/feed/feed.dart';

import '../constant/responsivewidth.dart';

String views(dynamic views) {
  if (views == null) return 'null';
  return '$views views';
}

String formatDate(DateTime? date) {
  if (date == null) return "";

  final now = DateTime.now();
  final difference = now.difference(date);

  if (difference.inDays > 365) {
    final years = (difference.inDays / 365).floor();
    return '$years ${years == 1 ? 'year' : 'years'} ago';
  } else if (difference.inDays > 30) {
    final months = (difference.inDays / 30).floor();
    return '$months ${months == 1 ? 'month' : 'months'} ago';
  } else if (difference.inDays > 0) {
    return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
  } else if (difference.inHours > 0) {
    return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
  } else if (difference.inSeconds > 0) {
    return '${difference.inSeconds} ${difference.inSeconds == 1 ? 'second' : 'seconds'} ago';
  } else {
    return 'just now';
  }
}

String parseTime(int? time) {
  if (time == null) {
    return '';
  }
  var realtime = time / 1000;
  var formattedTime = '${realtime}s';
  return formattedTime;
}

String feedType(Feed feeditem) {
  return feeditem.map(
    speedrun: (speedrun) => parseTime(speedrun.time),
    dps: (dps) => dps.damageDealt.toString(),
  );
}

double aspectRatio(double cardWidth) {
  const double minAspectRatio = 0.7; // For very small screens
  const double normalAspectRatio = 4 / 3; // When screenWidth >= 300
  double thresholdWidth = kMaxWidthMobile.toDouble(); // After this width, aspect ratio stays constant

  if (cardWidth < thresholdWidth) {
    // Linearly interpolate between minAspectRatio and normalAspectRatio
    return minAspectRatio + (cardWidth / thresholdWidth) * (normalAspectRatio - minAspectRatio);
  } else {
    return normalAspectRatio;
  }
}

double calculateCardWidth(double screenWidth, int crossAxisCount, double crossAxisSpacing) {
  double totalSpacing = (crossAxisCount - 1) * crossAxisSpacing;
  return (screenWidth - totalSpacing) / crossAxisCount;
}
