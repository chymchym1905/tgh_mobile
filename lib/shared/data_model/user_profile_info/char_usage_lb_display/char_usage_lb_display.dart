import 'package:freezed_annotation/freezed_annotation.dart';

import '../character_usage/character_usage.dart';

part 'char_usage_lb_display.freezed.dart';
part 'char_usage_lb_display.g.dart';

@freezed
class CharUsageLbDisplay with _$CharUsageLbDisplay {
  const CharUsageLbDisplay._();
  @JsonSerializable(explicitToJson: true)
  const factory CharUsageLbDisplay(
      {@JsonKey(name: 'competitor') required String competitorId,
      @JsonKey(name: 'characterUsage') required List<CharacterUsage> characterUsage}) = _CharUsageLbDisplay;

  factory CharUsageLbDisplay.fromJson(Map<String, dynamic> json) => _$CharUsageLbDisplayFromJson(json);

  @override
  String toString() {
    return 'CharUsageLbDisplay(competitorId: $competitorId, Number of characters used: ${characterUsage.length})';
  }
}
