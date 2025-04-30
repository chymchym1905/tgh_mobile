import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tgh_mobile/shared/data_model/user_profile_info/character_usage/character_usage.dart';

import 'accountsnapshot/accountsnapshot.dart';
import 'character_snapshot/character_snapshot_all.dart';
import 'ranking/ranking.dart';

part 'userprofileinfo.freezed.dart';
part 'userprofileinfo.g.dart';

class UserProfileInfoConverter implements JsonConverter<UserProfileInfo, Map<String, dynamic>> {
  const UserProfileInfoConverter();

  @override
  UserProfileInfo fromJson(Map<String, dynamic> json) {
    AccountSnapshot? accountSnapshot;
    List<CharacterUsage> characterUsage = [];
    List<CharacterSnapshot> characterSnapshot = [];
    List<RankInfo> rankInfo = [];
    if (json.containsKey('accountSnapshot') && json['accountSnapshot'] != null) {
      accountSnapshot = AccountSnapshot.fromJson(json['accountSnapshot'] as Map<String, dynamic>);
    }
    if (json.containsKey('characterUsage') && json['characterUsage'] != null) {
      characterUsage =
          (json['characterUsage'] as List).map((e) => CharacterUsage.fromJson(e as Map<String, dynamic>)).toList();
    }
    if (json.containsKey('characterSnapshots') && json['characterSnapshots'] != null) {
      characterSnapshot = (json['characterSnapshots'] as List)
          .map((e) => CharacterSnapshot.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    if (json.containsKey('abyssRankings') && json['abyssRankings'] != null) {
      rankInfo = (json['abyssRankings'] as List).map((e) => RankInfo.fromJson(e as Map<String, dynamic>)).toList();
    }

    return UserProfileInfo(
      accountSnapshot: accountSnapshot,
      characterUsage: characterUsage,
      characterSnapshot: characterSnapshot,
      rankInfo: rankInfo,
    );
  }

  @override
  Map<String, dynamic> toJson(UserProfileInfo object) {
    final Map<String, dynamic> json = {
      if (object.accountSnapshot != null) 'accountSnapshot': object.accountSnapshot?.toJson(),
      if (object.characterUsage != null) 'characterUsage': object.characterUsage?.map((e) => e.toJson()).toList(),
      if (object.characterSnapshot != null)
        'characterSnapshots': object.characterSnapshot?.map((e) => e.toJson()).toList(),
      if (object.rankInfo != null) 'abyssRankings': object.rankInfo?.map((e) => e.toJson()).toList(),
    };
    return json;
  }
}

@freezed
class UserProfileInfo with _$UserProfileInfo {
  @JsonSerializable(explicitToJson: true)
  const factory UserProfileInfo({
    List<CharacterUsage>? characterUsage,
    AccountSnapshot? accountSnapshot,
    List<CharacterSnapshot>? characterSnapshot,
    List<RankInfo>? rankInfo,
  }) = _UserProfileInfo;

  factory UserProfileInfo.fromJson(Map<String, dynamic> json) => const UserProfileInfoConverter().fromJson(json);
}
