import 'package:freezed_annotation/freezed_annotation.dart';

part 'accountsnapshot.freezed.dart';
part 'accountsnapshot.g.dart';

@freezed
class AccountSnapshot with _$AccountSnapshot {
  const factory AccountSnapshot({
    @JsonKey(name: '_id') required String id,
    required String competitor,
    required int level,
    required String signature,
    @JsonKey(name: 'world_level') required int worldLevel,
    @JsonKey(name: 'achievement_count') required int achievementCount,
    int? ttl,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'last_modified_by') String? lastModifiedBy,
  }) = _AccountSnapshot;

  factory AccountSnapshot.fromJson(Map<String, dynamic> json) => _$AccountSnapshotFromJson(json);
}
