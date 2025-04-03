// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'competitor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CompetitorImpl _$$CompetitorImplFromJson(Map<String, dynamic> json) =>
    _$CompetitorImpl(
      id: json['_id'] as String,
      discordtag: json['discord_tag'] as String?,
      alias: json['alias'] as String,
      uid: (json['account_uid'] as num?)?.toInt(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      lastModifiedBy: json['last_modified_by'] as String?,
      dpser: json['dpser'] as bool?,
      speedrunner: json['speedrunner'] as bool?,
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$CompetitorImplToJson(_$CompetitorImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'discord_tag': instance.discordtag,
      'alias': instance.alias,
      'account_uid': instance.uid,
      'created_at': instance.createdAt?.toIso8601String(),
      'last_modified_by': instance.lastModifiedBy,
      'dpser': instance.dpser,
      'speedrunner': instance.speedrunner,
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
