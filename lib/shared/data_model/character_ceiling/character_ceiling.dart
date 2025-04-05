import 'package:freezed_annotation/freezed_annotation.dart';

part 'character_ceiling.freezed.dart';
part 'character_ceiling.g.dart';

@freezed
class CharacterCeiling with _$CharacterCeiling {
  const factory CharacterCeiling({
    @JsonKey(name: '_id') required String id,
    @JsonKey(name: 'character') required String character,
    @JsonKey(name: 'character_element') String? characterElement,
    @JsonKey(name: 'created_at') required DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @JsonKey(name: 'last_modified_by') String? lastModifiedBy,
    @JsonKey(name: 'normal_attack') num? normalAtk,
    @JsonKey(name: 'charged_attack') num? chargdAtk,
    @JsonKey(name: 'plunge_attack') num? plungeAtk,
    @JsonKey(name: 'elemental_skill') num? skill,
    @JsonKey(name: 'elemental_burst') num? burst,
    @JsonKey(name: 'a1_talent') num? a1,
    @JsonKey(name: 'a4_talent') num? a4,
  }) = _CharacterCeiling;

  factory CharacterCeiling.fromJson(Map<String, dynamic> json) => _$CharacterCeilingFromJson(json);
}
