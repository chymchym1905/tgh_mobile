// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_ceiling.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CharacterCeilingImpl _$$CharacterCeilingImplFromJson(
        Map<String, dynamic> json) =>
    _$CharacterCeilingImpl(
      id: json['_id'] as String,
      character: json['character'] as String,
      characterElement: json['character_element'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      lastModifiedBy: json['last_modified_by'] as String?,
      normalAtk: json['normal_attack'] as num?,
      chargdAtk: json['charged_attack'] as num?,
      plungeAtk: json['plunge_attack'] as num?,
      skill: json['elemental_skill'] as num?,
      burst: json['elemental_burst'] as num?,
      a1: json['a1_talent'] as num?,
      a4: json['a4_talent'] as num?,
    );

Map<String, dynamic> _$$CharacterCeilingImplToJson(
        _$CharacterCeilingImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'character': instance.character,
      'character_element': instance.characterElement,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'last_modified_by': instance.lastModifiedBy,
      'normal_attack': instance.normalAtk,
      'charged_attack': instance.chargdAtk,
      'plunge_attack': instance.plungeAtk,
      'elemental_skill': instance.skill,
      'elemental_burst': instance.burst,
      'a1_talent': instance.a1,
      'a4_talent': instance.a4,
    };
