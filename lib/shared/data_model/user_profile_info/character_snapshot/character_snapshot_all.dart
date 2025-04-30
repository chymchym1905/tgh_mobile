import 'package:freezed_annotation/freezed_annotation.dart';

part 'character_snapshot_all.freezed.dart';
part 'character_snapshot_all.g.dart';

@freezed
abstract class CharacterSnapshot with _$CharacterSnapshot {
  const factory CharacterSnapshot({
    @JsonKey(name: '_id') required String id,
    @JsonKey(name: 'account_snapshot') required String accountSnapshot,
    @JsonKey(name: 'competitor_id') String? competitorId,
    required String name,
    required WeaponDetail weapon,
    required double health,
    required double attack,
    required double defense,
    required String element,
    @JsonKey(name: 'normal_attack_level') int? normalAttackLevel,
    @JsonKey(name: 'elemental_skill_level') int? elementalSkillLevel,
    @JsonKey(name: 'elemental_burst_level') int? elementalBurstLevel,
    @JsonKey(name: 'elemental_mastery') double? elementalMastery,
    @JsonKey(name: 'critical_strike_rate') double? criticalStrikeRate,
    @JsonKey(name: 'critical_strike_multiplier') double? criticalStrikeMultiplier,
    @JsonKey(name: 'energy_recharge') double? energyRecharge,
    @JsonKey(name: 'physical_damage_bonus') double? physicalDamageBonus,
    @JsonKey(name: 'pyro_damage_bonus') double? pyroDamageBonus,
    @JsonKey(name: 'geo_damage_bonus') double? geoDamageBonus,
    @JsonKey(name: 'dendro_damage_bonus') double? dendroDamageBonus,
    @JsonKey(name: 'cryo_damage_bonus') double? cryoDamageBonus,
    @JsonKey(name: 'electro_damage_bonus') double? electroDamageBonus,
    @JsonKey(name: 'anemo_damage_bonus') double? anemoDamageBonus,
    @JsonKey(name: 'hydro_damage_bonus') double? hydroDamageBonus,
    @JsonKey(name: 'healing_bonus') double? healingBonus,
    List<ArtifactDetail>? artifacts,
    @JsonKey(name: 'level') int? level,
    @JsonKey(name: 'constellation') int? constellation,
    @JsonKey(name: 'friendship_level') int? friendshipLevel,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'last_modified_by') String? lastModifiedBy,
  }) = _CharacterSnapshot;

  factory CharacterSnapshot.fromJson(Map<String, Object?> json) => _$CharacterSnapshotFromJson(json);
}

@freezed
abstract class WeaponDetail with _$WeaponDetail {
  const factory WeaponDetail({
    String? weaponName,
    int? level,
    int? refine,
  }) = _WeaponDetail;

  factory WeaponDetail.fromJson(Map<String, Object?> json) => _$WeaponDetailFromJson(json);
}

@freezed
abstract class ArtifactDetail with _$ArtifactDetail {
  const factory ArtifactDetail({
    int? level,
    int? rarity,
    String? slot,
    String? setProperty,
    String? mainStatType,
    int? mainStatValue,
    List<Substats>? substats,
  }) = _ArtifactDetail;

  factory ArtifactDetail.fromJson(Map<String, Object?> json) => _$ArtifactDetailFromJson(json);
}

@freezed
abstract class Substats with _$Substats {
  const factory Substats({
    required double value,
    required String type,
  }) = _Substats;

  factory Substats.fromJson(Map<String, Object?> json) => _$SubstatsFromJson(json);
}
