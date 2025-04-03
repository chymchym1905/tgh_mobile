// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DPSFeedImpl _$$DPSFeedImplFromJson(Map<String, dynamic> json) =>
    _$DPSFeedImpl(
      id: json['_id'] as String,
      competitor:
          Competitor.fromJson(json['competitor'] as Map<String, dynamic>),
      team: (json['team'] as List<dynamic>).map((e) => e as String?).toList(),
      dpsCharacter: json['dps_character'] as String,
      dpsCharElement: json['dps_character_element'] as String?,
      characterCeiling: CharacterCeiling.fromJson(
          json['character_ceiling'] as Map<String, dynamic>),
      damageDealt: (json['damage_dealt'] as num).toInt(),
      attackType: json['attack_type'] as String,
      dpsCategory: json['dps_category'] as String,
      enemy: json['enemy'] as String,
      enemyLevel: (json['enemy_lv'] as num).toInt(),
      stunned: json['stunned'] as bool,
      food: json['food_used'] as bool,
      region: json['region'] as String,
      gameVersion: json['game_version'] as String,
      abyssVersion: json['abyss_version'] as String?,
      abyssFloor: json['abyss_floor'] as String?,
      videolink: json['video_link'] as String,
      approved: json['approved'] as bool,
      notes: json['notes'] as String,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      lastModifiedBy: json['last_modified_by'] as String?,
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      accountSnapshot: json['accountSnapshot'] as String?,
      videoMetadata: json['video_metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$DPSFeedImplToJson(_$DPSFeedImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'competitor': instance.competitor.toJson(),
      'team': instance.team,
      'dps_character': instance.dpsCharacter,
      'dps_character_element': instance.dpsCharElement,
      'character_ceiling': instance.characterCeiling.toJson(),
      'damage_dealt': instance.damageDealt,
      'attack_type': instance.attackType,
      'dps_category': instance.dpsCategory,
      'enemy': instance.enemy,
      'enemy_lv': instance.enemyLevel,
      'stunned': instance.stunned,
      'food_used': instance.food,
      'region': instance.region,
      'game_version': instance.gameVersion,
      'abyss_version': instance.abyssVersion,
      'abyss_floor': instance.abyssFloor,
      'video_link': instance.videolink,
      'approved': instance.approved,
      'notes': instance.notes,
      'created_at': instance.createdAt?.toIso8601String(),
      'last_modified_by': instance.lastModifiedBy,
      'updated_at': instance.updatedAt?.toIso8601String(),
      'accountSnapshot': instance.accountSnapshot,
      'video_metadata': instance.videoMetadata,
    };

_$SpeedrunFeedImpl _$$SpeedrunFeedImplFromJson(Map<String, dynamic> json) =>
    _$SpeedrunFeedImpl(
      id: json['_id'] as String,
      competitor:
          Competitor.fromJson(json['competitor'] as Map<String, dynamic>),
      team1:
          (json['team_1'] as List<dynamic>).map((e) => e as String?).toList(),
      team2:
          (json['team_2'] as List<dynamic>?)?.map((e) => e as String?).toList(),
      region: json['region'] as String,
      gameVersion: json['game_version'] as String,
      abyssVersion: json['abyss_version'] as String?,
      videolink: json['video_link'] as String,
      approved: json['approved'] as bool,
      speedrunCategory: json['speedrun_category'] as String,
      speedrunSubcategory: json['speedrun_subcategory'] as String?,
      notes: json['notes'] as String,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      lastModifiedBy: json['last_modified_by'] as String?,
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      time: (json['time'] as num).toInt(),
      accountSnapshot: json['accountSnapshot'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$SpeedrunFeedImplToJson(_$SpeedrunFeedImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'competitor': instance.competitor.toJson(),
      'team_1': instance.team1,
      'team_2': instance.team2,
      'region': instance.region,
      'game_version': instance.gameVersion,
      'abyss_version': instance.abyssVersion,
      'video_link': instance.videolink,
      'approved': instance.approved,
      'speedrun_category': instance.speedrunCategory,
      'speedrun_subcategory': instance.speedrunSubcategory,
      'notes': instance.notes,
      'created_at': instance.createdAt?.toIso8601String(),
      'last_modified_by': instance.lastModifiedBy,
      'updated_at': instance.updatedAt?.toIso8601String(),
      'time': instance.time,
      'accountSnapshot': instance.accountSnapshot,
      'tags': instance.tags,
    };
