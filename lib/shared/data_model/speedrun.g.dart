// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speedrun.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SpeedrunImpl _$$SpeedrunImplFromJson(Map<String, dynamic> json) =>
    _$SpeedrunImpl(
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

Map<String, dynamic> _$$SpeedrunImplToJson(_$SpeedrunImpl instance) =>
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
