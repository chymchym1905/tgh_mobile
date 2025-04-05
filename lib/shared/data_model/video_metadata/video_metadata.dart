import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_metadata.freezed.dart';
part 'video_metadata.g.dart';

@freezed
class VideoMetadata with _$VideoMetadata {
  const factory VideoMetadata({
    required String title,
    required String thumbnail,
    required String views,
    required int duration,
  }) = _VideoMetadata;

  factory VideoMetadata.fromJson(Map<String, dynamic> json) => _$VideoMetadataFromJson(json);
}
