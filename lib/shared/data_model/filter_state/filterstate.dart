import 'package:freezed_annotation/freezed_annotation.dart';

part 'filterstate.freezed.dart';
part 'filterstate.g.dart';

@freezed
class SpeedrunFilterStorage with _$SpeedrunFilterStorage {
  const factory SpeedrunFilterStorage(
      {required Map<String, dynamic> appliedFilter,
      required Map<String, dynamic> rawFilter,
      required Map<String, dynamic> defaultAppliedFilter,
      required Map<String, dynamic> defaultFitlerValuesAbyss,
      required Map<String, dynamic> defaultFitlerValuesDomain,
      required Map<String, dynamic> defaultFitlerValuesEvent,
      required Map<String, dynamic> defaultFitlerValuesWeeklyBoss,
      required Map<String, dynamic> defaultFitlerValuesWorldBoss}) = _FilterStorage;

  factory SpeedrunFilterStorage.fromJson(Map<String, dynamic> json) => _$SpeedrunFilterStorageFromJson(json);
}

@freezed
class DpsFilterStorage with _$DpsFilterStorage {
  const factory DpsFilterStorage({
    required Map<String, dynamic> appliedFilter,
    required Map<String, dynamic> rawFilter,
    required Map<String, dynamic> defaultAppliedFilter,
    required Map<String, dynamic> defaultFitlerValuesOverworld,
    required Map<String, dynamic> defaultFitlerValuesWeeklyBoss,
    required Map<String, dynamic> defaultFitlerValuesWorldBoss,
    required Map<String, dynamic> defaultFitlerValuesReputationBounty,
    required Map<String, dynamic> defaultFitlerValuesEvent,
    required Map<String, dynamic> defaultFitlerValuesAbyss,
    required Map<String, dynamic> defaultFitlerValuesDomain,
  }) = _DpsFilterStorage;

  factory DpsFilterStorage.fromJson(Map<String, dynamic> json) => _$DpsFilterStorageFromJson(json);
}
