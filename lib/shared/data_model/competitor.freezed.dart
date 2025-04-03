// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'competitor.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Competitor _$CompetitorFromJson(Map<String, dynamic> json) {
  return _Competitor.fromJson(json);
}

/// @nodoc
mixin _$Competitor {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'discord_tag')
  String? get discordtag => throw _privateConstructorUsedError;
  String get alias => throw _privateConstructorUsedError;
  @JsonKey(name: 'account_uid')
  int? get uid => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_modified_by')
  String? get lastModifiedBy => throw _privateConstructorUsedError;
  bool? get dpser => throw _privateConstructorUsedError;
  bool? get speedrunner => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Competitor to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Competitor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CompetitorCopyWith<Competitor> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompetitorCopyWith<$Res> {
  factory $CompetitorCopyWith(
          Competitor value, $Res Function(Competitor) then) =
      _$CompetitorCopyWithImpl<$Res, Competitor>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      @JsonKey(name: 'discord_tag') String? discordtag,
      String alias,
      @JsonKey(name: 'account_uid') int? uid,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'last_modified_by') String? lastModifiedBy,
      bool? dpser,
      bool? speedrunner,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class _$CompetitorCopyWithImpl<$Res, $Val extends Competitor>
    implements $CompetitorCopyWith<$Res> {
  _$CompetitorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Competitor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? discordtag = freezed,
    Object? alias = null,
    Object? uid = freezed,
    Object? createdAt = freezed,
    Object? lastModifiedBy = freezed,
    Object? dpser = freezed,
    Object? speedrunner = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      discordtag: freezed == discordtag
          ? _value.discordtag
          : discordtag // ignore: cast_nullable_to_non_nullable
              as String?,
      alias: null == alias
          ? _value.alias
          : alias // ignore: cast_nullable_to_non_nullable
              as String,
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastModifiedBy: freezed == lastModifiedBy
          ? _value.lastModifiedBy
          : lastModifiedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      dpser: freezed == dpser
          ? _value.dpser
          : dpser // ignore: cast_nullable_to_non_nullable
              as bool?,
      speedrunner: freezed == speedrunner
          ? _value.speedrunner
          : speedrunner // ignore: cast_nullable_to_non_nullable
              as bool?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CompetitorImplCopyWith<$Res>
    implements $CompetitorCopyWith<$Res> {
  factory _$$CompetitorImplCopyWith(
          _$CompetitorImpl value, $Res Function(_$CompetitorImpl) then) =
      __$$CompetitorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      @JsonKey(name: 'discord_tag') String? discordtag,
      String alias,
      @JsonKey(name: 'account_uid') int? uid,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'last_modified_by') String? lastModifiedBy,
      bool? dpser,
      bool? speedrunner,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class __$$CompetitorImplCopyWithImpl<$Res>
    extends _$CompetitorCopyWithImpl<$Res, _$CompetitorImpl>
    implements _$$CompetitorImplCopyWith<$Res> {
  __$$CompetitorImplCopyWithImpl(
      _$CompetitorImpl _value, $Res Function(_$CompetitorImpl) _then)
      : super(_value, _then);

  /// Create a copy of Competitor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? discordtag = freezed,
    Object? alias = null,
    Object? uid = freezed,
    Object? createdAt = freezed,
    Object? lastModifiedBy = freezed,
    Object? dpser = freezed,
    Object? speedrunner = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$CompetitorImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      discordtag: freezed == discordtag
          ? _value.discordtag
          : discordtag // ignore: cast_nullable_to_non_nullable
              as String?,
      alias: null == alias
          ? _value.alias
          : alias // ignore: cast_nullable_to_non_nullable
              as String,
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastModifiedBy: freezed == lastModifiedBy
          ? _value.lastModifiedBy
          : lastModifiedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      dpser: freezed == dpser
          ? _value.dpser
          : dpser // ignore: cast_nullable_to_non_nullable
              as bool?,
      speedrunner: freezed == speedrunner
          ? _value.speedrunner
          : speedrunner // ignore: cast_nullable_to_non_nullable
              as bool?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CompetitorImpl implements _Competitor {
  const _$CompetitorImpl(
      {@JsonKey(name: '_id') required this.id,
      @JsonKey(name: 'discord_tag') this.discordtag,
      required this.alias,
      @JsonKey(name: 'account_uid') this.uid,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'last_modified_by') this.lastModifiedBy,
      this.dpser,
      this.speedrunner,
      @JsonKey(name: 'updated_at') this.updatedAt});

  factory _$CompetitorImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompetitorImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  @JsonKey(name: 'discord_tag')
  final String? discordtag;
  @override
  final String alias;
  @override
  @JsonKey(name: 'account_uid')
  final int? uid;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'last_modified_by')
  final String? lastModifiedBy;
  @override
  final bool? dpser;
  @override
  final bool? speedrunner;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Competitor(id: $id, discordtag: $discordtag, alias: $alias, uid: $uid, createdAt: $createdAt, lastModifiedBy: $lastModifiedBy, dpser: $dpser, speedrunner: $speedrunner, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompetitorImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.discordtag, discordtag) ||
                other.discordtag == discordtag) &&
            (identical(other.alias, alias) || other.alias == alias) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastModifiedBy, lastModifiedBy) ||
                other.lastModifiedBy == lastModifiedBy) &&
            (identical(other.dpser, dpser) || other.dpser == dpser) &&
            (identical(other.speedrunner, speedrunner) ||
                other.speedrunner == speedrunner) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, discordtag, alias, uid,
      createdAt, lastModifiedBy, dpser, speedrunner, updatedAt);

  /// Create a copy of Competitor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CompetitorImplCopyWith<_$CompetitorImpl> get copyWith =>
      __$$CompetitorImplCopyWithImpl<_$CompetitorImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CompetitorImplToJson(
      this,
    );
  }
}

abstract class _Competitor implements Competitor {
  const factory _Competitor(
          {@JsonKey(name: '_id') required final String id,
          @JsonKey(name: 'discord_tag') final String? discordtag,
          required final String alias,
          @JsonKey(name: 'account_uid') final int? uid,
          @JsonKey(name: 'created_at') final DateTime? createdAt,
          @JsonKey(name: 'last_modified_by') final String? lastModifiedBy,
          final bool? dpser,
          final bool? speedrunner,
          @JsonKey(name: 'updated_at') final DateTime? updatedAt}) =
      _$CompetitorImpl;

  factory _Competitor.fromJson(Map<String, dynamic> json) =
      _$CompetitorImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  @JsonKey(name: 'discord_tag')
  String? get discordtag;
  @override
  String get alias;
  @override
  @JsonKey(name: 'account_uid')
  int? get uid;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'last_modified_by')
  String? get lastModifiedBy;
  @override
  bool? get dpser;
  @override
  bool? get speedrunner;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;

  /// Create a copy of Competitor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CompetitorImplCopyWith<_$CompetitorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
