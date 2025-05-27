import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tgh_mobile/imports.dart';

part 'speedrun.freezed.dart';
part 'speedrun.g.dart';

@freezed
class SpeedrunSubmit with _$SpeedrunSubmit {
  @JsonSerializable(explicitToJson: true, includeIfNull: false)
  const factory SpeedrunSubmit({
    @JsonKey(name: 'account_uid') required String accountUid,
    required String alias,
    @JsonKey(name: 'discord_tag') required String discordTag,
    @JsonKey(name: 'game_version') required String gameVersion,
    @JsonKey(name: 'abyss_version') required String abyssVersion,
    @Default('') String notes,
    required String region,
    @JsonKey(name: 'speedrun_category') required String speedrunCategory,
    @JsonKey(name: 'speedrun_subcategory') required String speedrunSubcategory,
    @JsonKey(name: 'video_link') required String videolink,
    @Default(0) int time,
    @JsonKey(name: 'video_segment') @Default([]) List<String> videoSegment,
    @JsonKey(name: 'team_1') @Default([]) List<String?> team1,
    @JsonKey(name: 'team_2') @Default([]) List<String?>? team2,
    @Default(false) bool approved,
    @JsonKey(name: 'create_snapshot') @Default(true) bool createSnapshot,
    @JsonKey(name: 'deleted_at') DateTime? deletedAt,
  }) = _SpeedrunSubmit;

  factory SpeedrunSubmit.fromJson(Map<String, dynamic> json) => _$SpeedrunSubmitFromJson(json);
}

@freezed
class SpeedrunSubmitResponse with _$SpeedrunSubmitResponse {
  @JsonSerializable(explicitToJson: true, includeIfNull: false)
  const factory SpeedrunSubmitResponse({
    @JsonKey(name: '_id') required String id,
    required String competitor,
    @JsonKey(name: 'team_1') required List<String?> team1,
    @JsonKey(name: 'team_2') List<String?>? team2,
    required String region,
    @JsonKey(name: 'game_version') required String gameVersion,
    @JsonKey(name: 'abyss_version') String? abyssVersion,
    @JsonKey(name: 'video_link') required String videolink,
    @JsonKey(name: 'video_segment') List<String>? videoSegment,
    required bool approved,
    @JsonKey(name: 'speedrun_category') required String speedrunCategory,
    @JsonKey(name: 'speedrun_subcategory') String? speedrunSubcategory,
    @JsonKey(name: 'notes') String? notes,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'last_modified_by') String? lastModifiedBy,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    required int time,
    AccountSnapshot? accountSnapshot,
    List<String>? tags,
  }) = _SpeedrunSubmitResponse;

  factory SpeedrunSubmitResponse.fromJson(Map<String, dynamic> json) => _$SpeedrunSubmitResponseFromJson(json);
}
