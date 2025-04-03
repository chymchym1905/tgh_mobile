// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dps.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DPS _$DPSFromJson(Map<String, dynamic> json) {
  return _DPS.fromJson(json);
}

/// @nodoc
mixin _$DPS {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  Competitor get competitor => throw _privateConstructorUsedError;
  @JsonKey(name: 'team')
  List<String?> get team => throw _privateConstructorUsedError;
  @JsonKey(name: 'dps_character')
  String get dpsCharacter => throw _privateConstructorUsedError;
  @JsonKey(name: 'dps_character_element')
  String? get dpsCharElement => throw _privateConstructorUsedError;
  @JsonKey(name: 'character_ceiling')
  CharacterCeiling get characterCeiling => throw _privateConstructorUsedError;
  @JsonKey(name: 'damage_dealt')
  int get damageDealt => throw _privateConstructorUsedError;
  @JsonKey(name: 'attack_type')
  String get attackType => throw _privateConstructorUsedError;
  @JsonKey(name: 'dps_category')
  String get dpsCategory => throw _privateConstructorUsedError;
  String get enemy => throw _privateConstructorUsedError;
  @JsonKey(name: 'enemy_lv')
  int get enemyLevel => throw _privateConstructorUsedError;
  bool get stunned => throw _privateConstructorUsedError;
  @JsonKey(name: 'food_used')
  bool get food => throw _privateConstructorUsedError;
  String get region => throw _privateConstructorUsedError;
  @JsonKey(name: 'game_version')
  String get gameVersion => throw _privateConstructorUsedError;
  @JsonKey(name: 'abyss_version')
  String? get abyssVersion => throw _privateConstructorUsedError;
  @JsonKey(name: 'abyss_floor')
  String? get abyssFloor => throw _privateConstructorUsedError;
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

  /// Serializes this DPS to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DPS
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DPSCopyWith<DPS> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DPSCopyWith<$Res> {
  factory $DPSCopyWith(DPS value, $Res Function(DPS) then) =
      _$DPSCopyWithImpl<$Res, DPS>;
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
      String? accountSnapshot});

  $CompetitorCopyWith<$Res> get competitor;
  $CharacterCeilingCopyWith<$Res> get characterCeiling;
}

/// @nodoc
class _$DPSCopyWithImpl<$Res, $Val extends DPS> implements $DPSCopyWith<$Res> {
  _$DPSCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DPS
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
      team: null == team
          ? _value.team
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
    ) as $Val);
  }

  /// Create a copy of DPS
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CompetitorCopyWith<$Res> get competitor {
    return $CompetitorCopyWith<$Res>(_value.competitor, (value) {
      return _then(_value.copyWith(competitor: value) as $Val);
    });
  }

  /// Create a copy of DPS
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CharacterCeilingCopyWith<$Res> get characterCeiling {
    return $CharacterCeilingCopyWith<$Res>(_value.characterCeiling, (value) {
      return _then(_value.copyWith(characterCeiling: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DPSImplCopyWith<$Res> implements $DPSCopyWith<$Res> {
  factory _$$DPSImplCopyWith(_$DPSImpl value, $Res Function(_$DPSImpl) then) =
      __$$DPSImplCopyWithImpl<$Res>;
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
      String? accountSnapshot});

  @override
  $CompetitorCopyWith<$Res> get competitor;
  @override
  $CharacterCeilingCopyWith<$Res> get characterCeiling;
}

/// @nodoc
class __$$DPSImplCopyWithImpl<$Res> extends _$DPSCopyWithImpl<$Res, _$DPSImpl>
    implements _$$DPSImplCopyWith<$Res> {
  __$$DPSImplCopyWithImpl(_$DPSImpl _value, $Res Function(_$DPSImpl) _then)
      : super(_value, _then);

  /// Create a copy of DPS
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
  }) {
    return _then(_$DPSImpl(
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
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$DPSImpl implements _DPS {
  const _$DPSImpl(
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
      this.accountSnapshot})
      : _team = team;

  factory _$DPSImpl.fromJson(Map<String, dynamic> json) =>
      _$$DPSImplFromJson(json);

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

  @override
  String toString() {
    return 'DPS(id: $id, competitor: $competitor, team: $team, dpsCharacter: $dpsCharacter, dpsCharElement: $dpsCharElement, characterCeiling: $characterCeiling, damageDealt: $damageDealt, attackType: $attackType, dpsCategory: $dpsCategory, enemy: $enemy, enemyLevel: $enemyLevel, stunned: $stunned, food: $food, region: $region, gameVersion: $gameVersion, abyssVersion: $abyssVersion, abyssFloor: $abyssFloor, videolink: $videolink, approved: $approved, notes: $notes, createdAt: $createdAt, lastModifiedBy: $lastModifiedBy, updatedAt: $updatedAt, accountSnapshot: $accountSnapshot)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DPSImpl &&
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
                other.accountSnapshot == accountSnapshot));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
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
        accountSnapshot
      ]);

  /// Create a copy of DPS
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DPSImplCopyWith<_$DPSImpl> get copyWith =>
      __$$DPSImplCopyWithImpl<_$DPSImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DPSImplToJson(
      this,
    );
  }
}

abstract class _DPS implements DPS {
  const factory _DPS(
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
      final String? accountSnapshot}) = _$DPSImpl;

  factory _DPS.fromJson(Map<String, dynamic> json) = _$DPSImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  Competitor get competitor;
  @override
  @JsonKey(name: 'team')
  List<String?> get team;
  @override
  @JsonKey(name: 'dps_character')
  String get dpsCharacter;
  @override
  @JsonKey(name: 'dps_character_element')
  String? get dpsCharElement;
  @override
  @JsonKey(name: 'character_ceiling')
  CharacterCeiling get characterCeiling;
  @override
  @JsonKey(name: 'damage_dealt')
  int get damageDealt;
  @override
  @JsonKey(name: 'attack_type')
  String get attackType;
  @override
  @JsonKey(name: 'dps_category')
  String get dpsCategory;
  @override
  String get enemy;
  @override
  @JsonKey(name: 'enemy_lv')
  int get enemyLevel;
  @override
  bool get stunned;
  @override
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
  @override
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

  /// Create a copy of DPS
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DPSImplCopyWith<_$DPSImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
