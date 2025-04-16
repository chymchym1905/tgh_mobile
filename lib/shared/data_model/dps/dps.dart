import 'package:freezed_annotation/freezed_annotation.dart';
import '../character_ceiling/character_ceiling.dart';
import '../competitor/competitor.dart';

part 'dps.freezed.dart';
part 'dps.g.dart';

mixin DPSProperties {
  String get id;
  Competitor get competitor;
  List<String?> get team;
  String get dpsCharacter;
  String? get dpsCharElement;
  CharacterCeiling get characterCeiling;
  int get damageDealt;
  String get attackType;
  String get dpsCategory;
  String get enemy;
  int get enemyLevel;
  bool get stunned;
  bool get food;
  String get region;
  String get gameVersion;
  String? get abyssVersion;
  String? get abyssFloor;
  String get videolink;
  bool get approved;
  String? get notes;
  DateTime? get createdAt;
  DateTime? get updatedAt;
  String? get lastModifiedBy;
  String? get accountSnapshot;
}

@freezed
class DPS with _$DPS, DPSProperties {
  @JsonSerializable(explicitToJson: true)
  const factory DPS({
    @JsonKey(name: '_id') required String id,
    required Competitor competitor,
    @JsonKey(name: 'team') required List<String?> team,
    @JsonKey(name: 'dps_character') required String dpsCharacter,
    @JsonKey(name: 'dps_character_element') String? dpsCharElement,
    @JsonKey(name: 'character_ceiling') required CharacterCeiling characterCeiling,
    @JsonKey(name: 'damage_dealt') required int damageDealt,
    @JsonKey(name: 'attack_type') required String attackType,
    @JsonKey(name: 'dps_category') required String dpsCategory,
    required String enemy,
    @JsonKey(name: 'enemy_lv') required int enemyLevel,
    required bool stunned,
    @JsonKey(name: 'food_used') required bool food,
    required String region,
    @JsonKey(name: 'game_version') required String gameVersion,
    @JsonKey(name: 'abyss_version') String? abyssVersion,
    @JsonKey(name: 'abyss_floor') String? abyssFloor,
    @JsonKey(name: 'video_link') required String videolink,
    required bool approved,
    @JsonKey(name: 'notes') String? notes,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'last_modified_by') String? lastModifiedBy,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    String? accountSnapshot,
  }) = _DPS;

  factory DPS.fromJson(Map<String, dynamic> json) => _$DPSFromJson(json);
}
