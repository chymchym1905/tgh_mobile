// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'speedrun.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Speedrun _$SpeedrunFromJson(Map<String, dynamic> json) {
  return _Speedrun.fromJson(json);
}

/// @nodoc
mixin _$Speedrun {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  Competitor get competitor => throw _privateConstructorUsedError;
  @JsonKey(name: 'team_1')
  List<String?> get team1 => throw _privateConstructorUsedError;
  @JsonKey(name: 'team_2')
  List<String?>? get team2 => throw _privateConstructorUsedError;
  String get region => throw _privateConstructorUsedError;
  @JsonKey(name: 'game_version')
  String get gameVersion => throw _privateConstructorUsedError;
  @JsonKey(name: 'abyss_version')
  String? get abyssVersion => throw _privateConstructorUsedError;
  @JsonKey(name: 'video_link')
  String get videolink => throw _privateConstructorUsedError;
  bool get approved => throw _privateConstructorUsedError;
  @JsonKey(name: 'speedrun_category')
  String get speedrunCategory => throw _privateConstructorUsedError;
  @JsonKey(name: 'speedrun_subcategory')
  String? get speedrunSubcategory => throw _privateConstructorUsedError;
  String get notes => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_modified_by')
  String? get lastModifiedBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  int get time => throw _privateConstructorUsedError;
  String? get accountSnapshot => throw _privateConstructorUsedError;
  List<String>? get tags => throw _privateConstructorUsedError;

  /// Serializes this Speedrun to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Speedrun
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SpeedrunCopyWith<Speedrun> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpeedrunCopyWith<$Res> {
  factory $SpeedrunCopyWith(Speedrun value, $Res Function(Speedrun) then) =
      _$SpeedrunCopyWithImpl<$Res, Speedrun>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      Competitor competitor,
      @JsonKey(name: 'team_1') List<String?> team1,
      @JsonKey(name: 'team_2') List<String?>? team2,
      String region,
      @JsonKey(name: 'game_version') String gameVersion,
      @JsonKey(name: 'abyss_version') String? abyssVersion,
      @JsonKey(name: 'video_link') String videolink,
      bool approved,
      @JsonKey(name: 'speedrun_category') String speedrunCategory,
      @JsonKey(name: 'speedrun_subcategory') String? speedrunSubcategory,
      String notes,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'last_modified_by') String? lastModifiedBy,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      int time,
      String? accountSnapshot,
      List<String>? tags});

  $CompetitorCopyWith<$Res> get competitor;
}

/// @nodoc
class _$SpeedrunCopyWithImpl<$Res, $Val extends Speedrun>
    implements $SpeedrunCopyWith<$Res> {
  _$SpeedrunCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Speedrun
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? competitor = null,
    Object? team1 = null,
    Object? team2 = freezed,
    Object? region = null,
    Object? gameVersion = null,
    Object? abyssVersion = freezed,
    Object? videolink = null,
    Object? approved = null,
    Object? speedrunCategory = null,
    Object? speedrunSubcategory = freezed,
    Object? notes = null,
    Object? createdAt = freezed,
    Object? lastModifiedBy = freezed,
    Object? updatedAt = freezed,
    Object? time = null,
    Object? accountSnapshot = freezed,
    Object? tags = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      competitor: null == competitor
          ? _value.competitor
          : competitor // ignore: cast_nullable_to_non_nullable
              as Competitor,
      team1: null == team1
          ? _value.team1
          : team1 // ignore: cast_nullable_to_non_nullable
              as List<String?>,
      team2: freezed == team2
          ? _value.team2
          : team2 // ignore: cast_nullable_to_non_nullable
              as List<String?>?,
      region: null == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String,
      gameVersion: null == gameVersion
          ? _value.gameVersion
          : gameVersion // ignore: cast_nullable_to_non_nullable
              as String,
      abyssVersion: freezed == abyssVersion
          ? _value.abyssVersion
          : abyssVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      videolink: null == videolink
          ? _value.videolink
          : videolink // ignore: cast_nullable_to_non_nullable
              as String,
      approved: null == approved
          ? _value.approved
          : approved // ignore: cast_nullable_to_non_nullable
              as bool,
      speedrunCategory: null == speedrunCategory
          ? _value.speedrunCategory
          : speedrunCategory // ignore: cast_nullable_to_non_nullable
              as String,
      speedrunSubcategory: freezed == speedrunSubcategory
          ? _value.speedrunSubcategory
          : speedrunSubcategory // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastModifiedBy: freezed == lastModifiedBy
          ? _value.lastModifiedBy
          : lastModifiedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int,
      accountSnapshot: freezed == accountSnapshot
          ? _value.accountSnapshot
          : accountSnapshot // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }

  /// Create a copy of Speedrun
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CompetitorCopyWith<$Res> get competitor {
    return $CompetitorCopyWith<$Res>(_value.competitor, (value) {
      return _then(_value.copyWith(competitor: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SpeedrunImplCopyWith<$Res>
    implements $SpeedrunCopyWith<$Res> {
  factory _$$SpeedrunImplCopyWith(
          _$SpeedrunImpl value, $Res Function(_$SpeedrunImpl) then) =
      __$$SpeedrunImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      Competitor competitor,
      @JsonKey(name: 'team_1') List<String?> team1,
      @JsonKey(name: 'team_2') List<String?>? team2,
      String region,
      @JsonKey(name: 'game_version') String gameVersion,
      @JsonKey(name: 'abyss_version') String? abyssVersion,
      @JsonKey(name: 'video_link') String videolink,
      bool approved,
      @JsonKey(name: 'speedrun_category') String speedrunCategory,
      @JsonKey(name: 'speedrun_subcategory') String? speedrunSubcategory,
      String notes,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'last_modified_by') String? lastModifiedBy,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      int time,
      String? accountSnapshot,
      List<String>? tags});

  @override
  $CompetitorCopyWith<$Res> get competitor;
}

/// @nodoc
class __$$SpeedrunImplCopyWithImpl<$Res>
    extends _$SpeedrunCopyWithImpl<$Res, _$SpeedrunImpl>
    implements _$$SpeedrunImplCopyWith<$Res> {
  __$$SpeedrunImplCopyWithImpl(
      _$SpeedrunImpl _value, $Res Function(_$SpeedrunImpl) _then)
      : super(_value, _then);

  /// Create a copy of Speedrun
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? competitor = null,
    Object? team1 = null,
    Object? team2 = freezed,
    Object? region = null,
    Object? gameVersion = null,
    Object? abyssVersion = freezed,
    Object? videolink = null,
    Object? approved = null,
    Object? speedrunCategory = null,
    Object? speedrunSubcategory = freezed,
    Object? notes = null,
    Object? createdAt = freezed,
    Object? lastModifiedBy = freezed,
    Object? updatedAt = freezed,
    Object? time = null,
    Object? accountSnapshot = freezed,
    Object? tags = freezed,
  }) {
    return _then(_$SpeedrunImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      competitor: null == competitor
          ? _value.competitor
          : competitor // ignore: cast_nullable_to_non_nullable
              as Competitor,
      team1: null == team1
          ? _value._team1
          : team1 // ignore: cast_nullable_to_non_nullable
              as List<String?>,
      team2: freezed == team2
          ? _value._team2
          : team2 // ignore: cast_nullable_to_non_nullable
              as List<String?>?,
      region: null == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String,
      gameVersion: null == gameVersion
          ? _value.gameVersion
          : gameVersion // ignore: cast_nullable_to_non_nullable
              as String,
      abyssVersion: freezed == abyssVersion
          ? _value.abyssVersion
          : abyssVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      videolink: null == videolink
          ? _value.videolink
          : videolink // ignore: cast_nullable_to_non_nullable
              as String,
      approved: null == approved
          ? _value.approved
          : approved // ignore: cast_nullable_to_non_nullable
              as bool,
      speedrunCategory: null == speedrunCategory
          ? _value.speedrunCategory
          : speedrunCategory // ignore: cast_nullable_to_non_nullable
              as String,
      speedrunSubcategory: freezed == speedrunSubcategory
          ? _value.speedrunSubcategory
          : speedrunSubcategory // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastModifiedBy: freezed == lastModifiedBy
          ? _value.lastModifiedBy
          : lastModifiedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int,
      accountSnapshot: freezed == accountSnapshot
          ? _value.accountSnapshot
          : accountSnapshot // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$SpeedrunImpl implements _Speedrun {
  const _$SpeedrunImpl(
      {@JsonKey(name: '_id') required this.id,
      required this.competitor,
      @JsonKey(name: 'team_1') required final List<String?> team1,
      @JsonKey(name: 'team_2') final List<String?>? team2,
      required this.region,
      @JsonKey(name: 'game_version') required this.gameVersion,
      @JsonKey(name: 'abyss_version') this.abyssVersion,
      @JsonKey(name: 'video_link') required this.videolink,
      required this.approved,
      @JsonKey(name: 'speedrun_category') required this.speedrunCategory,
      @JsonKey(name: 'speedrun_subcategory') this.speedrunSubcategory,
      required this.notes,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'last_modified_by') this.lastModifiedBy,
      @JsonKey(name: 'updated_at') this.updatedAt,
      required this.time,
      this.accountSnapshot,
      final List<String>? tags})
      : _team1 = team1,
        _team2 = team2,
        _tags = tags;

  factory _$SpeedrunImpl.fromJson(Map<String, dynamic> json) =>
      _$$SpeedrunImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final Competitor competitor;
  final List<String?> _team1;
  @override
  @JsonKey(name: 'team_1')
  List<String?> get team1 {
    if (_team1 is EqualUnmodifiableListView) return _team1;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_team1);
  }

  final List<String?>? _team2;
  @override
  @JsonKey(name: 'team_2')
  List<String?>? get team2 {
    final value = _team2;
    if (value == null) return null;
    if (_team2 is EqualUnmodifiableListView) return _team2;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String region;
  @override
  @JsonKey(name: 'game_version')
  final String gameVersion;
  @override
  @JsonKey(name: 'abyss_version')
  final String? abyssVersion;
  @override
  @JsonKey(name: 'video_link')
  final String videolink;
  @override
  final bool approved;
  @override
  @JsonKey(name: 'speedrun_category')
  final String speedrunCategory;
  @override
  @JsonKey(name: 'speedrun_subcategory')
  final String? speedrunSubcategory;
  @override
  final String notes;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'last_modified_by')
  final String? lastModifiedBy;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @override
  final int time;
  @override
  final String? accountSnapshot;
  final List<String>? _tags;
  @override
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Speedrun(id: $id, competitor: $competitor, team1: $team1, team2: $team2, region: $region, gameVersion: $gameVersion, abyssVersion: $abyssVersion, videolink: $videolink, approved: $approved, speedrunCategory: $speedrunCategory, speedrunSubcategory: $speedrunSubcategory, notes: $notes, createdAt: $createdAt, lastModifiedBy: $lastModifiedBy, updatedAt: $updatedAt, time: $time, accountSnapshot: $accountSnapshot, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpeedrunImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.competitor, competitor) ||
                other.competitor == competitor) &&
            const DeepCollectionEquality().equals(other._team1, _team1) &&
            const DeepCollectionEquality().equals(other._team2, _team2) &&
            (identical(other.region, region) || other.region == region) &&
            (identical(other.gameVersion, gameVersion) ||
                other.gameVersion == gameVersion) &&
            (identical(other.abyssVersion, abyssVersion) ||
                other.abyssVersion == abyssVersion) &&
            (identical(other.videolink, videolink) ||
                other.videolink == videolink) &&
            (identical(other.approved, approved) ||
                other.approved == approved) &&
            (identical(other.speedrunCategory, speedrunCategory) ||
                other.speedrunCategory == speedrunCategory) &&
            (identical(other.speedrunSubcategory, speedrunSubcategory) ||
                other.speedrunSubcategory == speedrunSubcategory) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastModifiedBy, lastModifiedBy) ||
                other.lastModifiedBy == lastModifiedBy) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.accountSnapshot, accountSnapshot) ||
                other.accountSnapshot == accountSnapshot) &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      competitor,
      const DeepCollectionEquality().hash(_team1),
      const DeepCollectionEquality().hash(_team2),
      region,
      gameVersion,
      abyssVersion,
      videolink,
      approved,
      speedrunCategory,
      speedrunSubcategory,
      notes,
      createdAt,
      lastModifiedBy,
      updatedAt,
      time,
      accountSnapshot,
      const DeepCollectionEquality().hash(_tags));

  /// Create a copy of Speedrun
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SpeedrunImplCopyWith<_$SpeedrunImpl> get copyWith =>
      __$$SpeedrunImplCopyWithImpl<_$SpeedrunImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SpeedrunImplToJson(
      this,
    );
  }
}

abstract class _Speedrun implements Speedrun {
  const factory _Speedrun(
      {@JsonKey(name: '_id') required final String id,
      required final Competitor competitor,
      @JsonKey(name: 'team_1') required final List<String?> team1,
      @JsonKey(name: 'team_2') final List<String?>? team2,
      required final String region,
      @JsonKey(name: 'game_version') required final String gameVersion,
      @JsonKey(name: 'abyss_version') final String? abyssVersion,
      @JsonKey(name: 'video_link') required final String videolink,
      required final bool approved,
      @JsonKey(name: 'speedrun_category')
      required final String speedrunCategory,
      @JsonKey(name: 'speedrun_subcategory') final String? speedrunSubcategory,
      required final String notes,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(name: 'last_modified_by') final String? lastModifiedBy,
      @JsonKey(name: 'updated_at') final DateTime? updatedAt,
      required final int time,
      final String? accountSnapshot,
      final List<String>? tags}) = _$SpeedrunImpl;

  factory _Speedrun.fromJson(Map<String, dynamic> json) =
      _$SpeedrunImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  Competitor get competitor;
  @override
  @JsonKey(name: 'team_1')
  List<String?> get team1;
  @override
  @JsonKey(name: 'team_2')
  List<String?>? get team2;
  @override
  String get region;
  @override
  @JsonKey(name: 'game_version')
  String get gameVersion;
  @override
  @JsonKey(name: 'abyss_version')
  String? get abyssVersion;
  @override
  @JsonKey(name: 'video_link')
  String get videolink;
  @override
  bool get approved;
  @override
  @JsonKey(name: 'speedrun_category')
  String get speedrunCategory;
  @override
  @JsonKey(name: 'speedrun_subcategory')
  String? get speedrunSubcategory;
  @override
  String get notes;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'last_modified_by')
  String? get lastModifiedBy;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;
  @override
  int get time;
  @override
  String? get accountSnapshot;
  @override
  List<String>? get tags;

  /// Create a copy of Speedrun
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SpeedrunImplCopyWith<_$SpeedrunImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
