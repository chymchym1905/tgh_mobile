import 'package:freezed_annotation/freezed_annotation.dart';
import 'character_ceiling.dart';
import 'competitor.dart';
import 'dps.dart';
import 'speedrun.dart';

part 'feed.freezed.dart';
part 'feed.g.dart';

@freezed
class Feed with _$Feed {
  @JsonSerializable(explicitToJson: true)
  @Implements<DPSProperties>()
  const factory Feed.dps({
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
    required String notes,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'last_modified_by') String? lastModifiedBy,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    String? accountSnapshot,
    @JsonKey(name: 'video_metadata') Map<String, dynamic>? videoMetadata,
  }) = DPSFeed;

  @JsonSerializable(explicitToJson: true)
  @Implements<SpeedrunProperties>()
  const factory Feed.speedrun({
    @JsonKey(name: '_id') required String id,
    required Competitor competitor,
    @JsonKey(name: 'team_1') required List<String?> team1,
    @JsonKey(name: 'team_2') List<String?>? team2,
    required String region,
    @JsonKey(name: 'game_version') required String gameVersion,
    @JsonKey(name: 'abyss_version') String? abyssVersion,
    @JsonKey(name: 'video_link') required String videolink,
    required bool approved,
    @JsonKey(name: 'speedrun_category') required String speedrunCategory,
    @JsonKey(name: 'speedrun_subcategory') String? speedrunSubcategory,
    required String notes,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'last_modified_by') String? lastModifiedBy,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    required int time,
    String? accountSnapshot,
    List<String>? tags,
  }) = SpeedrunFeed;

  factory Feed.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('speedrun_category')) {
      return Feed.speedrun(
        id: json['_id'] as String,
        competitor: Competitor.fromJson(json['competitor'] as Map<String, dynamic>),
        team1: List<String?>.from(json['team_1'] as List),
        team2: json['team_2'] != null ? List<String?>.from(json['team_2'] as List) : null,
        region: json['region'] as String,
        gameVersion: json['game_version'] as String,
        abyssVersion: json['abyss_version'] as String?,
        videolink: json['video_link'] as String,
        approved: json['approved'] as bool,
        speedrunCategory: json['speedrun_category'] as String,
        speedrunSubcategory: json['speedrun_subcategory'] as String?,
        notes: json['notes'] as String,
        createdAt: json['created_at'] != null ? DateTime.parse(json['created_at'] as String) : null,
        lastModifiedBy: json['last_modified_by'] as String?,
        updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at'] as String) : null,
        time: json['time'] as int,
        accountSnapshot: json['account_snapshot'] as String?,
        tags: json['tags'] != null ? List<String>.from(json['tags'] as List) : null,
      );
    } else {
      return Feed.dps(
        id: json['_id'] as String,
        competitor: Competitor.fromJson(json['competitor'] as Map<String, dynamic>),
        team: List<String?>.from(json['team'] as List<String?>),
        dpsCharacter: json['dps_character'] as String,
        dpsCharElement: json['dps_character_element'] as String?,
        characterCeiling: CharacterCeiling.fromJson(json['character_ceiling'] as Map<String, dynamic>),
        damageDealt: json['damage_dealt'] as int,
        attackType: json['attack_type'] as String,
        dpsCategory: json['dps_category'] as String,
        enemy: json['enemy'] as String,
        enemyLevel: json['enemy_lv'] as int,
        stunned: json['stunned'] as bool,
        food: json['food_used'] as bool,
        region: json['region'] as String,
        gameVersion: json['game_version'] as String,
        videolink: json['video_link'] as String,
        approved: json['approved'] as bool,
        notes: json['notes'] as String,
        videoMetadata: json['video_metadata'] as Map<String, dynamic>?,
      );
    }
  }
}
