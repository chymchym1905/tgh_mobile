// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dps.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DPSImpl _$$DPSImplFromJson(Map<String, dynamic> json) => _$DPSImpl(
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
    );

Map<String, dynamic> _$$DPSImplToJson(_$DPSImpl instance) => <String, dynamic>{
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
    };
