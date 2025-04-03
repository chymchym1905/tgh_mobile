// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Feed {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  Competitor get competitor => throw _privateConstructorUsedError;
  String get region => throw _privateConstructorUsedError;
  @JsonKey(name: 'game_version')
  String get gameVersion => throw _privateConstructorUsedError;
  @JsonKey(name: 'abyss_version')
  String? get abyssVersion => throw _privateConstructorUsedError;
  @JsonKey(name: 'video_link')
  String get videolink => throw _privateConstructorUsedError;
  bool get approved => throw _privateConstructorUsedError;
  String get notes => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_modified_by')
  String? get lastModifiedBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  String? get accountSnapshot => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            @JsonKey(name: '_id') String id,
            Competitor competitor,
            @JsonKey(name: 'team') List<String?> team,
            @JsonKey(name: 'dps_character') String dpsCharacter,
            @JsonKey(name: 'dps_character_element') String? dpsCharElement,
            @JsonKey(name: 'character_ceiling')
            CharacterCeiling characterCeiling,
            @JsonKey(name: 'damage_dealt') int damageDealt,
            @JsonKey(name: 'attack_type') String attackType,
            @JsonKey(name: 'dps_category') String dpsCategory,
            String enemy,
            @JsonKey(name: 'enemy_lv') int enemyLevel,
            bool stunned,
            @JsonKey(name: 'food_used') bool food,
            String region,
            @JsonKey(name: 'game_version') String gameVersion,
            @JsonKey(name: 'abyss_version') String? abyssVersion,
            @JsonKey(name: 'abyss_floor') String? abyssFloor,
            @JsonKey(name: 'video_link') String videolink,
            bool approved,
            String notes,
            @JsonKey(name: 'created_at') DateTime? createdAt,
            @JsonKey(name: 'last_modified_by') String? lastModifiedBy,
            @JsonKey(name: 'updated_at') DateTime? updatedAt,
            String? accountSnapshot,
            @JsonKey(name: 'video_metadata')
            Map<String, dynamic>? videoMetadata)
        dps,
    required TResult Function(
            @JsonKey(name: '_id') String id,
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
            List<String>? tags)
        speedrun,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            @JsonKey(name: '_id') String id,
            Competitor competitor,
            @JsonKey(name: 'team') List<String?> team,
            @JsonKey(name: 'dps_character') String dpsCharacter,
            @JsonKey(name: 'dps_character_element') String? dpsCharElement,
            @JsonKey(name: 'character_ceiling')
            CharacterCeiling characterCeiling,
            @JsonKey(name: 'damage_dealt') int damageDealt,
            @JsonKey(name: 'attack_type') String attackType,
            @JsonKey(name: 'dps_category') String dpsCategory,
            String enemy,
            @JsonKey(name: 'enemy_lv') int enemyLevel,
            bool stunned,
            @JsonKey(name: 'food_used') bool food,
            String region,
            @JsonKey(name: 'game_version') String gameVersion,
            @JsonKey(name: 'abyss_version') String? abyssVersion,
            @JsonKey(name: 'abyss_floor') String? abyssFloor,
            @JsonKey(name: 'video_link') String videolink,
            bool approved,
            String notes,
            @JsonKey(name: 'created_at') DateTime? createdAt,
            @JsonKey(name: 'last_modified_by') String? lastModifiedBy,
            @JsonKey(name: 'updated_at') DateTime? updatedAt,
            String? accountSnapshot,
            @JsonKey(name: 'video_metadata')
            Map<String, dynamic>? videoMetadata)?
        dps,
    TResult? Function(
            @JsonKey(name: '_id') String id,
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
            List<String>? tags)?
        speedrun,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            @JsonKey(name: '_id') String id,
            Competitor competitor,
            @JsonKey(name: 'team') List<String?> team,
            @JsonKey(name: 'dps_character') String dpsCharacter,
            @JsonKey(name: 'dps_character_element') String? dpsCharElement,
            @JsonKey(name: 'character_ceiling')
            CharacterCeiling characterCeiling,
            @JsonKey(name: 'damage_dealt') int damageDealt,
            @JsonKey(name: 'attack_type') String attackType,
            @JsonKey(name: 'dps_category') String dpsCategory,
            String enemy,
            @JsonKey(name: 'enemy_lv') int enemyLevel,
            bool stunned,
            @JsonKey(name: 'food_used') bool food,
            String region,
            @JsonKey(name: 'game_version') String gameVersion,
            @JsonKey(name: 'abyss_version') String? abyssVersion,
            @JsonKey(name: 'abyss_floor') String? abyssFloor,
            @JsonKey(name: 'video_link') String videolink,
            bool approved,
            String notes,
            @JsonKey(name: 'created_at') DateTime? createdAt,
            @JsonKey(name: 'last_modified_by') String? lastModifiedBy,
            @JsonKey(name: 'updated_at') DateTime? updatedAt,
            String? accountSnapshot,
            @JsonKey(name: 'video_metadata')
            Map<String, dynamic>? videoMetadata)?
        dps,
    TResult Function(
            @JsonKey(name: '_id') String id,
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
            List<String>? tags)?
        speedrun,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DPSFeed value) dps,
    required TResult Function(SpeedrunFeed value) speedrun,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DPSFeed value)? dps,
    TResult? Function(SpeedrunFeed value)? speedrun,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DPSFeed value)? dps,
    TResult Function(SpeedrunFeed value)? speedrun,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of Feed
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FeedCopyWith<Feed> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeedCopyWith<$Res> {
  factory $FeedCopyWith(Feed value, $Res Function(Feed) then) =
      _$FeedCopyWithImpl<$Res, Feed>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      Competitor competitor,
      String region,
      @JsonKey(name: 'game_version') String gameVersion,
      @JsonKey(name: 'abyss_version') String? abyssVersion,
      @JsonKey(name: 'video_link') String videolink,
      bool approved,
      String notes,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'last_modified_by') String? lastModifiedBy,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      String? accountSnapshot});

  $CompetitorCopyWith<$Res> get competitor;
}

/// @nodoc
class _$FeedCopyWithImpl<$Res, $Val extends Feed>
    implements $FeedCopyWith<$Res> {
  _$FeedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Feed
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? competitor = null,
    Object? region = null,
    Object? gameVersion = null,
    Object? abyssVersion = freezed,
    Object? videolink = null,
    Object? approved = null,
    Object? notes = null,
    Object? createdAt = freezed,
    Object? lastModifiedBy = freezed,
    Object? updatedAt = freezed,
    Object? accountSnapshot = freezed,
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
      accountSnapshot: freezed == accountSnapshot
          ? _value.accountSnapshot
          : accountSnapshot // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of Feed
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
abstract class _$$DPSFeedImplCopyWith<$Res> implements $FeedCopyWith<$Res> {
  factory _$$DPSFeedImplCopyWith(
          _$DPSFeedImpl value, $Res Function(_$DPSFeedImpl) then) =
      __$$DPSFeedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      Competitor competitor,
      @JsonKey(name: 'team') List<String?> team,
      @JsonKey(name: 'dps_character') String dpsCharacter,
      @JsonKey(name: 'dps_character_element') String? dpsCharElement,
      @JsonKey(name: 'character_ceiling') CharacterCeiling characterCeiling,
      @JsonKey(name: 'damage_dealt') int damageDealt,
      @JsonKey(name: 'attack_type') String attackType,
      @JsonKey(name: 'dps_category') String dpsCategory,
      String enemy,
      @JsonKey(name: 'enemy_lv') int enemyLevel,
      bool stunned,
      @JsonKey(name: 'food_used') bool food,
      String region,
      @JsonKey(name: 'game_version') String gameVersion,
      @JsonKey(name: 'abyss_version') String? abyssVersion,
      @JsonKey(name: 'abyss_floor') String? abyssFloor,
      @JsonKey(name: 'video_link') String videolink,
      bool approved,
      String notes,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'last_modified_by') String? lastModifiedBy,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      String? accountSnapshot,
      @JsonKey(name: 'video_metadata') Map<String, dynamic>? videoMetadata});

  @override
  $CompetitorCopyWith<$Res> get competitor;
  $CharacterCeilingCopyWith<$Res> get characterCeiling;
}

/// @nodoc
class __$$DPSFeedImplCopyWithImpl<$Res>
    extends _$FeedCopyWithImpl<$Res, _$DPSFeedImpl>
    implements _$$DPSFeedImplCopyWith<$Res> {
  __$$DPSFeedImplCopyWithImpl(
      _$DPSFeedImpl _value, $Res Function(_$DPSFeedImpl) _then)
      : super(_value, _then);

  /// Create a copy of Feed
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? competitor = null,
    Object? team = null,
    Object? dpsCharacter = null,
    Object? dpsCharElement = freezed,
    Object? characterCeiling = null,
    Object? damageDealt = null,
    Object? attackType = null,
    Object? dpsCategory = null,
    Object? enemy = null,
    Object? enemyLevel = null,
    Object? stunned = null,
    Object? food = null,
    Object? region = null,
    Object? gameVersion = null,
    Object? abyssVersion = freezed,
    Object? abyssFloor = freezed,
    Object? videolink = null,
    Object? approved = null,
    Object? notes = null,
    Object? createdAt = freezed,
    Object? lastModifiedBy = freezed,
    Object? updatedAt = freezed,
    Object? accountSnapshot = freezed,
    Object? videoMetadata = freezed,
  }) {
    return _then(_$DPSFeedImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      competitor: null == competitor
          ? _value.competitor
          : competitor // ignore: cast_nullable_to_non_nullable
              as Competitor,
      team: null == team
          ? _value._team
          : team // ignore: cast_nullable_to_non_nullable
              as List<String?>,
      dpsCharacter: null == dpsCharacter
          ? _value.dpsCharacter
          : dpsCharacter // ignore: cast_nullable_to_non_nullable
              as String,
      dpsCharElement: freezed == dpsCharElement
          ? _value.dpsCharElement
          : dpsCharElement // ignore: cast_nullable_to_non_nullable
              as String?,
      characterCeiling: null == characterCeiling
          ? _value.characterCeiling
          : characterCeiling // ignore: cast_nullable_to_non_nullable
              as CharacterCeiling,
      damageDealt: null == damageDealt
          ? _value.damageDealt
          : damageDealt // ignore: cast_nullable_to_non_nullable
              as int,
      attackType: null == attackType
          ? _value.attackType
          : attackType // ignore: cast_nullable_to_non_nullable
              as String,
      dpsCategory: null == dpsCategory
          ? _value.dpsCategory
          : dpsCategory // ignore: cast_nullable_to_non_nullable
              as String,
      enemy: null == enemy
          ? _value.enemy
          : enemy // ignore: cast_nullable_to_non_nullable
              as String,
      enemyLevel: null == enemyLevel
          ? _value.enemyLevel
          : enemyLevel // ignore: cast_nullable_to_non_nullable
              as int,
      stunned: null == stunned
          ? _value.stunned
          : stunned // ignore: cast_nullable_to_non_nullable
              as bool,
      food: null == food
          ? _value.food
          : food // ignore: cast_nullable_to_non_nullable
              as bool,
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
      abyssFloor: freezed == abyssFloor
          ? _value.abyssFloor
          : abyssFloor // ignore: cast_nullable_to_non_nullable
              as String?,
      videolink: null == videolink
          ? _value.videolink
          : videolink // ignore: cast_nullable_to_non_nullable
              as String,
      approved: null == approved
          ? _value.approved
          : approved // ignore: cast_nullable_to_non_nullable
              as bool,
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
      accountSnapshot: freezed == accountSnapshot
          ? _value.accountSnapshot
          : accountSnapshot // ignore: cast_nullable_to_non_nullable
              as String?,
      videoMetadata: freezed == videoMetadata
          ? _value._videoMetadata
          : videoMetadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }

  /// Create a copy of Feed
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CharacterCeilingCopyWith<$Res> get characterCeiling {
    return $CharacterCeilingCopyWith<$Res>(_value.characterCeiling, (value) {
      return _then(_value.copyWith(characterCeiling: value));
    });
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$DPSFeedImpl implements DPSFeed {
  const _$DPSFeedImpl(
      {@JsonKey(name: '_id') required this.id,
      required this.competitor,
      @JsonKey(name: 'team') required final List<String?> team,
      @JsonKey(name: 'dps_character') required this.dpsCharacter,
      @JsonKey(name: 'dps_character_element') this.dpsCharElement,
      @JsonKey(name: 'character_ceiling') required this.characterCeiling,
      @JsonKey(name: 'damage_dealt') required this.damageDealt,
      @JsonKey(name: 'attack_type') required this.attackType,
      @JsonKey(name: 'dps_category') required this.dpsCategory,
      required this.enemy,
      @JsonKey(name: 'enemy_lv') required this.enemyLevel,
      required this.stunned,
      @JsonKey(name: 'food_used') required this.food,
      required this.region,
      @JsonKey(name: 'game_version') required this.gameVersion,
      @JsonKey(name: 'abyss_version') this.abyssVersion,
      @JsonKey(name: 'abyss_floor') this.abyssFloor,
      @JsonKey(name: 'video_link') required this.videolink,
      required this.approved,
      required this.notes,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'last_modified_by') this.lastModifiedBy,
      @JsonKey(name: 'updated_at') this.updatedAt,
      this.accountSnapshot,
      @JsonKey(name: 'video_metadata')
      final Map<String, dynamic>? videoMetadata})
      : _team = team,
        _videoMetadata = videoMetadata;

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final Competitor competitor;
  final List<String?> _team;
  @override
  @JsonKey(name: 'team')
  List<String?> get team {
    if (_team is EqualUnmodifiableListView) return _team;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_team);
  }

  @override
  @JsonKey(name: 'dps_character')
  final String dpsCharacter;
  @override
  @JsonKey(name: 'dps_character_element')
  final String? dpsCharElement;
  @override
  @JsonKey(name: 'character_ceiling')
  final CharacterCeiling characterCeiling;
  @override
  @JsonKey(name: 'damage_dealt')
  final int damageDealt;
  @override
  @JsonKey(name: 'attack_type')
  final String attackType;
  @override
  @JsonKey(name: 'dps_category')
  final String dpsCategory;
  @override
  final String enemy;
  @override
  @JsonKey(name: 'enemy_lv')
  final int enemyLevel;
  @override
  final bool stunned;
  @override
  @JsonKey(name: 'food_used')
  final bool food;
  @override
  final String region;
  @override
  @JsonKey(name: 'game_version')
  final String gameVersion;
  @override
  @JsonKey(name: 'abyss_version')
  final String? abyssVersion;
  @override
  @JsonKey(name: 'abyss_floor')
  final String? abyssFloor;
  @override
  @JsonKey(name: 'video_link')
  final String videolink;
  @override
  final bool approved;
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
  final String? accountSnapshot;
  final Map<String, dynamic>? _videoMetadata;
  @override
  @JsonKey(name: 'video_metadata')
  Map<String, dynamic>? get videoMetadata {
    final value = _videoMetadata;
    if (value == null) return null;
    if (_videoMetadata is EqualUnmodifiableMapView) return _videoMetadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'Feed.dps(id: $id, competitor: $competitor, team: $team, dpsCharacter: $dpsCharacter, dpsCharElement: $dpsCharElement, characterCeiling: $characterCeiling, damageDealt: $damageDealt, attackType: $attackType, dpsCategory: $dpsCategory, enemy: $enemy, enemyLevel: $enemyLevel, stunned: $stunned, food: $food, region: $region, gameVersion: $gameVersion, abyssVersion: $abyssVersion, abyssFloor: $abyssFloor, videolink: $videolink, approved: $approved, notes: $notes, createdAt: $createdAt, lastModifiedBy: $lastModifiedBy, updatedAt: $updatedAt, accountSnapshot: $accountSnapshot, videoMetadata: $videoMetadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DPSFeedImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.competitor, competitor) ||
                other.competitor == competitor) &&
            const DeepCollectionEquality().equals(other._team, _team) &&
            (identical(other.dpsCharacter, dpsCharacter) ||
                other.dpsCharacter == dpsCharacter) &&
            (identical(other.dpsCharElement, dpsCharElement) ||
                other.dpsCharElement == dpsCharElement) &&
            (identical(other.characterCeiling, characterCeiling) ||
                other.characterCeiling == characterCeiling) &&
            (identical(other.damageDealt, damageDealt) ||
                other.damageDealt == damageDealt) &&
            (identical(other.attackType, attackType) ||
                other.attackType == attackType) &&
            (identical(other.dpsCategory, dpsCategory) ||
                other.dpsCategory == dpsCategory) &&
            (identical(other.enemy, enemy) || other.enemy == enemy) &&
            (identical(other.enemyLevel, enemyLevel) ||
                other.enemyLevel == enemyLevel) &&
            (identical(other.stunned, stunned) || other.stunned == stunned) &&
            (identical(other.food, food) || other.food == food) &&
            (identical(other.region, region) || other.region == region) &&
            (identical(other.gameVersion, gameVersion) ||
                other.gameVersion == gameVersion) &&
            (identical(other.abyssVersion, abyssVersion) ||
                other.abyssVersion == abyssVersion) &&
            (identical(other.abyssFloor, abyssFloor) ||
                other.abyssFloor == abyssFloor) &&
            (identical(other.videolink, videolink) ||
                other.videolink == videolink) &&
            (identical(other.approved, approved) ||
                other.approved == approved) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastModifiedBy, lastModifiedBy) ||
                other.lastModifiedBy == lastModifiedBy) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.accountSnapshot, accountSnapshot) ||
                other.accountSnapshot == accountSnapshot) &&
            const DeepCollectionEquality()
                .equals(other._videoMetadata, _videoMetadata));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        competitor,
        const DeepCollectionEquality().hash(_team),
        dpsCharacter,
        dpsCharElement,
        characterCeiling,
        damageDealt,
        attackType,
        dpsCategory,
        enemy,
        enemyLevel,
        stunned,
        food,
        region,
        gameVersion,
        abyssVersion,
        abyssFloor,
        videolink,
        approved,
        notes,
        createdAt,
        lastModifiedBy,
        updatedAt,
        accountSnapshot,
        const DeepCollectionEquality().hash(_videoMetadata)
      ]);

  /// Create a copy of Feed
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DPSFeedImplCopyWith<_$DPSFeedImpl> get copyWith =>
      __$$DPSFeedImplCopyWithImpl<_$DPSFeedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            @JsonKey(name: '_id') String id,
            Competitor competitor,
            @JsonKey(name: 'team') List<String?> team,
            @JsonKey(name: 'dps_character') String dpsCharacter,
            @JsonKey(name: 'dps_character_element') String? dpsCharElement,
            @JsonKey(name: 'character_ceiling')
            CharacterCeiling characterCeiling,
            @JsonKey(name: 'damage_dealt') int damageDealt,
            @JsonKey(name: 'attack_type') String attackType,
            @JsonKey(name: 'dps_category') String dpsCategory,
            String enemy,
            @JsonKey(name: 'enemy_lv') int enemyLevel,
            bool stunned,
            @JsonKey(name: 'food_used') bool food,
            String region,
            @JsonKey(name: 'game_version') String gameVersion,
            @JsonKey(name: 'abyss_version') String? abyssVersion,
            @JsonKey(name: 'abyss_floor') String? abyssFloor,
            @JsonKey(name: 'video_link') String videolink,
            bool approved,
            String notes,
            @JsonKey(name: 'created_at') DateTime? createdAt,
            @JsonKey(name: 'last_modified_by') String? lastModifiedBy,
            @JsonKey(name: 'updated_at') DateTime? updatedAt,
            String? accountSnapshot,
            @JsonKey(name: 'video_metadata')
            Map<String, dynamic>? videoMetadata)
        dps,
    required TResult Function(
            @JsonKey(name: '_id') String id,
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
            List<String>? tags)
        speedrun,
  }) {
    return dps(
        id,
        competitor,
        team,
        dpsCharacter,
        dpsCharElement,
        characterCeiling,
        damageDealt,
        attackType,
        dpsCategory,
        enemy,
        enemyLevel,
        stunned,
        food,
        region,
        gameVersion,
        abyssVersion,
        abyssFloor,
        videolink,
        approved,
        notes,
        createdAt,
        lastModifiedBy,
        updatedAt,
        accountSnapshot,
        videoMetadata);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            @JsonKey(name: '_id') String id,
            Competitor competitor,
            @JsonKey(name: 'team') List<String?> team,
            @JsonKey(name: 'dps_character') String dpsCharacter,
            @JsonKey(name: 'dps_character_element') String? dpsCharElement,
            @JsonKey(name: 'character_ceiling')
            CharacterCeiling characterCeiling,
            @JsonKey(name: 'damage_dealt') int damageDealt,
            @JsonKey(name: 'attack_type') String attackType,
            @JsonKey(name: 'dps_category') String dpsCategory,
            String enemy,
            @JsonKey(name: 'enemy_lv') int enemyLevel,
            bool stunned,
            @JsonKey(name: 'food_used') bool food,
            String region,
            @JsonKey(name: 'game_version') String gameVersion,
            @JsonKey(name: 'abyss_version') String? abyssVersion,
            @JsonKey(name: 'abyss_floor') String? abyssFloor,
            @JsonKey(name: 'video_link') String videolink,
            bool approved,
            String notes,
            @JsonKey(name: 'created_at') DateTime? createdAt,
            @JsonKey(name: 'last_modified_by') String? lastModifiedBy,
            @JsonKey(name: 'updated_at') DateTime? updatedAt,
            String? accountSnapshot,
            @JsonKey(name: 'video_metadata')
            Map<String, dynamic>? videoMetadata)?
        dps,
    TResult? Function(
            @JsonKey(name: '_id') String id,
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
            List<String>? tags)?
        speedrun,
  }) {
    return dps?.call(
        id,
        competitor,
        team,
        dpsCharacter,
        dpsCharElement,
        characterCeiling,
        damageDealt,
        attackType,
        dpsCategory,
        enemy,
        enemyLevel,
        stunned,
        food,
        region,
        gameVersion,
        abyssVersion,
        abyssFloor,
        videolink,
        approved,
        notes,
        createdAt,
        lastModifiedBy,
        updatedAt,
        accountSnapshot,
        videoMetadata);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            @JsonKey(name: '_id') String id,
            Competitor competitor,
            @JsonKey(name: 'team') List<String?> team,
            @JsonKey(name: 'dps_character') String dpsCharacter,
            @JsonKey(name: 'dps_character_element') String? dpsCharElement,
            @JsonKey(name: 'character_ceiling')
            CharacterCeiling characterCeiling,
            @JsonKey(name: 'damage_dealt') int damageDealt,
            @JsonKey(name: 'attack_type') String attackType,
            @JsonKey(name: 'dps_category') String dpsCategory,
            String enemy,
            @JsonKey(name: 'enemy_lv') int enemyLevel,
            bool stunned,
            @JsonKey(name: 'food_used') bool food,
            String region,
            @JsonKey(name: 'game_version') String gameVersion,
            @JsonKey(name: 'abyss_version') String? abyssVersion,
            @JsonKey(name: 'abyss_floor') String? abyssFloor,
            @JsonKey(name: 'video_link') String videolink,
            bool approved,
            String notes,
            @JsonKey(name: 'created_at') DateTime? createdAt,
            @JsonKey(name: 'last_modified_by') String? lastModifiedBy,
            @JsonKey(name: 'updated_at') DateTime? updatedAt,
            String? accountSnapshot,
            @JsonKey(name: 'video_metadata')
            Map<String, dynamic>? videoMetadata)?
        dps,
    TResult Function(
            @JsonKey(name: '_id') String id,
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
            List<String>? tags)?
        speedrun,
    required TResult orElse(),
  }) {
    if (dps != null) {
      return dps(
          id,
          competitor,
          team,
          dpsCharacter,
          dpsCharElement,
          characterCeiling,
          damageDealt,
          attackType,
          dpsCategory,
          enemy,
          enemyLevel,
          stunned,
          food,
          region,
          gameVersion,
          abyssVersion,
          abyssFloor,
          videolink,
          approved,
          notes,
          createdAt,
          lastModifiedBy,
          updatedAt,
          accountSnapshot,
          videoMetadata);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DPSFeed value) dps,
    required TResult Function(SpeedrunFeed value) speedrun,
  }) {
    return dps(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DPSFeed value)? dps,
    TResult? Function(SpeedrunFeed value)? speedrun,
  }) {
    return dps?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DPSFeed value)? dps,
    TResult Function(SpeedrunFeed value)? speedrun,
    required TResult orElse(),
  }) {
    if (dps != null) {
      return dps(this);
    }
    return orElse();
  }
}

abstract class DPSFeed implements Feed, DPSProperties {
  const factory DPSFeed(
      {@JsonKey(name: '_id') required final String id,
      required final Competitor competitor,
      @JsonKey(name: 'team') required final List<String?> team,
      @JsonKey(name: 'dps_character') required final String dpsCharacter,
      @JsonKey(name: 'dps_character_element') final String? dpsCharElement,
      @JsonKey(name: 'character_ceiling')
      required final CharacterCeiling characterCeiling,
      @JsonKey(name: 'damage_dealt') required final int damageDealt,
      @JsonKey(name: 'attack_type') required final String attackType,
      @JsonKey(name: 'dps_category') required final String dpsCategory,
      required final String enemy,
      @JsonKey(name: 'enemy_lv') required final int enemyLevel,
      required final bool stunned,
      @JsonKey(name: 'food_used') required final bool food,
      required final String region,
      @JsonKey(name: 'game_version') required final String gameVersion,
      @JsonKey(name: 'abyss_version') final String? abyssVersion,
      @JsonKey(name: 'abyss_floor') final String? abyssFloor,
      @JsonKey(name: 'video_link') required final String videolink,
      required final bool approved,
      required final String notes,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(name: 'last_modified_by') final String? lastModifiedBy,
      @JsonKey(name: 'updated_at') final DateTime? updatedAt,
      final String? accountSnapshot,
      @JsonKey(name: 'video_metadata')
      final Map<String, dynamic>? videoMetadata}) = _$DPSFeedImpl;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  Competitor get competitor;
  @JsonKey(name: 'team')
  List<String?> get team;
  @JsonKey(name: 'dps_character')
  String get dpsCharacter;
  @JsonKey(name: 'dps_character_element')
  String? get dpsCharElement;
  @JsonKey(name: 'character_ceiling')
  CharacterCeiling get characterCeiling;
  @JsonKey(name: 'damage_dealt')
  int get damageDealt;
  @JsonKey(name: 'attack_type')
  String get attackType;
  @JsonKey(name: 'dps_category')
  String get dpsCategory;
  String get enemy;
  @JsonKey(name: 'enemy_lv')
  int get enemyLevel;
  bool get stunned;
  @JsonKey(name: 'food_used')
  bool get food;
  @override
  String get region;
  @override
  @JsonKey(name: 'game_version')
  String get gameVersion;
  @override
  @JsonKey(name: 'abyss_version')
  String? get abyssVersion;
  @JsonKey(name: 'abyss_floor')
  String? get abyssFloor;
  @override
  @JsonKey(name: 'video_link')
  String get videolink;
  @override
  bool get approved;
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
  String? get accountSnapshot;
  @JsonKey(name: 'video_metadata')
  Map<String, dynamic>? get videoMetadata;

  /// Create a copy of Feed
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DPSFeedImplCopyWith<_$DPSFeedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SpeedrunFeedImplCopyWith<$Res>
    implements $FeedCopyWith<$Res> {
  factory _$$SpeedrunFeedImplCopyWith(
          _$SpeedrunFeedImpl value, $Res Function(_$SpeedrunFeedImpl) then) =
      __$$SpeedrunFeedImplCopyWithImpl<$Res>;
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
class __$$SpeedrunFeedImplCopyWithImpl<$Res>
    extends _$FeedCopyWithImpl<$Res, _$SpeedrunFeedImpl>
    implements _$$SpeedrunFeedImplCopyWith<$Res> {
  __$$SpeedrunFeedImplCopyWithImpl(
      _$SpeedrunFeedImpl _value, $Res Function(_$SpeedrunFeedImpl) _then)
      : super(_value, _then);

  /// Create a copy of Feed
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
    return _then(_$SpeedrunFeedImpl(
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
class _$SpeedrunFeedImpl implements SpeedrunFeed {
  const _$SpeedrunFeedImpl(
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
    return 'Feed.speedrun(id: $id, competitor: $competitor, team1: $team1, team2: $team2, region: $region, gameVersion: $gameVersion, abyssVersion: $abyssVersion, videolink: $videolink, approved: $approved, speedrunCategory: $speedrunCategory, speedrunSubcategory: $speedrunSubcategory, notes: $notes, createdAt: $createdAt, lastModifiedBy: $lastModifiedBy, updatedAt: $updatedAt, time: $time, accountSnapshot: $accountSnapshot, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpeedrunFeedImpl &&
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

  /// Create a copy of Feed
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SpeedrunFeedImplCopyWith<_$SpeedrunFeedImpl> get copyWith =>
      __$$SpeedrunFeedImplCopyWithImpl<_$SpeedrunFeedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            @JsonKey(name: '_id') String id,
            Competitor competitor,
            @JsonKey(name: 'team') List<String?> team,
            @JsonKey(name: 'dps_character') String dpsCharacter,
            @JsonKey(name: 'dps_character_element') String? dpsCharElement,
            @JsonKey(name: 'character_ceiling')
            CharacterCeiling characterCeiling,
            @JsonKey(name: 'damage_dealt') int damageDealt,
            @JsonKey(name: 'attack_type') String attackType,
            @JsonKey(name: 'dps_category') String dpsCategory,
            String enemy,
            @JsonKey(name: 'enemy_lv') int enemyLevel,
            bool stunned,
            @JsonKey(name: 'food_used') bool food,
            String region,
            @JsonKey(name: 'game_version') String gameVersion,
            @JsonKey(name: 'abyss_version') String? abyssVersion,
            @JsonKey(name: 'abyss_floor') String? abyssFloor,
            @JsonKey(name: 'video_link') String videolink,
            bool approved,
            String notes,
            @JsonKey(name: 'created_at') DateTime? createdAt,
            @JsonKey(name: 'last_modified_by') String? lastModifiedBy,
            @JsonKey(name: 'updated_at') DateTime? updatedAt,
            String? accountSnapshot,
            @JsonKey(name: 'video_metadata')
            Map<String, dynamic>? videoMetadata)
        dps,
    required TResult Function(
            @JsonKey(name: '_id') String id,
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
            List<String>? tags)
        speedrun,
  }) {
    return speedrun(
        id,
        competitor,
        team1,
        team2,
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
        tags);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            @JsonKey(name: '_id') String id,
            Competitor competitor,
            @JsonKey(name: 'team') List<String?> team,
            @JsonKey(name: 'dps_character') String dpsCharacter,
            @JsonKey(name: 'dps_character_element') String? dpsCharElement,
            @JsonKey(name: 'character_ceiling')
            CharacterCeiling characterCeiling,
            @JsonKey(name: 'damage_dealt') int damageDealt,
            @JsonKey(name: 'attack_type') String attackType,
            @JsonKey(name: 'dps_category') String dpsCategory,
            String enemy,
            @JsonKey(name: 'enemy_lv') int enemyLevel,
            bool stunned,
            @JsonKey(name: 'food_used') bool food,
            String region,
            @JsonKey(name: 'game_version') String gameVersion,
            @JsonKey(name: 'abyss_version') String? abyssVersion,
            @JsonKey(name: 'abyss_floor') String? abyssFloor,
            @JsonKey(name: 'video_link') String videolink,
            bool approved,
            String notes,
            @JsonKey(name: 'created_at') DateTime? createdAt,
            @JsonKey(name: 'last_modified_by') String? lastModifiedBy,
            @JsonKey(name: 'updated_at') DateTime? updatedAt,
            String? accountSnapshot,
            @JsonKey(name: 'video_metadata')
            Map<String, dynamic>? videoMetadata)?
        dps,
    TResult? Function(
            @JsonKey(name: '_id') String id,
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
            List<String>? tags)?
        speedrun,
  }) {
    return speedrun?.call(
        id,
        competitor,
        team1,
        team2,
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
        tags);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            @JsonKey(name: '_id') String id,
            Competitor competitor,
            @JsonKey(name: 'team') List<String?> team,
            @JsonKey(name: 'dps_character') String dpsCharacter,
            @JsonKey(name: 'dps_character_element') String? dpsCharElement,
            @JsonKey(name: 'character_ceiling')
            CharacterCeiling characterCeiling,
            @JsonKey(name: 'damage_dealt') int damageDealt,
            @JsonKey(name: 'attack_type') String attackType,
            @JsonKey(name: 'dps_category') String dpsCategory,
            String enemy,
            @JsonKey(name: 'enemy_lv') int enemyLevel,
            bool stunned,
            @JsonKey(name: 'food_used') bool food,
            String region,
            @JsonKey(name: 'game_version') String gameVersion,
            @JsonKey(name: 'abyss_version') String? abyssVersion,
            @JsonKey(name: 'abyss_floor') String? abyssFloor,
            @JsonKey(name: 'video_link') String videolink,
            bool approved,
            String notes,
            @JsonKey(name: 'created_at') DateTime? createdAt,
            @JsonKey(name: 'last_modified_by') String? lastModifiedBy,
            @JsonKey(name: 'updated_at') DateTime? updatedAt,
            String? accountSnapshot,
            @JsonKey(name: 'video_metadata')
            Map<String, dynamic>? videoMetadata)?
        dps,
    TResult Function(
            @JsonKey(name: '_id') String id,
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
            List<String>? tags)?
        speedrun,
    required TResult orElse(),
  }) {
    if (speedrun != null) {
      return speedrun(
          id,
          competitor,
          team1,
          team2,
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
          tags);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DPSFeed value) dps,
    required TResult Function(SpeedrunFeed value) speedrun,
  }) {
    return speedrun(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DPSFeed value)? dps,
    TResult? Function(SpeedrunFeed value)? speedrun,
  }) {
    return speedrun?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DPSFeed value)? dps,
    TResult Function(SpeedrunFeed value)? speedrun,
    required TResult orElse(),
  }) {
    if (speedrun != null) {
      return speedrun(this);
    }
    return orElse();
  }
}

abstract class SpeedrunFeed implements Feed, SpeedrunProperties {
  const factory SpeedrunFeed(
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
      final List<String>? tags}) = _$SpeedrunFeedImpl;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  Competitor get competitor;
  @JsonKey(name: 'team_1')
  List<String?> get team1;
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
  @JsonKey(name: 'speedrun_category')
  String get speedrunCategory;
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
  int get time;
  @override
  String? get accountSnapshot;
  List<String>? get tags;

  /// Create a copy of Feed
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SpeedrunFeedImplCopyWith<_$SpeedrunFeedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
