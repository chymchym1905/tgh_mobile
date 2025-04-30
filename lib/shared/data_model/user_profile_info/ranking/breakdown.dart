import 'package:freezed_annotation/freezed_annotation.dart';

part 'breakdown.freezed.dart';
part 'breakdown.g.dart';

@freezed
class Chamber with _$Chamber {
  const factory Chamber(
      {required double score, required int rank, @JsonKey(name: 'video_link') required String videoLink}) = _Chamber;

  factory Chamber.fromJson(Map<String, dynamic> json) => _$ChamberFromJson(json);
}

@freezed
class Breakdown with _$Breakdown {
  @JsonSerializable(explicitToJson: true)
  const factory Breakdown({
    Chamber? chamber12_1_1,
    Chamber? chamber12_1_2,
    Chamber? chamber12_2_1,
    Chamber? chamber12_2_2,
    Chamber? chamber12_3_1,
    Chamber? chamber12_3_2,
  }) = _Breakdown;

  factory Breakdown.fromJson(Map<String, dynamic> json) => const BreakDownConverter().fromJson(json);
}

class BreakDownConverter implements JsonConverter<Breakdown, Map<String, dynamic>> {
  const BreakDownConverter();

  @override
  Breakdown fromJson(Map<String, dynamic> json) {
    Chamber? chamber12_1_1;
    Chamber? chamber12_1_2;
    Chamber? chamber12_2_1;
    Chamber? chamber12_2_2;
    Chamber? chamber12_3_1;
    Chamber? chamber12_3_2;

    if (json.containsKey('12-1-1')) {
      chamber12_1_1 = Chamber.fromJson(json['12-1-1'] as Map<String, dynamic>);
    }
    if (json.containsKey('12-1-2')) {
      chamber12_1_2 = Chamber.fromJson(json['12-1-2'] as Map<String, dynamic>);
    }
    if (json.containsKey('12-2-1')) {
      chamber12_2_1 = Chamber.fromJson(json['12-2-1'] as Map<String, dynamic>);
    }
    if (json.containsKey('12-2-2')) {
      chamber12_2_2 = Chamber.fromJson(json['12-2-2'] as Map<String, dynamic>);
    }
    if (json.containsKey('12-3-1')) {
      chamber12_3_1 = Chamber.fromJson(json['12-3-1'] as Map<String, dynamic>);
    }
    if (json.containsKey('12-3-2')) {
      chamber12_3_2 = Chamber.fromJson(json['12-3-2'] as Map<String, dynamic>);
    }

    return Breakdown(
      chamber12_1_1: chamber12_1_1,
      chamber12_1_2: chamber12_1_2,
      chamber12_2_1: chamber12_2_1,
      chamber12_2_2: chamber12_2_2,
      chamber12_3_1: chamber12_3_1,
      chamber12_3_2: chamber12_3_2,
    );
  }

  @override
  Map<String, dynamic> toJson(Breakdown object) {
    final Map<String, dynamic> json = {};
    if (object.chamber12_1_1 != null) {
      json['12-1-1'] = object.chamber12_1_1!.toJson();
    }
    if (object.chamber12_1_2 != null) {
      json['12-1-2'] = object.chamber12_1_2!.toJson();
    }
    if (object.chamber12_2_1 != null) {
      json['12-2-1'] = object.chamber12_2_1!.toJson();
    }
    if (object.chamber12_2_2 != null) {
      json['12-2-2'] = object.chamber12_2_2!.toJson();
    }
    if (object.chamber12_3_1 != null) {
      json['12-3-1'] = object.chamber12_3_1!.toJson();
    }
    if (object.chamber12_3_2 != null) {
      json['12-3-2'] = object.chamber12_3_2!.toJson();
    }
    return json;
  }
}
