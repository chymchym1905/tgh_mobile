import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../imports.dart';

part 'leaderboard_filter_notifier.g.dart';

@riverpod
class SpeedrunLeaderboardFilterNotifier extends _$SpeedrunLeaderboardFilterNotifier {
  static final String _defaultValueSpeedrunCategory = SPEEDRUN_CATEGORY_ORDER.first;
  static final String _defaultValueAbyssVersion = ABYSS_VERSION_HISTORY.last;
  static const String? _defaultValueRegion = null;
  static const CompetitorSearchResult? _defaultValueName = null;
  static const String? _defaultValueFloor = null;
  static final List<String?> _defaultValueCharacters = [];
  static final String _defaultValueDomain = DOMAIN.first;
  static final String _defaultValueEvent = SPEEDRUN_EVENTS.first;
  @override
  SpeedrunFilterStorage build() {
    return SpeedrunFilterStorage(
      appliedFilter: {
        'abyss_version': _defaultValueAbyssVersion,
        'speedrun_category': _defaultValueSpeedrunCategory,
      },
      rawFilter: {
        'abyss_version': _defaultValueAbyssVersion,
        'speedrun_category': _defaultValueSpeedrunCategory,
      },
      defaultAppliedFilter: {
        'Abyss': {
          'abyss_version': _defaultValueAbyssVersion,
          'speedrun_category': 'Abyss',
        },
        'Domain': {
          'speedrun_category': 'Domain',
          'speedrun_subcategory': _defaultValueDomain,
        },
        'Event': {
          'abyss_version': _defaultValueEvent,
          'speedrun_category': 'Event',
        },
        'Weekly Boss': {
          'speedrun_category': 'Weekly Boss',
        },
        'World Boss': {
          'speedrun_category': 'World Boss',
        },
      },
      defaultFitlerValuesAbyss: {
        'abyss_version': _defaultValueAbyssVersion,
        'speedrun_category': 'Abyss',
        'region': _defaultValueRegion,
        'competitor': _defaultValueName,
        'speedrun_subcategory': _defaultValueFloor,
        'characters': _defaultValueCharacters,
      },
      defaultFitlerValuesDomain: {
        'speedrun_category': 'Domain',
        'region': _defaultValueRegion,
        'competitor': _defaultValueName,
        'speedrun_subcategory': _defaultValueDomain,
        'characters': _defaultValueCharacters,
      },
      defaultFitlerValuesEvent: {
        'speedrun_category': 'Event',
        'abyss_version': _defaultValueEvent,
        'region': _defaultValueRegion,
        'competitor': _defaultValueName,
        'characters': _defaultValueCharacters,
      },
      defaultFitlerValuesWeeklyBoss: {
        'speedrun_category': 'Weekly Boss',
        'abyss_version': _defaultValueEvent,
        'region': _defaultValueRegion,
        'competitor': _defaultValueName,
        'characters': _defaultValueCharacters,
      },
      defaultFitlerValuesWorldBoss: {
        'speedrun_category': 'World Boss',
        'abyss_version': _defaultValueEvent,
        'region': _defaultValueRegion,
        'competitor': _defaultValueName,
        'characters': _defaultValueCharacters,
      },
    );
  }

  void updateFilter(Map<String, dynamic> filter) {
    final currState = state;
    final filterCopy = Map<String, dynamic>.from(filter);
    if (filter['competitor'] != null) {
      filterCopy['competitor'] = filter['competitor'].id;
    }
    state = currState.copyWith(appliedFilter: filterCopy, rawFilter: filter);
  }

  void resetFilter() {
    final currState = state;
    final currStateCategory = currState.appliedFilter['speedrun_category'] as String;
    state = currState.copyWith(
        appliedFilter:
            Map<String, dynamic>.from(currState.defaultAppliedFilter[currStateCategory] as Map<String, dynamic>),
        rawFilter:
            Map<String, dynamic>.from(currState.defaultAppliedFilter[currStateCategory] as Map<String, dynamic>));
  }
}

@riverpod
class DpsLeaderboardFilterNotifier extends _$DpsLeaderboardFilterNotifier {
  static final String _defaultValueDpsCategory = DPS_CATEGORY_ORDER.first;
  static const String? _defaultValueAttackType = null;
  static const String? _defaultValueRegion = null;
  static const CompetitorSearchResult? _defaultValueName = null;
  static const String? _defaultValueDpsCharacter = null;
  static const String? _defaultValueEnemy = null;
  static const String? _defaultValueDomain = null;
  static const String? _defaultValueEvent = null;
  @override
  DpsFilterStorage build() {
    return DpsFilterStorage(
      appliedFilter: {
        'dps_category': _defaultValueDpsCategory,
      },
      rawFilter: {
        'dps_category': _defaultValueDpsCategory,
      },
      defaultAppliedFilter: {
        'Overworld': {
          'dps_category': 'Overworld',
        },
        'Weekly Boss': {
          'dps_category': 'Weekly Boss',
        },
        'World Boss': {
          'dps_category': 'World Boss',
        },
        'Event': {
          'dps_category': 'Event',
        },
        'Abyss': {
          'dps_category': 'Abyss',
        },
        'Reputation Bounty': {
          'dps_category': 'Reputation Bounty',
        },
      },
      defaultFitlerValuesOverworld: {
        'dps_category': 'Overworld',
        'attack_type': _defaultValueAttackType,
        'region': _defaultValueRegion,
        'competitor': _defaultValueName,
        'dps_character': _defaultValueDpsCharacter,
        'enemy': _defaultValueEnemy,
      },
      defaultFitlerValuesWeeklyBoss: {
        'dps_category': 'Weekly Boss',
        'attack_type': _defaultValueAttackType,
        'region': _defaultValueRegion,
        'competitor': _defaultValueName,
        'dps_character': _defaultValueDpsCharacter,
        'enemy': _defaultValueEnemy,
      },
      defaultFitlerValuesWorldBoss: {
        'dps_category': 'World Boss',
        'attack_type': _defaultValueAttackType,
        'region': _defaultValueRegion,
        'competitor': _defaultValueName,
        'dps_character': _defaultValueDpsCharacter,
        'enemy': _defaultValueEnemy,
      },
      defaultFitlerValuesEvent: {
        'dps_category': 'Event',
        'attack_type': _defaultValueAttackType,
        'region': _defaultValueRegion,
        'competitor': _defaultValueName,
        'dps_character': _defaultValueDpsCharacter,
        'event': _defaultValueEvent,
      },
      defaultFitlerValuesAbyss: {
        'dps_category': 'Abyss',
        'attack_type': _defaultValueAttackType,
        'region': _defaultValueRegion,
        'competitor': _defaultValueName,
        'dps_character': _defaultValueDpsCharacter,
        'enemy': _defaultValueEnemy,
      },
      defaultFitlerValuesDomain: {
        'dps_category': 'Domain',
        'attack_type': _defaultValueAttackType,
        'region': _defaultValueRegion,
        'competitor': _defaultValueName,
        'dps_character': _defaultValueDpsCharacter,
        'domain': _defaultValueDomain,
      },
      defaultFitlerValuesReputationBounty: {
        'dps_category': 'Reputation Bounty',
        'attack_type': _defaultValueAttackType,
        'region': _defaultValueRegion,
        'competitor': _defaultValueName,
        'dps_character': _defaultValueDpsCharacter,
        'enemy': _defaultValueEnemy,
      },
    );
  }

  void updateFilter(Map<String, dynamic> filter) {
    final currState = state;
    final filterCopy = Map<String, dynamic>.from(filter);
    if (filter['competitor'] != null) {
      filterCopy['competitor'] = filter['competitor'].id;
    }
    state = currState.copyWith(appliedFilter: filterCopy, rawFilter: filter);
  }

  void resetFilter() {
    final currState = state;
    final currStateCategory = currState.appliedFilter['dps_category'] as String;
    state = currState.copyWith(
        appliedFilter:
            Map<String, dynamic>.from(currState.defaultAppliedFilter[currStateCategory] as Map<String, dynamic>),
        rawFilter:
            Map<String, dynamic>.from(currState.defaultAppliedFilter[currStateCategory] as Map<String, dynamic>));
  }
}

@riverpod
class RestrictedDpsLeaderboardFilterNotifier extends _$RestrictedDpsLeaderboardFilterNotifier {
  static final String _defaultValueDpsCategory = RESTRICTED_DPS_CATEGORY_ORDER.first;
  static const String? _defaultValueAttackType = null;
  static const String? _defaultValueRegion = null;
  static const CompetitorSearchResult? _defaultValueName = null;
  static const String? _defaultValueDpsCharacter = null;
  static const String? _defaultValueEnemy = null;
  static const String? _defaultValueDomain = null;
  static const String? _defaultValueEvent = null;
  @override
  DpsFilterStorage build() {
    return DpsFilterStorage(
      appliedFilter: {
        'dps_category': _defaultValueDpsCategory,
      },
      rawFilter: {
        'dps_category': _defaultValueDpsCategory,
      },
      defaultAppliedFilter: {
        'Overworld': {
          'dps_category': 'Overworld',
        },
        'Weekly Boss': {
          'dps_category': 'Weekly Boss',
        },
        'World Boss': {
          'dps_category': 'World Boss',
        },
        'Event': {
          'dps_category': 'Event',
        },
        'Abyss': {
          'dps_category': 'Abyss',
        },
        'Reputation Bounty': {
          'dps_category': 'Reputation Bounty',
        },
      },
      defaultFitlerValuesOverworld: {
        'dps_category': 'Overworld',
        'attack_type': _defaultValueAttackType,
        'region': _defaultValueRegion,
        'competitor': _defaultValueName,
        'dps_character': _defaultValueDpsCharacter,
        'enemy': _defaultValueEnemy,
      },
      defaultFitlerValuesWeeklyBoss: {
        'dps_category': 'Weekly Boss',
        'attack_type': _defaultValueAttackType,
        'region': _defaultValueRegion,
        'competitor': _defaultValueName,
        'dps_character': _defaultValueDpsCharacter,
        'enemy': _defaultValueEnemy,
      },
      defaultFitlerValuesWorldBoss: {
        'dps_category': 'World Boss',
        'attack_type': _defaultValueAttackType,
        'region': _defaultValueRegion,
        'competitor': _defaultValueName,
        'dps_character': _defaultValueDpsCharacter,
        'enemy': _defaultValueEnemy,
      },
      defaultFitlerValuesEvent: {
        'dps_category': 'Event',
        'attack_type': _defaultValueAttackType,
        'region': _defaultValueRegion,
        'competitor': _defaultValueName,
        'dps_character': _defaultValueDpsCharacter,
        'event': _defaultValueEvent,
      },
      defaultFitlerValuesAbyss: {
        'dps_category': 'Abyss',
        'attack_type': _defaultValueAttackType,
        'region': _defaultValueRegion,
        'competitor': _defaultValueName,
        'dps_character': _defaultValueDpsCharacter,
        'enemy': _defaultValueEnemy,
      },
      defaultFitlerValuesDomain: {
        'dps_category': 'Domain',
        'attack_type': _defaultValueAttackType,
        'region': _defaultValueRegion,
        'competitor': _defaultValueName,
        'dps_character': _defaultValueDpsCharacter,
        'domain': _defaultValueDomain,
      },
      defaultFitlerValuesReputationBounty: {
        'dps_category': 'Reputation Bounty',
        'attack_type': _defaultValueAttackType,
        'region': _defaultValueRegion,
        'competitor': _defaultValueName,
        'dps_character': _defaultValueDpsCharacter,
        'enemy': _defaultValueEnemy,
      },
    );
  }

  void updateFilter(Map<String, dynamic> filter) {
    final currState = state;
    final filterCopy = Map<String, dynamic>.from(filter);
    if (filter['competitor'] != null) {
      filterCopy['competitor'] = filter['competitor'].id;
    }
    state = currState.copyWith(appliedFilter: filterCopy, rawFilter: filter);
  }

  void resetFilter() {
    final currState = state;
    final currStateCategory = currState.appliedFilter['dps_category'] as String;
    state = currState.copyWith(
        appliedFilter:
            Map<String, dynamic>.from(currState.defaultAppliedFilter[currStateCategory] as Map<String, dynamic>),
        rawFilter:
            Map<String, dynamic>.from(currState.defaultAppliedFilter[currStateCategory] as Map<String, dynamic>));
  }
}

final appliedDisplayFilterProvider = StateProvider<Map<String, dynamic>>((ref) => {});
