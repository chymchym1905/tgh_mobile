import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tgh_mobile/imports.dart';

part 'dps.freezed.dart';
part 'dps.g.dart';

@freezed
class DpsSubmit with _$DpsSubmit {
  @JsonSerializable(explicitToJson: true, includeIfNull: false)
  const factory DpsSubmit({
    @JsonKey(name: 'account_uid') required String accountUid,
    required String alias,
    @JsonKey(name: 'discord_tag') required String discordTag,
    @JsonKey(name: 'game_version') required String gameVersion,
    @JsonKey(name: 'abyss_version') String? abyssVersion,
    @JsonKey(name: 'abyss_floor') String? abyssFloor,
    String? domain,
    String? event,
    @Default('') String notes,
    required String region,
    @JsonKey(name: 'dps_category') required String dpsCategory,
    @JsonKey(name: 'enemy') required String enemy,
    @JsonKey(name: 'enemy_lv') required int enemyLevel,
    @Default(false) bool stunned,
    @JsonKey(name: 'food_used') @Default(false) bool food,
    @JsonKey(name: 'attack_type') required String attackType,
    @JsonKey(name: 'dps_character') required String dpsCharacter,
    @JsonKey(name: 'video_link') required String videolink,
    @JsonKey(name: 'damage_dealt') required int damageDealt,
    @JsonKey(name: 'team') @Default([]) List<String?>? team1,
    @Default(false) bool approved,
    @JsonKey(name: 'create_snapshot') @Default(true) bool createSnapshot,
    @JsonKey(name: 'deleted_at') DateTime? deletedAt,
  }) = _DpsSubmit;

  factory DpsSubmit.fromJson(Map<String, dynamic> json) => _$DpsSubmitFromJson(json);
}

@freezed
class DpsSubmitResponse with _$DpsSubmitResponse {
  @JsonSerializable(explicitToJson: true, includeIfNull: false)
  const factory DpsSubmitResponse({
    @JsonKey(name: '_id') required String id,
    required String competitor,
    @JsonKey(name: 'team') @Default([]) List<String?>? team1,
    required String region,
    @JsonKey(name: 'game_version') required String gameVersion,
    @JsonKey(name: 'abyss_version') String? abyssVersion,
    @JsonKey(name: 'abyss_floor') String? abyssFloor,
    String? domain,
    String? event,
    required bool approved,
    @JsonKey(name: 'dps_category') required String dpsCategory,
    @JsonKey(name: 'enemy') required String enemy,
    @JsonKey(name: 'enemy_lv') required int enemyLevel,
    @Default(false) bool stunned,
    @JsonKey(name: 'food_used') @Default(false) bool food,
    @JsonKey(name: 'attack_type') required String attackType,
    @JsonKey(name: 'dps_character') required String dpsCharacter,
    @JsonKey(name: 'dps_character_element') required String dpsCharacterElement,
    @JsonKey(name: 'video_link') required String videolink,
    @JsonKey(name: 'damage_dealt') required int damageDealt,
    @JsonKey(name: 'character_ceiling') String? characterCeiling,
    @JsonKey(name: 'notes') String? notes,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'last_modified_by') String? lastModifiedBy,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    AccountSnapshot? accountSnapshot,
    List<String>? tags,
  }) = _DpsSubmitResponse;

  factory DpsSubmitResponse.fromJson(Map<String, dynamic> json) => _$DpsSubmitResponseFromJson(json);
}
