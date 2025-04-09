import 'package:freezed_annotation/freezed_annotation.dart';

part 'artifact.freezed.dart';
part 'artifact.g.dart';

@freezed
class Artifact with _$Artifact {
  const factory Artifact({String? setName, required int rarity, required String slot, required String icon}) =
      _Artifact;

  factory Artifact.fromJson(Map<String, dynamic> json) => _$ArtifactFromJson(json);
}
