import 'package:freezed_annotation/freezed_annotation.dart';
import '../../competitor/competitor.dart';
import 'breakdown.dart';

part 'ranking.freezed.dart';
part 'ranking.g.dart';

@freezed
class RankInfo with _$RankInfo {
  @JsonSerializable(explicitToJson: true)
  const factory RankInfo({required String version, required PerformanceDetail rank}) = _RankInfo;

  factory RankInfo.fromJson(Map<String, dynamic> json) => _$RankInfoFromJson(json);
}

@freezed
class PerformanceDetail with _$PerformanceDetail {
  @JsonSerializable(explicitToJson: true)
  const factory PerformanceDetail(
      {@JsonKey(name: '_id') required String id,
      @JsonKey(name: 'instance_id') required String instanceId,
      required Competitor competitor,
      required String alias,
      required String region,
      required String points,
      required Breakdown breakdown,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'last_modified_by') String? lastModifiedBy}) = _PerformanceDetail;

  factory PerformanceDetail.fromJson(Map<String, dynamic> json) => _$PerformanceDetailFromJson(json);
}
