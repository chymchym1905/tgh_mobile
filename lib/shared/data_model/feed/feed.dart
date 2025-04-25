import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tgh_mobile/shared/exception.dart';
import '../character_ceiling/character_ceiling.dart';
import '../competitor/competitor.dart';
import '../dps/dps.dart';
import '../speedrun/speedrun.dart';
import '../video_metadata/video_metadata.dart';
part 'feed.freezed.dart';
part 'feed.g.dart';

class FeedConverter implements JsonConverter<Feed, Map<String, dynamic>> {
  const FeedConverter();

  @override
  Feed fromJson(Map<String, dynamic> json) {
    // Use 'time' field to determine if it's a speedrun entry
    if (json.containsKey('time')) {
      return SpeedrunFeed.fromJson(json);
    }
    // Use 'dps_character' field to determine if it's a DPS entry
    else if (json.containsKey('dps_character')) {
      return DPSFeed.fromJson(json);
    }
    throw Exception('Cannot determine the type of Feed from json $json');
  }

  @override
  Map<String, dynamic> toJson(Feed feed) => feed.toJson();
}

@freezed
class Feed with _$Feed {
  const Feed._();
  @JsonSerializable(explicitToJson: true)
  @Implements<DPSProperties>()
  const factory Feed.dps({
    @JsonKey(name: '_id') required String id,
    required Competitor competitor,
    @JsonKey(name: 'team') required List<String?> team,
    @JsonKey(name: 'dps_character') required String dpsCharacter,
    @JsonKey(name: 'dps_character_element') String? dpsCharElement,
    @JsonKey(name: 'character_ceiling') required CharacterCeiling characterCeiling,
    @JsonKey(name: 'damage_dealt') required int damageDealt,
    @JsonKey(name: 'attack_type') required String attackType,
    @JsonKey(name: 'dps_category') required String dpsCategory,
    required String enemy,
    @JsonKey(name: 'enemy_lv') required int enemyLevel,
    required bool stunned,
    @JsonKey(name: 'food_used') required bool food,
    required String region,
    @JsonKey(name: 'game_version') required String gameVersion,
    @JsonKey(name: 'abyss_version') String? abyssVersion,
    @JsonKey(name: 'abyss_floor') String? abyssFloor,
    @JsonKey(name: 'video_link') required String videolink,
    required bool approved,
    @JsonKey(name: 'notes') String? notes,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'last_modified_by') String? lastModifiedBy,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    String? accountSnapshot,
    @JsonKey(name: 'video_metadata') VideoMetadata? videoMetadata,
  }) = DPSFeed;

  @JsonSerializable(explicitToJson: true)
  @Implements<SpeedrunProperties>()
  const factory Feed.speedrun({
    @JsonKey(name: '_id') required String id,
    required Competitor competitor,
    @JsonKey(name: 'team_1') required List<String?> team1,
    @JsonKey(name: 'team_2') List<String?>? team2,
    required String region,
    @JsonKey(name: 'game_version') required String gameVersion,
    @JsonKey(name: 'abyss_version') String? abyssVersion,
    @JsonKey(name: 'video_link') required String videolink,
    required bool approved,
    @JsonKey(name: 'speedrun_category') required String speedrunCategory,
    @JsonKey(name: 'speedrun_subcategory') String? speedrunSubcategory,
    @JsonKey(name: 'notes') String? notes,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'last_modified_by') String? lastModifiedBy,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    required int time,
    String? accountSnapshot,
    List<String>? tags,
    @JsonKey(name: 'video_metadata') VideoMetadata? videoMetadata,
  }) = SpeedrunFeed;

  factory Feed.fromJson(Map<String, dynamic> json) => const FeedConverter().fromJson(json);
  @override
  String toString() {
    return map(
      dps: (feed) => 'DPSFeed(Competitor: ${feed.competitor.alias}, url: ${feed.videolink})',
      speedrun: (feed) => 'SpeedrunFeed(Competitor: ${feed.competitor.alias}, url: ${feed.videolink})',
    );
  }
}

@freezed
class FeedState with _$FeedState {
  const FeedState._();
  const factory FeedState.loading() = FeedStateLoading;
  const factory FeedState.loaded(List<List<Feed>> feedLists, List<int> pages) = FeedStateLoaded;
  const factory FeedState.error(AppException exception) = FeedStateError;

  @override
  String toString() {
    return map(
      loading: (_) => 'FeedState.Loading',
      loaded: (state) =>
          'FeedState.Loaded(pages: ${state.pages.length}, items: ${state.feedLists.map((list) => list.length).join('+')})',
      error: (state) => 'FeedState.Error(${state.exception})',
    );
  }
}
