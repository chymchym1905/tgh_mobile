import 'package:freezed_annotation/freezed_annotation.dart';
import '../competitor/competitor.dart';

part 'speedrun.freezed.dart';
part 'speedrun.g.dart';

abstract class SpeedrunProperties {
  String get id;
  Competitor get competitor;
  List<String?> get team1;
  List<String?>? get team2;
  String get region;
  String get gameVersion;
  String? get abyssVersion;
  String get videolink;
  bool get approved;
  String get speedrunCategory;
  String? get speedrunSubcategory;
  String? get notes;
  DateTime? get createdAt;
  String? get lastModifiedBy;
  DateTime? get updatedAt;
  int get time;
  String? get accountSnapshot;
  List<String>? get tags;
}

@freezed
class Speedrun with _$Speedrun implements SpeedrunProperties {
  @JsonSerializable(explicitToJson: true)
  const factory Speedrun({
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
  }) = _Speedrun;

  factory Speedrun.fromJson(Map<String, dynamic> json) => _$SpeedrunFromJson(json);
}
