// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'character_ceiling.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CharacterCeiling _$CharacterCeilingFromJson(Map<String, dynamic> json) {
  return _CharacterCeiling.fromJson(json);
}

/// @nodoc
mixin _$CharacterCeiling {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'character')
  String get character => throw _privateConstructorUsedError;
  @JsonKey(name: 'character_element')
  String? get characterElement => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_modified_by')
  String? get lastModifiedBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'normal_attack')
  num? get normalAtk => throw _privateConstructorUsedError;
  @JsonKey(name: 'charged_attack')
  num? get chargdAtk => throw _privateConstructorUsedError;
  @JsonKey(name: 'plunge_attack')
  num? get plungeAtk => throw _privateConstructorUsedError;
  @JsonKey(name: 'elemental_skill')
  num? get skill => throw _privateConstructorUsedError;
  @JsonKey(name: 'elemental_burst')
  num? get burst => throw _privateConstructorUsedError;
  @JsonKey(name: 'a1_talent')
  num? get a1 => throw _privateConstructorUsedError;
  @JsonKey(name: 'a4_talent')
  num? get a4 => throw _privateConstructorUsedError;

  /// Serializes this CharacterCeiling to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CharacterCeiling
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CharacterCeilingCopyWith<CharacterCeiling> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CharacterCeilingCopyWith<$Res> {
  factory $CharacterCeilingCopyWith(
          CharacterCeiling value, $Res Function(CharacterCeiling) then) =
      _$CharacterCeilingCopyWithImpl<$Res, CharacterCeiling>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      @JsonKey(name: 'character') String character,
      @JsonKey(name: 'character_element') String? characterElement,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      @JsonKey(name: 'last_modified_by') String? lastModifiedBy,
      @JsonKey(name: 'normal_attack') num? normalAtk,
      @JsonKey(name: 'charged_attack') num? chargdAtk,
      @JsonKey(name: 'plunge_attack') num? plungeAtk,
      @JsonKey(name: 'elemental_skill') num? skill,
      @JsonKey(name: 'elemental_burst') num? burst,
      @JsonKey(name: 'a1_talent') num? a1,
      @JsonKey(name: 'a4_talent') num? a4});
}

/// @nodoc
class _$CharacterCeilingCopyWithImpl<$Res, $Val extends CharacterCeiling>
    implements $CharacterCeilingCopyWith<$Res> {
  _$CharacterCeilingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CharacterCeiling
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? character = null,
    Object? characterElement = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? lastModifiedBy = freezed,
    Object? normalAtk = freezed,
    Object? chargdAtk = freezed,
    Object? plungeAtk = freezed,
    Object? skill = freezed,
    Object? burst = freezed,
    Object? a1 = freezed,
    Object? a4 = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      character: null == character
          ? _value.character
          : character // ignore: cast_nullable_to_non_nullable
              as String,
      characterElement: freezed == characterElement
          ? _value.characterElement
          : characterElement // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastModifiedBy: freezed == lastModifiedBy
          ? _value.lastModifiedBy
          : lastModifiedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      normalAtk: freezed == normalAtk
          ? _value.normalAtk
          : normalAtk // ignore: cast_nullable_to_non_nullable
              as num?,
      chargdAtk: freezed == chargdAtk
          ? _value.chargdAtk
          : chargdAtk // ignore: cast_nullable_to_non_nullable
              as num?,
      plungeAtk: freezed == plungeAtk
          ? _value.plungeAtk
          : plungeAtk // ignore: cast_nullable_to_non_nullable
              as num?,
      skill: freezed == skill
          ? _value.skill
          : skill // ignore: cast_nullable_to_non_nullable
              as num?,
      burst: freezed == burst
          ? _value.burst
          : burst // ignore: cast_nullable_to_non_nullable
              as num?,
      a1: freezed == a1
          ? _value.a1
          : a1 // ignore: cast_nullable_to_non_nullable
              as num?,
      a4: freezed == a4
          ? _value.a4
          : a4 // ignore: cast_nullable_to_non_nullable
              as num?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CharacterCeilingImplCopyWith<$Res>
    implements $CharacterCeilingCopyWith<$Res> {
  factory _$$CharacterCeilingImplCopyWith(_$CharacterCeilingImpl value,
          $Res Function(_$CharacterCeilingImpl) then) =
      __$$CharacterCeilingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      @JsonKey(name: 'character') String character,
      @JsonKey(name: 'character_element') String? characterElement,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      @JsonKey(name: 'last_modified_by') String? lastModifiedBy,
      @JsonKey(name: 'normal_attack') num? normalAtk,
      @JsonKey(name: 'charged_attack') num? chargdAtk,
      @JsonKey(name: 'plunge_attack') num? plungeAtk,
      @JsonKey(name: 'elemental_skill') num? skill,
      @JsonKey(name: 'elemental_burst') num? burst,
      @JsonKey(name: 'a1_talent') num? a1,
      @JsonKey(name: 'a4_talent') num? a4});
}

/// @nodoc
class __$$CharacterCeilingImplCopyWithImpl<$Res>
    extends _$CharacterCeilingCopyWithImpl<$Res, _$CharacterCeilingImpl>
    implements _$$CharacterCeilingImplCopyWith<$Res> {
  __$$CharacterCeilingImplCopyWithImpl(_$CharacterCeilingImpl _value,
      $Res Function(_$CharacterCeilingImpl) _then)
      : super(_value, _then);

  /// Create a copy of CharacterCeiling
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? character = null,
    Object? characterElement = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? lastModifiedBy = freezed,
    Object? normalAtk = freezed,
    Object? chargdAtk = freezed,
    Object? plungeAtk = freezed,
    Object? skill = freezed,
    Object? burst = freezed,
    Object? a1 = freezed,
    Object? a4 = freezed,
  }) {
    return _then(_$CharacterCeilingImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      character: null == character
          ? _value.character
          : character // ignore: cast_nullable_to_non_nullable
              as String,
      characterElement: freezed == characterElement
          ? _value.characterElement
          : characterElement // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastModifiedBy: freezed == lastModifiedBy
          ? _value.lastModifiedBy
          : lastModifiedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      normalAtk: freezed == normalAtk
          ? _value.normalAtk
          : normalAtk // ignore: cast_nullable_to_non_nullable
              as num?,
      chargdAtk: freezed == chargdAtk
          ? _value.chargdAtk
          : chargdAtk // ignore: cast_nullable_to_non_nullable
              as num?,
      plungeAtk: freezed == plungeAtk
          ? _value.plungeAtk
          : plungeAtk // ignore: cast_nullable_to_non_nullable
              as num?,
      skill: freezed == skill
          ? _value.skill
          : skill // ignore: cast_nullable_to_non_nullable
              as num?,
      burst: freezed == burst
          ? _value.burst
          : burst // ignore: cast_nullable_to_non_nullable
              as num?,
      a1: freezed == a1
          ? _value.a1
          : a1 // ignore: cast_nullable_to_non_nullable
              as num?,
      a4: freezed == a4
          ? _value.a4
          : a4 // ignore: cast_nullable_to_non_nullable
              as num?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CharacterCeilingImpl implements _CharacterCeiling {
  const _$CharacterCeilingImpl(
      {@JsonKey(name: '_id') required this.id,
      @JsonKey(name: 'character') required this.character,
      @JsonKey(name: 'character_element') this.characterElement,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      @JsonKey(name: 'last_modified_by') this.lastModifiedBy,
      @JsonKey(name: 'normal_attack') this.normalAtk,
      @JsonKey(name: 'charged_attack') this.chargdAtk,
      @JsonKey(name: 'plunge_attack') this.plungeAtk,
      @JsonKey(name: 'elemental_skill') this.skill,
      @JsonKey(name: 'elemental_burst') this.burst,
      @JsonKey(name: 'a1_talent') this.a1,
      @JsonKey(name: 'a4_talent') this.a4});

  factory _$CharacterCeilingImpl.fromJson(Map<String, dynamic> json) =>
      _$$CharacterCeilingImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  @JsonKey(name: 'character')
  final String character;
  @override
  @JsonKey(name: 'character_element')
  final String? characterElement;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @override
  @JsonKey(name: 'last_modified_by')
  final String? lastModifiedBy;
  @override
  @JsonKey(name: 'normal_attack')
  final num? normalAtk;
  @override
  @JsonKey(name: 'charged_attack')
  final num? chargdAtk;
  @override
  @JsonKey(name: 'plunge_attack')
  final num? plungeAtk;
  @override
  @JsonKey(name: 'elemental_skill')
  final num? skill;
  @override
  @JsonKey(name: 'elemental_burst')
  final num? burst;
  @override
  @JsonKey(name: 'a1_talent')
  final num? a1;
  @override
  @JsonKey(name: 'a4_talent')
  final num? a4;

  @override
  String toString() {
    return 'CharacterCeiling(id: $id, character: $character, characterElement: $characterElement, createdAt: $createdAt, updatedAt: $updatedAt, lastModifiedBy: $lastModifiedBy, normalAtk: $normalAtk, chargdAtk: $chargdAtk, plungeAtk: $plungeAtk, skill: $skill, burst: $burst, a1: $a1, a4: $a4)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CharacterCeilingImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.character, character) ||
                other.character == character) &&
            (identical(other.characterElement, characterElement) ||
                other.characterElement == characterElement) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.lastModifiedBy, lastModifiedBy) ||
                other.lastModifiedBy == lastModifiedBy) &&
            (identical(other.normalAtk, normalAtk) ||
                other.normalAtk == normalAtk) &&
            (identical(other.chargdAtk, chargdAtk) ||
                other.chargdAtk == chargdAtk) &&
            (identical(other.plungeAtk, plungeAtk) ||
                other.plungeAtk == plungeAtk) &&
            (identical(other.skill, skill) || other.skill == skill) &&
            (identical(other.burst, burst) || other.burst == burst) &&
            (identical(other.a1, a1) || other.a1 == a1) &&
            (identical(other.a4, a4) || other.a4 == a4));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      character,
      characterElement,
      createdAt,
      updatedAt,
      lastModifiedBy,
      normalAtk,
      chargdAtk,
      plungeAtk,
      skill,
      burst,
      a1,
      a4);

  /// Create a copy of CharacterCeiling
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CharacterCeilingImplCopyWith<_$CharacterCeilingImpl> get copyWith =>
      __$$CharacterCeilingImplCopyWithImpl<_$CharacterCeilingImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CharacterCeilingImplToJson(
      this,
    );
  }
}

abstract class _CharacterCeiling implements CharacterCeiling {
  const factory _CharacterCeiling(
      {@JsonKey(name: '_id') required final String id,
      @JsonKey(name: 'character') required final String character,
      @JsonKey(name: 'character_element') final String? characterElement,
      @JsonKey(name: 'created_at') required final DateTime? createdAt,
      @JsonKey(name: 'updated_at') final DateTime? updatedAt,
      @JsonKey(name: 'last_modified_by') final String? lastModifiedBy,
      @JsonKey(name: 'normal_attack') final num? normalAtk,
      @JsonKey(name: 'charged_attack') final num? chargdAtk,
      @JsonKey(name: 'plunge_attack') final num? plungeAtk,
      @JsonKey(name: 'elemental_skill') final num? skill,
      @JsonKey(name: 'elemental_burst') final num? burst,
      @JsonKey(name: 'a1_talent') final num? a1,
      @JsonKey(name: 'a4_talent') final num? a4}) = _$CharacterCeilingImpl;

  factory _CharacterCeiling.fromJson(Map<String, dynamic> json) =
      _$CharacterCeilingImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  @JsonKey(name: 'character')
  String get character;
  @override
  @JsonKey(name: 'character_element')
  String? get characterElement;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;
  @override
  @JsonKey(name: 'last_modified_by')
  String? get lastModifiedBy;
  @override
  @JsonKey(name: 'normal_attack')
  num? get normalAtk;
  @override
  @JsonKey(name: 'charged_attack')
  num? get chargdAtk;
  @override
  @JsonKey(name: 'plunge_attack')
  num? get plungeAtk;
  @override
  @JsonKey(name: 'elemental_skill')
  num? get skill;
  @override
  @JsonKey(name: 'elemental_burst')
  num? get burst;
  @override
  @JsonKey(name: 'a1_talent')
  num? get a1;
  @override
  @JsonKey(name: 'a4_talent')
  num? get a4;

  /// Create a copy of CharacterCeiling
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CharacterCeilingImplCopyWith<_$CharacterCeilingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
