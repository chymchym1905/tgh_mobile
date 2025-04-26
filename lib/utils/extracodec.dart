// Class to hold video navigation data
import 'dart:convert';

import 'package:tgh_mobile/imports.dart';

/// Unused
class VideoRouteData {
  final VideoMetadata? metadata;
  final List<VideoMetadata> relatedVideos;

  const VideoRouteData({
    required this.metadata,
    this.relatedVideos = const [],
  });
}

class MyExtraCodec extends Codec<Object?, Object?> {
  /// Create a codec.
  const MyExtraCodec();
  @override
  Converter<Object?, Object?> get decoder => const _MyExtraDecoder();

  @override
  Converter<Object?, Object?> get encoder => const _MyExtraEncoder();
}

class _MyExtraDecoder extends Converter<Object?, Object?> {
  const _MyExtraDecoder();
  @override
  Object? convert(Object? input) {
    if (input == null) {
      return null;
    }
    final List<Object?> inputAsList = input as List<Object?>;
    if (inputAsList[0] == 'VideoRouteData') {
      return VideoRouteData(
          metadata: inputAsList[1] as VideoMetadata?, relatedVideos: inputAsList[2] as List<VideoMetadata>);
    }
    throw FormatException('Unable to parse input: $input');
  }
}

class _MyExtraEncoder extends Converter<Object?, Object?> {
  const _MyExtraEncoder();
  @override
  Object? convert(Object? input) {
    if (input == null) {
      return null;
    }
    switch (input) {
      case VideoRouteData _:
        return <Object?>['VideoRouteData', input.metadata, input.relatedVideos];
      default:
        throw FormatException('Cannot encode type ${input.runtimeType}');
    }
  }
}
