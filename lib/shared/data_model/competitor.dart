import 'package:freezed_annotation/freezed_annotation.dart';

part 'competitor.freezed.dart';
part 'competitor.g.dart';

@freezed
class Competitor with _$Competitor {
  const factory Competitor({
    @JsonKey(name: '_id') required String id,
    @JsonKey(name: 'discord_tag') String? discordtag,
    required String alias,
    @JsonKey(name: 'account_uid') int? uid,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'last_modified_by') String? lastModifiedBy,
    bool? dpser,
    bool? speedrunner,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _Competitor;

  factory Competitor.fromJson(Map<String, dynamic> json) => _$CompetitorFromJson(json);
}
