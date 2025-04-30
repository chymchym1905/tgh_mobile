import 'package:freezed_annotation/freezed_annotation.dart';

part 'character_usage.freezed.dart';
part 'character_usage.g.dart';

@freezed
class CharacterUsage with _$CharacterUsage {
  const factory CharacterUsage({
    required String character,
    required int frequency,
  }) = _CharacterUsage;

  factory CharacterUsage.fromJson(Map<String, dynamic> json) => _$CharacterUsageFromJson(json);
}
