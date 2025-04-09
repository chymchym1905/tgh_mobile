import 'package:freezed_annotation/freezed_annotation.dart';

part 'character.freezed.dart';
part 'character.g.dart';

@freezed
class Character with _$Character {
  const factory Character({
    required String name,
    required String element,
    String? avatar,
    @JsonKey(name: 'normal_attack_talent') String? normalAttackTalent,
    @JsonKey(name: 'elemental_skill_talent') String? elementalSkillTalent,
    @JsonKey(name: 'elemental_burst_talent') String? elementalBurstTalent,
    @JsonKey(name: 'ascension_1_passive') String? a1Passive,
    @JsonKey(name: 'ascension_4_passive') String? a4Passive,
    @JsonKey(name: 'constellation_1') String? c1,
    @JsonKey(name: 'constellation_2') String? c2,
    @JsonKey(name: 'constellation_3') String? c3,
    @JsonKey(name: 'constellation_4') String? c4,
    @JsonKey(name: 'constellation_5') String? c5,
    @JsonKey(name: 'constellation_6') String? c6,
  }) = _Character;

  factory Character.fromJson(Map<String, dynamic> json) => _$CharacterFromJson(json);
}
