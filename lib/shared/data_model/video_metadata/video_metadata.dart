import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_metadata.freezed.dart';
part 'video_metadata.g.dart';

String _viewsToString(dynamic views) {
  if (views is int) {
    if (views >= 1000000) {
      return '${(views / 1000000).toStringAsFixed(1)}M';
    } else if (views >= 1000) {
      return '${(views / 1000).toStringAsFixed(1)}K';
    }
    return views.toString();
  } else if (views is String) {
    // Try to parse string as number if possible
    try {
      final numViews = int.parse(views);
      return _viewsToString(numViews);
    } catch (_) {
      // If parsing fails, return the original string
      return views;
    }
  }
  return '0'; // Default case
}

@freezed
class VideoMetadata with _$VideoMetadata {
  const factory VideoMetadata({
    required String title,
    required String thumbnail,
    @JsonKey(name: 'views', fromJson: _viewsToString) required dynamic views,
    required int duration,
  }) = _VideoMetadata;

  factory VideoMetadata.fromJson(Map<String, dynamic> json) => _$VideoMetadataFromJson(json);
}
