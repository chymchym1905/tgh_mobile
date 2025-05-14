import 'package:freezed_annotation/freezed_annotation.dart';

import '../index.dart';

part 'speedrun_lb_spot.freezed.dart';
part 'speedrun_lb_spot.g.dart';

@freezed
class SpeedrunLbSpot with _$SpeedrunLbSpot {
  const factory SpeedrunLbSpot({
    @JsonKey(name: '_id') required String id,
    String? alias,
    required Breakdown breakdown,
    required Competitor competitor,
    @JsonKey(name: 'instance_id') required String instanceId,
    required double points,
    @JsonKey(name: 'previous_rank') int? previousRank,
    required int rank,
    String? region,
  }) = _SpeedrunLbSpot;

  factory SpeedrunLbSpot.fromJson(Map<String, dynamic> json) => _$SpeedrunLbSpotFromJson(json);
}

@freezed
class SpeedrunLeaderboardBoard with _$SpeedrunLeaderboardBoard {
  const factory SpeedrunLeaderboardBoard({
    @JsonKey(name: '_id') required String id,
    @JsonKey(name: 'instance_id') required String instanceId,
    @JsonKey(name: 'speedrun_category') required String speedrunCategory,
    @JsonKey(name: 'abyss_version') required String abyssVersion,
    @JsonKey(name: 'speedrun_subcategories') required List<String> speedrunSubcategories,
    @JsonKey(name: 'last_synced_at') DateTime? lastSyncedAt,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'last_modified_by') String? lastModifiedBy,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _SpeedrunLeaderboardBoard;

  factory SpeedrunLeaderboardBoard.fromJson(Map<String, dynamic> json) => _$SpeedrunLeaderboardBoardFromJson(json);
}
