import 'dart:developer';

import 'package:tgh_mobile/imports.dart';

class Filter extends ConsumerStatefulWidget {
  const Filter({super.key, required this.type, required this.category, required this.onFilterChanged});
  final String type;
  final String category;
  final void Function(Map<String, dynamic>) onFilterChanged;

  @override
  ConsumerState<Filter> createState() => FilterState();
}

class FilterState extends ConsumerState<Filter> {
  SingleSelectController<String> abyssVersionController = SingleSelectController<String>(ABYSS_VERSION_HISTORY.last);
  SingleSelectController<String?> regionController = SingleSelectController<String?>(null);
  SingleSelectController<CompetitorSearchResult?> nameController =
      SingleSelectController<CompetitorSearchResult?>(null);
  SingleSelectController<String?> floorController = SingleSelectController<String?>(null);
  MultiSelectController<String?> charactersController = MultiSelectController<String?>([]);
  SingleSelectController<String?> enemyController = SingleSelectController<String?>(null);
  SingleSelectController<String?> domainController = SingleSelectController<String?>(null);
  SingleSelectController<String?> eventController = SingleSelectController<String?>(null);
  SingleSelectController<String?> attackTypeController = SingleSelectController<String?>(null);
  double _dragAccumulator = 0.0;

  // Flag to track if changes are being made programmatically
  bool _isInitializing = false;

  Map<String, dynamic> localFilter = <String, dynamic>{};
  Map<String, dynamic> appliedDisplayFilter = <String, dynamic>{};

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _initFilter();
    });

    super.initState();
  }

  @override
  void didUpdateWidget(Filter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.category != widget.category) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _initFilter();
      });
    }
  }

  void updateFilter(String filter) {
    // Skip updates during initialization
    if (_isInitializing) return;

    if (widget.type == 'Speedrun') {
      if (filter == 'Alias') {
        final newFilter = <String, dynamic>{};
        localFilter.forEach((key, value) {
          newFilter[key] = value;
        });
        newFilter['competitor'] =
            CompetitorSearchResult(alias: nameController.value?.alias ?? '', id: nameController.value?.id ?? '');
        localFilter = newFilter;
        appliedDisplayFilter['From competitor'] = nameController.value?.alias;
      } else if (filter == 'Abyss Version') {
        localFilter['abyss_version'] = abyssVersionController.value;
        appliedDisplayFilter['Abyss version'] = abyssVersionController.value;
      } else if (filter == 'Floor') {
        localFilter['speedrun_subcategory'] = floorController.value;
        appliedDisplayFilter['Chmaber'] = floorController.value;
      } else if (filter == 'Domain') {
        localFilter['speedrun_subcategory'] = domainController.value;
        appliedDisplayFilter['Domain'] = domainController.value;
      } else if (filter == 'Event') {
        localFilter['abyss_version'] = eventController.value;
        appliedDisplayFilter['Event'] = eventController.value;
      } else if (filter == 'Enemy') {
        localFilter['speedrun_subcategory'] = enemyController.value;
        appliedDisplayFilter['Enemy'] = enemyController.value;
      } else if (filter == 'Region') {
        localFilter['region'] = regionController.value;
        appliedDisplayFilter['Region'] = regionController.value;
      } else if (filter == 'Characters') {
        log(charactersController.value.toString(), name: 'Character controller');
        final charactersList = List<String?>.from(charactersController.value);

        // Create a new map with the correct type and copy all existing entries
        final newFilter = <String, dynamic>{};
        localFilter.forEach((key, value) {
          newFilter[key] = value;
        });

        // Add the characters list to the new map
        newFilter['characters'] = charactersList;

        // Replace the old map with the new one
        localFilter = newFilter;

        if (charactersList.isEmpty) {
          localFilter.remove('characters');
        }
        appliedDisplayFilter['Characters'] = charactersList;
      }
    } else if (widget.type == 'DPS' || widget.type == 'Restricted DPS') {
      if (filter == 'Alias') {
        final newFilter = <String, dynamic>{};
        localFilter.forEach((key, value) {
          newFilter[key] = value;
        });
        newFilter['competitor'] =
            CompetitorSearchResult(alias: nameController.value?.alias ?? '', id: nameController.value?.id ?? '');
        localFilter = newFilter;
        appliedDisplayFilter['From competitor'] = nameController.value?.alias;
      } else if (filter == 'Region') {
        localFilter['region'] = regionController.value;
        appliedDisplayFilter['Region'] = regionController.value;
      } else if (filter == 'Characters') {
        log(charactersController.value.toString(), name: 'Character controller');
        final charactersList = List<String?>.from(charactersController.value);

        // Create a new map with the correct type and copy all existing entries
        final newFilter = <String, dynamic>{};
        localFilter.forEach((key, value) {
          newFilter[key] = value;
        });

        // Add the characters list to the new map
        newFilter['characters'] = charactersList;

        // Replace the old map with the new one
        localFilter = newFilter;

        if (charactersList.isEmpty) {
          localFilter.remove('characters');
        }
        appliedDisplayFilter['Characters'] = charactersList;
      } else if (filter == 'Attack Type') {
        localFilter['attack_type'] = attackTypeController.value;
        appliedDisplayFilter['Ability'] = attackTypeController.value;
      } else if (filter == 'Enemy') {
        localFilter['enemy'] = enemyController.value;
        appliedDisplayFilter['Enemy'] = enemyController.value;
      } else if (filter == 'Domain') {
        localFilter['domain'] = domainController.value;
        appliedDisplayFilter['Domain'] = domainController.value;
      } else if (filter == 'Event') {
        localFilter['event'] = eventController.value;
        appliedDisplayFilter['Event'] = eventController.value;
      }
    }
    log('$localFilter', name: 'Local Filter');
    widget.onFilterChanged(localFilter);
  }

  void resetFilter() {
    if (widget.type == 'Speedrun') {
      final filterStorage = ref.read(speedrunLeaderboardFilterNotifierProvider);
      localFilter = filterStorage.defaultAppliedFilter[widget.category] as Map<String, dynamic>;
      widget.onFilterChanged(localFilter);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(direction: Axis.horizontal, runSpacing: 10, spacing: 16.wr, children: [
      SizedBox(
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Text('Search by name', style: TextStyle(fontSize: 12.wr)),
              CustomDropdown<CompetitorSearchResult?>.searchRequest(
                  futureRequest: (value) async {
                    final result = await ref.watch(searchCompetitorsProvider(value).future);
                    return result.map((e) => CompetitorSearchResult(alias: e.alias, id: e.id)).toList();
                  },
                  decoration: CustomDropdownDecoration(
                    expandedShadow: [
                      BoxShadow(
                          color: Theme.of(context).colorScheme.shadow,
                          offset: const Offset(0, 3),
                          blurRadius: 6,
                          spreadRadius: 0)
                    ],
                    closedFillColor: Theme.of(context).colorScheme.surfaceContainerLow,
                    closedBorder: Border.all(color: Theme.of(context).colorScheme.outline),
                    expandedBorder: Border.all(color: Theme.of(context).colorScheme.outline),
                    expandedFillColor: Theme.of(context).colorScheme.surfaceContainerHigh,
                    listItemStyle: TextStyle(fontSize: 12.wr),
                    headerStyle: TextStyle(fontSize: 12.wr),
                    noResultFoundStyle: TextStyle(fontSize: 12.wr),
                    hintStyle:
                        TextStyle(fontSize: 12.wr, color: Theme.of(context).extension<TextColors>()?.textSecondary),
                    expandedSuffixIcon: Icon(Icons.arrow_drop_up, size: 10.wr),
                    closedSuffixIcon: nameController.hasValue
                        ? SizedBox(
                            width: 12.wr,
                            height: 12.wr,
                            child: IconButton(
                                onPressed: () {
                                  nameController.clear();
                                },
                                padding: const EdgeInsets.all(0),
                                icon: Icon(Icons.close, size: 10.wr)))
                        : Icon(Icons.arrow_drop_down, size: 10.wr),
                    searchFieldDecoration: SearchFieldDecoration(
                        textStyle: TextStyle(fontSize: 12.wr, color: Theme.of(context).extension<TextColors>()!.text),
                        fillColor: Theme.of(context).colorScheme.surfaceContainerLow,
                        contentPadding: const EdgeInsets.all(0)),
                  ),
                  closedHeaderPadding: EdgeInsets.symmetric(horizontal: 10.wr, vertical: 10),
                  expandedHeaderPadding: EdgeInsets.symmetric(horizontal: 10.wr, vertical: 10),
                  hintText: 'Search by name',
                  itemsListPadding: const EdgeInsets.all(0),
                  listItemPadding: EdgeInsets.symmetric(horizontal: 10.wr, vertical: 10),
                  controller: nameController,
                  futureRequestDelay: const Duration(milliseconds: 500),
                  onChanged: (p0) {
                    setState(() {
                      updateFilter('Alias');
                    });
                  })
            ],
          )),
      if (widget.type == 'Speedrun' && widget.category == 'Abyss')
        SizedBox(
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Text('Abyss Version', style: TextStyle(fontSize: 12.wr)),
                GestureDetector(
                  onVerticalDragUpdate: (details) {
                    _dragAccumulator += details.primaryDelta!;
                    const double dragThreshold = 10.0;

                    final items = ABYSS_VERSION_HISTORY.reversed.toList();
                    final currentValue = abyssVersionController.value;

                    if (currentValue == null) return;

                    int currentIndex = items.indexOf(currentValue);

                    if (_dragAccumulator > dragThreshold) {
                      if (currentIndex < items.length - 1) {
                        abyssVersionController.value = items[currentIndex + 1];
                      }
                      _dragAccumulator = 0.0;
                    } else if (_dragAccumulator < -dragThreshold) {
                      if (currentIndex > 0) {
                        abyssVersionController.value = items[currentIndex - 1];
                      }
                      _dragAccumulator = 0.0;
                    }
                  },
                  child: CustomDropdown<String>(
                      decoration: CustomDropdownDecoration(
                        expandedShadow: [
                          BoxShadow(
                              color: Theme.of(context).colorScheme.shadow,
                              offset: const Offset(0, 3),
                              blurRadius: 6,
                              spreadRadius: 0)
                        ],
                        closedFillColor: Theme.of(context).colorScheme.surfaceContainerLow,
                        closedBorder: Border.all(color: Theme.of(context).colorScheme.outline),
                        expandedBorder: Border.all(color: Theme.of(context).colorScheme.outline),
                        expandedFillColor: Theme.of(context).colorScheme.surfaceContainerHigh,
                        listItemStyle: TextStyle(fontSize: 12.wr),
                        headerStyle: TextStyle(fontSize: 12.wr),
                        expandedSuffixIcon: Icon(Icons.arrow_drop_up, size: 10.wr),
                        closedSuffixIcon: Icon(Icons.arrow_drop_down, size: 10.wr),
                      ),
                      closedHeaderPadding: EdgeInsets.symmetric(horizontal: 10.wr, vertical: 10),
                      expandedHeaderPadding: EdgeInsets.symmetric(horizontal: 10.wr, vertical: 10),
                      hintText: 'Abyss Version',
                      itemsListPadding: const EdgeInsets.all(0),
                      listItemPadding: EdgeInsets.symmetric(horizontal: 10.wr, vertical: 10),
                      items: ABYSS_VERSION_HISTORY.reversed.toList(),
                      controller: abyssVersionController,
                      onChanged: (p0) {
                        setState(() {
                          updateFilter('Abyss Version');
                        });
                      }),
                )
              ],
            )),
      if (widget.type == 'Speedrun' && widget.category == 'Abyss')
        SizedBox(
            width: 200,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
              // Text('Floor', style: TextStyle(fontSize: 12.wr)),
              GestureDetector(
                  onVerticalDragUpdate: (details) {
                    _dragAccumulator += details.primaryDelta!;
                    const double dragThreshold = 10.0;

                    const items = SPEEDRUN_ABYSS_CHAMBERS;
                    final currentValue = floorController.value;

                    if (currentValue == null) {
                      floorController.value = items.first;
                      return;
                    }

                    int currentIndex = items.indexOf(currentValue);

                    if (_dragAccumulator > dragThreshold) {
                      if (currentIndex < items.length - 1) {
                        floorController.value = items[currentIndex + 1];
                      }
                      _dragAccumulator = 0.0;
                    } else if (_dragAccumulator < -dragThreshold) {
                      if (currentIndex > 0) {
                        floorController.value = items[currentIndex - 1];
                      }
                      _dragAccumulator = 0.0;
                    }
                  },
                  child: CustomDropdown<String?>(
                      decoration: CustomDropdownDecoration(
                        expandedShadow: [
                          BoxShadow(
                              color: Theme.of(context).colorScheme.shadow,
                              offset: const Offset(0, 3),
                              blurRadius: 6,
                              spreadRadius: 0)
                        ],
                        closedFillColor: Theme.of(context).colorScheme.surfaceContainerLow,
                        closedBorder: Border.all(color: Theme.of(context).colorScheme.outline),
                        expandedBorder: Border.all(color: Theme.of(context).colorScheme.outline),
                        expandedFillColor: Theme.of(context).colorScheme.surfaceContainerHigh,
                        listItemStyle: TextStyle(fontSize: 12.wr),
                        headerStyle: TextStyle(fontSize: 12.wr),
                        hintStyle:
                            TextStyle(fontSize: 12.wr, color: Theme.of(context).extension<TextColors>()?.textSecondary),
                        expandedSuffixIcon: Icon(Icons.arrow_drop_up, size: 10.wr),
                        closedSuffixIcon: floorController.hasValue
                            ? SizedBox(
                                width: 12.wr,
                                height: 12.wr,
                                child: IconButton(
                                    onPressed: () {
                                      floorController.clear();
                                    },
                                    padding: const EdgeInsets.all(0),
                                    icon: Icon(Icons.close, size: 10.wr)))
                            : Icon(Icons.arrow_drop_down, size: 10.wr),
                      ),
                      closedHeaderPadding: EdgeInsets.symmetric(horizontal: 10.wr, vertical: 10),
                      expandedHeaderPadding: EdgeInsets.symmetric(horizontal: 10.wr, vertical: 10),
                      hintText: 'Floor',
                      itemsListPadding: const EdgeInsets.all(0),
                      listItemPadding: EdgeInsets.symmetric(horizontal: 10.wr, vertical: 10),
                      items: SPEEDRUN_ABYSS_CHAMBERS,
                      controller: floorController,
                      onChanged: (p0) {
                        setState(() {
                          updateFilter('Floor');
                        });
                      }))
            ])),
      if (widget.category == 'Domain')
        SizedBox(
            width: 200,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
              // Text('Domain', style: TextStyle(fontSize: 12.wr)),
              GestureDetector(
                  onVerticalDragUpdate: (details) {
                    _dragAccumulator += details.primaryDelta!;
                    const double dragThreshold = 10.0;

                    const items = DOMAIN;
                    final currentValue = domainController.value;

                    if (currentValue == null) {
                      domainController.value = items.first;
                      return;
                    }

                    int currentIndex = items.indexOf(currentValue);

                    if (_dragAccumulator > dragThreshold) {
                      if (currentIndex < items.length - 1) {
                        domainController.value = items[currentIndex + 1];
                      }
                      _dragAccumulator = 0.0;
                    } else if (_dragAccumulator < -dragThreshold) {
                      if (currentIndex > 0) {
                        domainController.value = items[currentIndex - 1];
                      }
                      _dragAccumulator = 0.0;
                    }
                  },
                  child: CustomDropdown<String?>(
                      decoration: CustomDropdownDecoration(
                        expandedShadow: [
                          BoxShadow(
                              color: Theme.of(context).colorScheme.shadow,
                              offset: const Offset(0, 3),
                              blurRadius: 6,
                              spreadRadius: 0)
                        ],
                        closedFillColor: Theme.of(context).colorScheme.surfaceContainerLow,
                        closedBorder: Border.all(color: Theme.of(context).colorScheme.outline),
                        expandedBorder: Border.all(color: Theme.of(context).colorScheme.outline),
                        expandedFillColor: Theme.of(context).colorScheme.surfaceContainerHigh,
                        listItemStyle: TextStyle(fontSize: 12.wr),
                        headerStyle: TextStyle(fontSize: 12.wr),
                        hintStyle:
                            TextStyle(fontSize: 12.wr, color: Theme.of(context).extension<TextColors>()?.textSecondary),
                        expandedSuffixIcon: Icon(Icons.arrow_drop_up, size: 10.wr),
                        closedSuffixIcon: Icon(Icons.arrow_drop_down, size: 10.wr),
                      ),
                      closedHeaderPadding: EdgeInsets.symmetric(horizontal: 10.wr, vertical: 10),
                      expandedHeaderPadding: EdgeInsets.symmetric(horizontal: 10.wr, vertical: 10),
                      hintText: 'Domain',
                      itemsListPadding: const EdgeInsets.all(0),
                      listItemPadding: EdgeInsets.symmetric(horizontal: 10.wr, vertical: 10),
                      items: DOMAIN,
                      controller: domainController,
                      onChanged: (p0) {
                        setState(() {
                          updateFilter('Domain');
                        });
                      }))
            ])),
      if (widget.category == 'Event')
        SizedBox(
            width: 200,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
              // Text('Event', style: TextStyle(fontSize: 12.wr)),
              GestureDetector(
                  onVerticalDragUpdate: (details) {
                    _dragAccumulator += details.primaryDelta!;
                    const double dragThreshold = 10.0;

                    final items = widget.type == 'Speedrun' ? SPEEDRUN_EVENTS : DPS_EVENTS;
                    final currentValue = eventController.value;

                    if (currentValue == null) {
                      eventController.value = items.first;
                      return;
                    }

                    int currentIndex = items.indexOf(currentValue);

                    if (_dragAccumulator > dragThreshold) {
                      if (currentIndex < items.length - 1) {
                        eventController.value = items[currentIndex + 1];
                      }
                      _dragAccumulator = 0.0;
                    } else if (_dragAccumulator < -dragThreshold) {
                      if (currentIndex > 0) {
                        eventController.value = items[currentIndex - 1];
                      }
                      _dragAccumulator = 0.0;
                    }
                  },
                  child: CustomDropdown<String?>(
                      decoration: CustomDropdownDecoration(
                        expandedShadow: [
                          BoxShadow(
                              color: Theme.of(context).colorScheme.shadow,
                              offset: const Offset(0, 3),
                              blurRadius: 6,
                              spreadRadius: 0)
                        ],
                        closedFillColor: Theme.of(context).colorScheme.surfaceContainerLow,
                        closedBorder: Border.all(color: Theme.of(context).colorScheme.outline),
                        expandedBorder: Border.all(color: Theme.of(context).colorScheme.outline),
                        expandedFillColor: Theme.of(context).colorScheme.surfaceContainerHigh,
                        listItemStyle: TextStyle(fontSize: 12.wr),
                        headerStyle: TextStyle(fontSize: 12.wr),
                        hintStyle:
                            TextStyle(fontSize: 12.wr, color: Theme.of(context).extension<TextColors>()?.textSecondary),
                        expandedSuffixIcon: Icon(Icons.arrow_drop_up, size: 10.wr),
                        closedSuffixIcon: floorController.hasValue
                            ? SizedBox(
                                width: 12.wr,
                                height: 12.wr,
                                child: IconButton(
                                    onPressed: () {
                                      eventController.clear();
                                    },
                                    padding: const EdgeInsets.all(0),
                                    icon: Icon(Icons.close, size: 10.wr)))
                            : Icon(Icons.arrow_drop_down, size: 10.wr),
                      ),
                      closedHeaderPadding: EdgeInsets.symmetric(horizontal: 10.wr, vertical: 10),
                      expandedHeaderPadding: EdgeInsets.symmetric(horizontal: 10.wr, vertical: 10),
                      hintText: 'Event',
                      itemsListPadding: const EdgeInsets.all(0),
                      listItemPadding: EdgeInsets.symmetric(horizontal: 10.wr, vertical: 10),
                      items: widget.type == 'Speedrun' ? SPEEDRUN_EVENTS : DPS_EVENTS,
                      controller: eventController,
                      onChanged: (p0) {
                        setState(() {
                          updateFilter('Event');
                        });
                      }))
            ])),
      if ((widget.type == 'DPS' || widget.category == 'Weekly Boss' || widget.category == 'World Boss') &&
          widget.category != 'Event' &&
          widget.category != 'Domain')
        SizedBox(
            width: 200,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
              // Text('Enemy', style: TextStyle(fontSize: 12.wr)),
              GestureDetector(
                  onVerticalDragUpdate: (details) {
                    _dragAccumulator += details.primaryDelta!;
                    const double dragThreshold = 10.0;

                    final items = widget.category == 'Weekly Boss'
                        ? WEEKLY_BOSSES
                        : widget.category == 'World Boss'
                            ? WORLD_BOSSES
                            : OVERWORLD_MOBS;
                    final currentValue = enemyController.value;

                    if (currentValue == null) {
                      enemyController.value = items.first;
                      return;
                    }

                    int currentIndex = items.indexOf(currentValue);

                    if (_dragAccumulator > dragThreshold) {
                      if (currentIndex < items.length - 1) {
                        enemyController.value = items[currentIndex + 1];
                      }
                      _dragAccumulator = 0.0;
                    } else if (_dragAccumulator < -dragThreshold) {
                      if (currentIndex > 0) {
                        enemyController.value = items[currentIndex - 1];
                      }
                      _dragAccumulator = 0.0;
                    }
                  },
                  child: CustomDropdown<String?>(
                      decoration: CustomDropdownDecoration(
                        expandedShadow: [
                          BoxShadow(
                              color: Theme.of(context).colorScheme.shadow,
                              offset: const Offset(0, 3),
                              blurRadius: 6,
                              spreadRadius: 0)
                        ],
                        closedFillColor: Theme.of(context).colorScheme.surfaceContainerLow,
                        closedBorder: Border.all(color: Theme.of(context).colorScheme.outline),
                        expandedBorder: Border.all(color: Theme.of(context).colorScheme.outline),
                        expandedFillColor: Theme.of(context).colorScheme.surfaceContainerHigh,
                        listItemStyle: TextStyle(fontSize: 12.wr),
                        headerStyle: TextStyle(fontSize: 12.wr),
                        hintStyle:
                            TextStyle(fontSize: 12.wr, color: Theme.of(context).extension<TextColors>()?.textSecondary),
                        expandedSuffixIcon: Icon(Icons.arrow_drop_up, size: 10.wr),
                        closedSuffixIcon: floorController.hasValue
                            ? SizedBox(
                                width: 12.wr,
                                height: 12.wr,
                                child: IconButton(
                                    onPressed: () {
                                      enemyController.clear();
                                    },
                                    padding: const EdgeInsets.all(0),
                                    icon: Icon(Icons.close, size: 10.wr)))
                            : Icon(Icons.arrow_drop_down, size: 10.wr),
                      ),
                      closedHeaderPadding: EdgeInsets.symmetric(horizontal: 10.wr, vertical: 10),
                      expandedHeaderPadding: EdgeInsets.symmetric(horizontal: 10.wr, vertical: 10),
                      hintText: 'Enemy',
                      itemsListPadding: const EdgeInsets.all(0),
                      listItemPadding: EdgeInsets.symmetric(horizontal: 10.wr, vertical: 10),
                      items: widget.category == 'Weekly Boss'
                          ? WEEKLY_BOSSES
                          : widget.category == 'World Boss'
                              ? WORLD_BOSSES
                              : OVERWORLD_MOBS,
                      controller: enemyController,
                      onChanged: (p0) {
                        setState(() {
                          updateFilter('Enemy');
                        });
                      }))
            ])),
      if (widget.type == 'DPS')
        SizedBox(
            width: 200,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
              // Text('Attack', style: TextStyle(fontSize: 12.wr)),
              GestureDetector(
                  onVerticalDragUpdate: (details) {
                    _dragAccumulator += details.primaryDelta!;
                    const double dragThreshold = 10.0;

                    const items = ATTACK_TYPES;
                    final currentValue = attackTypeController.value;

                    if (currentValue == null) {
                      attackTypeController.value = items.first;
                      return;
                    }

                    int currentIndex = items.indexOf(currentValue);

                    if (_dragAccumulator > dragThreshold) {
                      if (currentIndex < items.length - 1) {
                        attackTypeController.value = items[currentIndex + 1];
                      }
                      _dragAccumulator = 0.0;
                    } else if (_dragAccumulator < -dragThreshold) {
                      if (currentIndex > 0) {
                        attackTypeController.value = items[currentIndex - 1];
                      }
                      _dragAccumulator = 0.0;
                    }
                  },
                  child: CustomDropdown<String?>(
                      decoration: CustomDropdownDecoration(
                        expandedShadow: [
                          BoxShadow(
                              color: Theme.of(context).colorScheme.shadow,
                              offset: const Offset(0, 3),
                              blurRadius: 6,
                              spreadRadius: 0)
                        ],
                        closedFillColor: Theme.of(context).colorScheme.surfaceContainerLow,
                        closedBorder: Border.all(color: Theme.of(context).colorScheme.outline),
                        expandedBorder: Border.all(color: Theme.of(context).colorScheme.outline),
                        expandedFillColor: Theme.of(context).colorScheme.surfaceContainerHigh,
                        listItemStyle: TextStyle(fontSize: 12.wr),
                        headerStyle: TextStyle(fontSize: 12.wr),
                        hintStyle:
                            TextStyle(fontSize: 12.wr, color: Theme.of(context).extension<TextColors>()?.textSecondary),
                        expandedSuffixIcon: Icon(Icons.arrow_drop_up, size: 10.wr),
                        closedSuffixIcon: floorController.hasValue
                            ? SizedBox(
                                width: 12.wr,
                                height: 12.wr,
                                child: IconButton(
                                    onPressed: () {
                                      attackTypeController.clear();
                                    },
                                    padding: const EdgeInsets.all(0),
                                    icon: Icon(Icons.close, size: 10.wr)))
                            : Icon(Icons.arrow_drop_down, size: 10.wr),
                      ),
                      closedHeaderPadding: EdgeInsets.symmetric(horizontal: 10.wr, vertical: 10),
                      expandedHeaderPadding: EdgeInsets.symmetric(horizontal: 10.wr, vertical: 10),
                      hintText: 'Attack Type',
                      itemsListPadding: const EdgeInsets.all(0),
                      listItemPadding: EdgeInsets.symmetric(horizontal: 10.wr, vertical: 10),
                      items: ATTACK_TYPES,
                      controller: attackTypeController,
                      onChanged: (p0) {
                        setState(() {
                          updateFilter('Attack Type');
                        });
                      }))
            ])),
      SizedBox(
          width: 200,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
            // Text('Region', style: TextStyle(fontSize: 12.wr)),
            GestureDetector(
                onVerticalDragUpdate: (details) {
                  _dragAccumulator += details.primaryDelta!;
                  const double dragThreshold = 10.0;

                  const items = REGIONS;
                  final currentValue = regionController.value;

                  if (currentValue == null) {
                    regionController.value = items.first;
                    return;
                  }

                  int currentIndex = items.indexOf(currentValue);

                  if (_dragAccumulator > dragThreshold) {
                    if (currentIndex < items.length - 1) {
                      regionController.value = items[currentIndex + 1];
                    }
                    _dragAccumulator = 0.0;
                  } else if (_dragAccumulator < -dragThreshold) {
                    if (currentIndex > 0) {
                      regionController.value = items[currentIndex - 1];
                    }
                    _dragAccumulator = 0.0;
                  }
                },
                child: CustomDropdown<String?>(
                    decoration: CustomDropdownDecoration(
                      expandedShadow: [
                        BoxShadow(
                            color: Theme.of(context).colorScheme.shadow,
                            offset: const Offset(0, 3),
                            blurRadius: 6,
                            spreadRadius: 0)
                      ],
                      closedFillColor: Theme.of(context).colorScheme.surfaceContainerLow,
                      closedBorder: Border.all(color: Theme.of(context).colorScheme.outline),
                      expandedBorder: Border.all(color: Theme.of(context).colorScheme.outline),
                      expandedFillColor: Theme.of(context).colorScheme.surfaceContainerHigh,
                      listItemStyle: TextStyle(fontSize: 12.wr),
                      headerStyle: TextStyle(fontSize: 12.wr),
                      hintStyle:
                          TextStyle(fontSize: 12.wr, color: Theme.of(context).extension<TextColors>()?.textSecondary),
                      expandedSuffixIcon: Icon(Icons.arrow_drop_up, size: 10.wr),
                      closedSuffixIcon: regionController.hasValue
                          ? SizedBox(
                              width: 12.wr,
                              height: 12.wr,
                              child: IconButton(
                                  onPressed: () {
                                    regionController.clear();
                                  },
                                  padding: const EdgeInsets.all(0),
                                  icon: Icon(Icons.close, size: 10.wr)))
                          : Icon(Icons.arrow_drop_down, size: 10.wr),
                    ),
                    closedHeaderPadding: EdgeInsets.symmetric(horizontal: 10.wr, vertical: 10),
                    expandedHeaderPadding: EdgeInsets.symmetric(horizontal: 10.wr, vertical: 10),
                    hintText: 'Region',
                    itemsListPadding: const EdgeInsets.all(0),
                    listItemPadding: EdgeInsets.symmetric(horizontal: 10.wr, vertical: 10),
                    items: REGIONS,
                    controller: regionController,
                    onChanged: (p0) {
                      setState(() {
                        updateFilter('Region');
                      });
                    }))
          ])),
      ref.watch(gameAssetProvider).maybeWhen(
          orElse: () => const SizedBox.shrink(),
          data: (value) {
            List<String> characters = value.maybeMap(
                    orElse: () => [], loaded: (value) => value.characters?.map((e) => e.name).toList() ?? []) ??
                [];
            return SizedBox(
                width: 200,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                  // Text('Characters', style: TextStyle(fontSize: 12.wr)),
                  CustomDropdown<String?>.multiSelectSearch(
                      decoration: CustomDropdownDecoration(
                        expandedShadow: [
                          BoxShadow(
                              color: Theme.of(context).colorScheme.shadow,
                              offset: const Offset(0, 3),
                              blurRadius: 6,
                              spreadRadius: 0)
                        ],
                        closedFillColor: Theme.of(context).colorScheme.surfaceContainerLow,
                        closedBorder: Border.all(color: Theme.of(context).colorScheme.outline),
                        expandedBorder: Border.all(color: Theme.of(context).colorScheme.outline),
                        expandedFillColor: Theme.of(context).colorScheme.surfaceContainerHigh,
                        listItemStyle: TextStyle(fontSize: 12.wr),
                        headerStyle: TextStyle(fontSize: 12.wr),
                        hintStyle:
                            TextStyle(fontSize: 12.wr, color: Theme.of(context).extension<TextColors>()?.textSecondary),
                        expandedSuffixIcon: Icon(Icons.arrow_drop_up, size: 10.wr),
                        closedSuffixIcon: charactersController.value.isNotEmpty
                            ? SizedBox(
                                width: 12.wr,
                                height: 12.wr,
                                child: IconButton(
                                    onPressed: () {
                                      charactersController.clear();
                                    },
                                    padding: const EdgeInsets.all(0),
                                    icon: Icon(Icons.close, size: 10.wr)))
                            : Icon(Icons.arrow_drop_down, size: 10.wr),
                        searchFieldDecoration: SearchFieldDecoration(
                            textStyle:
                                TextStyle(fontSize: 12.wr, color: Theme.of(context).extension<TextColors>()!.text),
                            fillColor: Theme.of(context).colorScheme.surfaceContainerLow,
                            contentPadding: const EdgeInsets.all(0)),
                      ),
                      closedHeaderPadding: EdgeInsets.symmetric(horizontal: 10.wr, vertical: 10),
                      expandedHeaderPadding: EdgeInsets.symmetric(horizontal: 10.wr, vertical: 10),
                      hintText: 'Characters',
                      itemsListPadding: const EdgeInsets.all(0),
                      listItemPadding: EdgeInsets.symmetric(horizontal: 10.wr, vertical: 10),
                      items: characters,
                      multiSelectController: charactersController,
                      onListChanged: (p0) {
                        setState(() {
                          updateFilter('Characters');
                        });
                      })
                ]));
          })
    ]);
  }

  void _initFilter() {
    try {
      // Set the flag to prevent unwanted updates
      _isInitializing = true;

      if (widget.type == 'Speedrun') {
        final filterStorage = ref.watch(speedrunLeaderboardFilterNotifierProvider);
        log('Filter category: ${widget.category}'); // Debug print

        if (widget.category == 'Abyss') {
          if ((filterStorage.defaultAppliedFilter['Abyss'] as Map<String, dynamic>)
              .contentNotEquals(filterStorage.appliedFilter)) {
            abyssVersionController.value = filterStorage.rawFilter['abyss_version'] as String;
            if (filterStorage.appliedFilter['region'] != null) {
              regionController.value = filterStorage.appliedFilter['region'] as String?;
            }
            if (filterStorage.appliedFilter['speedrun_subcategory'] != null) {
              floorController.value = filterStorage.rawFilter['speedrun_subcategory'] as String?;
            }
            if (filterStorage.appliedFilter['characters'] != null) {
              charactersController.value = filterStorage.rawFilter['characters'] as List<String?>;
            }
            if (filterStorage.appliedFilter['competitor'] != null) {
              nameController.value = filterStorage.rawFilter['competitor'] as CompetitorSearchResult?;
            }
            localFilter = filterStorage.appliedFilter;
          } else {
            nameController.value = filterStorage.defaultFitlerValuesAbyss['competitor'] as CompetitorSearchResult?;
            abyssVersionController.value = filterStorage.defaultFitlerValuesAbyss['abyss_version'] as String;
            regionController.value = filterStorage.defaultFitlerValuesAbyss['region'] as String?;
            floorController.value = filterStorage.defaultFitlerValuesAbyss['speedrun_subcategory'] as String?;
            charactersController.value = filterStorage.defaultFitlerValuesAbyss['characters'] as List<String?>;
            localFilter = filterStorage.defaultAppliedFilter['Abyss'] as Map<String, dynamic>;
          }
        } else if (widget.category == 'Domain') {
          if ((filterStorage.defaultAppliedFilter['Domain'] as Map<String, dynamic>)
              .contentNotEquals(filterStorage.appliedFilter)) {
            domainController.value = filterStorage.rawFilter['speedrun_subcategory'] as String;
            if (filterStorage.appliedFilter['region'] != null) {
              regionController.value = filterStorage.rawFilter['region'] as String?;
            }
            if (filterStorage.appliedFilter['characters'] != null) {
              charactersController.value = filterStorage.rawFilter['characters'] as List<String?>;
            }
            if (filterStorage.appliedFilter['competitor'] != null) {
              nameController.value = filterStorage.rawFilter['competitor'] as CompetitorSearchResult?;
            }
            localFilter = filterStorage.appliedFilter;
          } else {
            domainController.value = filterStorage.defaultFitlerValuesDomain['speedrun_subcategory'] as String;
            regionController.value = filterStorage.defaultFitlerValuesDomain['region'] as String?;
            charactersController.value = filterStorage.defaultFitlerValuesDomain['characters'] as List<String?>;
            nameController.value = filterStorage.defaultFitlerValuesDomain['competitor'] as CompetitorSearchResult?;
            localFilter = filterStorage.defaultAppliedFilter['Domain'] as Map<String, dynamic>;
          }
        } else if (widget.category == 'Event') {
          if ((filterStorage.defaultAppliedFilter['Event'] as Map<String, dynamic>)
              .contentNotEquals(filterStorage.appliedFilter)) {
            eventController.value = filterStorage.rawFilter['abyss_version'] as String;
            if (filterStorage.appliedFilter['region'] != null) {
              regionController.value = filterStorage.rawFilter['region'] as String?;
            }
            if (filterStorage.appliedFilter['characters'] != null) {
              charactersController.value = filterStorage.rawFilter['characters'] as List<String?>;
            }
            if (filterStorage.appliedFilter['competitor'] != null) {
              nameController.value = filterStorage.rawFilter['competitor'] as CompetitorSearchResult?;
            }
            localFilter = filterStorage.appliedFilter;
          } else {
            eventController.value = filterStorage.defaultFitlerValuesEvent['abyss_version'] as String;
            regionController.value = filterStorage.defaultFitlerValuesEvent['region'] as String?;
            charactersController.value = filterStorage.defaultFitlerValuesEvent['characters'] as List<String?>;
            nameController.value = filterStorage.defaultFitlerValuesEvent['competitor'] as CompetitorSearchResult?;
            localFilter = filterStorage.defaultAppliedFilter['Event'] as Map<String, dynamic>;
          }
        } else if (widget.category == 'Weekly Boss') {
          if ((filterStorage.defaultAppliedFilter['Weekly Boss'] as Map<String, dynamic>)
              .contentNotEquals(filterStorage.appliedFilter)) {
            enemyController.value = filterStorage.rawFilter['speedrun_subcategory'] as String?;
            if (filterStorage.appliedFilter['region'] != null) {
              regionController.value = filterStorage.rawFilter['region'] as String?;
            }
            if (filterStorage.appliedFilter['characters'] != null) {
              charactersController.value = filterStorage.rawFilter['characters'] as List<String?>;
            }
            if (filterStorage.appliedFilter['competitor'] != null) {
              nameController.value = filterStorage.rawFilter['competitor'] as CompetitorSearchResult?;
            }
            localFilter = filterStorage.appliedFilter;
          } else {
            enemyController.value = filterStorage.defaultFitlerValuesWeeklyBoss['speedrun_subcategory'] as String?;
            regionController.value = filterStorage.defaultFitlerValuesWeeklyBoss['region'] as String?;
            charactersController.value = filterStorage.defaultFitlerValuesWeeklyBoss['characters'] as List<String?>;
            nameController.value = filterStorage.defaultFitlerValuesWeeklyBoss['competitor'] as CompetitorSearchResult?;
            localFilter = filterStorage.defaultAppliedFilter['Weekly Boss'] as Map<String, dynamic>;
          }
        } else if (widget.category == 'World Boss') {
          if ((filterStorage.defaultAppliedFilter['World Boss'] as Map<String, dynamic>)
              .contentNotEquals(filterStorage.appliedFilter)) {
            enemyController.value = filterStorage.rawFilter['speedrun_subcategory'] as String?;
            if (filterStorage.appliedFilter['region'] != null) {
              regionController.value = filterStorage.rawFilter['region'] as String?;
            }
            if (filterStorage.appliedFilter['characters'] != null) {
              charactersController.value = filterStorage.rawFilter['characters'] as List<String?>;
            }
            if (filterStorage.appliedFilter['competitor'] != null) {
              nameController.value = filterStorage.rawFilter['competitor'] as CompetitorSearchResult?;
            }
            localFilter = filterStorage.appliedFilter;
          } else {
            enemyController.value = filterStorage.defaultFitlerValuesWorldBoss['speedrun_subcategory'] as String?;
            regionController.value = filterStorage.defaultFitlerValuesWorldBoss['region'] as String?;
            charactersController.value = filterStorage.defaultFitlerValuesWorldBoss['characters'] as List<String?>;
            nameController.value = filterStorage.defaultFitlerValuesWorldBoss['competitor'] as CompetitorSearchResult?;
            localFilter = filterStorage.defaultAppliedFilter['World Boss'] as Map<String, dynamic>;
          }
        }
      } else if (widget.type == 'DPS' || widget.type == 'Restricted DPS') {
        final filterStorage = widget.type == 'DPS'
            ? ref.watch(dpsLeaderboardFilterNotifierProvider)
            : ref.watch(restrictedDpsLeaderboardFilterNotifierProvider);
        log('Filter category: ${widget.category}'); // Debug print
        log(filterStorage.toString());
        if (widget.category == 'Overworld') {
          if ((filterStorage.defaultAppliedFilter['Overworld'] as Map<String, dynamic>)
              .contentNotEquals(filterStorage.appliedFilter)) {
            if (filterStorage.appliedFilter['region'] != null) {
              regionController.value = filterStorage.appliedFilter['region'] as String?;
            }
            if (filterStorage.appliedFilter['characters'] != null) {
              charactersController.value = filterStorage.rawFilter['characters'] as List<String?>;
            }
            if (filterStorage.appliedFilter['attack_type'] != null) {
              attackTypeController.value = filterStorage.rawFilter['attack_type'] as String?;
            }
            if (filterStorage.appliedFilter['competitor'] != null) {
              nameController.value = filterStorage.rawFilter['competitor'] as CompetitorSearchResult?;
            }
            if (filterStorage.appliedFilter['enemy'] != null) {
              enemyController.value = filterStorage.rawFilter['enemy'] as String?;
            }
            localFilter = filterStorage.appliedFilter;
          } else {
            regionController.value = filterStorage.defaultFitlerValuesOverworld['region'] as String?;
            charactersController.value = filterStorage.defaultFitlerValuesOverworld['characters'] as List<String?>;
            attackTypeController.value = filterStorage.defaultFitlerValuesOverworld['attack_type'] as String?;
            nameController.value = filterStorage.defaultFitlerValuesOverworld['competitor'] as CompetitorSearchResult?;
            enemyController.value = filterStorage.defaultFitlerValuesOverworld['enemy'] as String?;
            localFilter = filterStorage.defaultAppliedFilter['Overworld'] as Map<String, dynamic>;
          }
        } else if (widget.category == 'Weekly Boss') {
          if ((filterStorage.defaultAppliedFilter['Weekly Boss'] as Map<String, dynamic>)
              .contentNotEquals(filterStorage.appliedFilter)) {
            if (filterStorage.appliedFilter['region'] != null) {
              regionController.value = filterStorage.appliedFilter['region'] as String?;
            }
            if (filterStorage.appliedFilter['characters'] != null) {
              charactersController.value = filterStorage.rawFilter['characters'] as List<String?>;
            }
            if (filterStorage.appliedFilter['attack_type'] != null) {
              attackTypeController.value = filterStorage.rawFilter['attack_type'] as String?;
            }
            if (filterStorage.appliedFilter['competitor'] != null) {
              nameController.value = filterStorage.rawFilter['competitor'] as CompetitorSearchResult?;
            }
            if (filterStorage.appliedFilter['enemy'] != null) {
              enemyController.value = filterStorage.rawFilter['enemy'] as String?;
            }
            localFilter = filterStorage.appliedFilter;
          } else {
            regionController.value = filterStorage.defaultFitlerValuesWeeklyBoss['region'] as String?;
            charactersController.value = filterStorage.defaultFitlerValuesWeeklyBoss['characters'] as List<String?>;
            attackTypeController.value = filterStorage.defaultFitlerValuesWeeklyBoss['attack_type'] as String?;
            nameController.value = filterStorage.defaultFitlerValuesWeeklyBoss['competitor'] as CompetitorSearchResult?;
            enemyController.value = filterStorage.defaultFitlerValuesWeeklyBoss['enemy'] as String?;
            localFilter = filterStorage.defaultAppliedFilter['Weekly Boss'] as Map<String, dynamic>;
          }
        } else if (widget.category == 'World Boss') {
          if ((filterStorage.defaultAppliedFilter['World Boss'] as Map<String, dynamic>)
              .contentNotEquals(filterStorage.appliedFilter)) {
            if (filterStorage.appliedFilter['region'] != null) {
              regionController.value = filterStorage.appliedFilter['region'] as String?;
            }
            if (filterStorage.appliedFilter['characters'] != null) {
              charactersController.value = filterStorage.rawFilter['characters'] as List<String?>;
            }
            if (filterStorage.appliedFilter['attack_type'] != null) {
              attackTypeController.value = filterStorage.rawFilter['attack_type'] as String?;
            }
            if (filterStorage.appliedFilter['competitor'] != null) {
              nameController.value = filterStorage.rawFilter['competitor'] as CompetitorSearchResult?;
            }
            if (filterStorage.appliedFilter['enemy'] != null) {
              enemyController.value = filterStorage.rawFilter['enemy'] as String?;
            }
            localFilter = filterStorage.appliedFilter;
          } else {
            regionController.value = filterStorage.defaultFitlerValuesWorldBoss['region'] as String?;
            charactersController.value = filterStorage.defaultFitlerValuesWorldBoss['characters'] as List<String?>;
            attackTypeController.value = filterStorage.defaultFitlerValuesWorldBoss['attack_type'] as String?;
            nameController.value = filterStorage.defaultFitlerValuesWorldBoss['competitor'] as CompetitorSearchResult?;
            enemyController.value = filterStorage.defaultFitlerValuesWorldBoss['enemy'] as String?;
            localFilter = filterStorage.defaultAppliedFilter['World Boss'] as Map<String, dynamic>;
          }
        } else if (widget.category == 'Reputation Bounty') {
          if ((filterStorage.defaultAppliedFilter['Reputation Bounty'] as Map<String, dynamic>)
              .contentNotEquals(filterStorage.appliedFilter)) {
            if (filterStorage.appliedFilter['region'] != null) {
              regionController.value = filterStorage.appliedFilter['region'] as String?;
            }
            if (filterStorage.appliedFilter['characters'] != null) {
              charactersController.value = filterStorage.rawFilter['characters'] as List<String?>;
            }
            if (filterStorage.appliedFilter['attack_type'] != null) {
              attackTypeController.value = filterStorage.rawFilter['attack_type'] as String?;
            }
            if (filterStorage.appliedFilter['competitor'] != null) {
              nameController.value = filterStorage.rawFilter['competitor'] as CompetitorSearchResult?;
            }
            if (filterStorage.appliedFilter['enemy'] != null) {
              enemyController.value = filterStorage.rawFilter['enemy'] as String?;
            }
            localFilter = filterStorage.appliedFilter;
          } else {
            regionController.value = filterStorage.defaultFitlerValuesReputationBounty['region'] as String?;
            charactersController.value =
                filterStorage.defaultFitlerValuesReputationBounty['characters'] as List<String?>;
            attackTypeController.value = filterStorage.defaultFitlerValuesReputationBounty['attack_type'] as String?;
            nameController.value =
                filterStorage.defaultFitlerValuesReputationBounty['competitor'] as CompetitorSearchResult?;
            enemyController.value = filterStorage.defaultFitlerValuesReputationBounty['enemy'] as String?;
            localFilter = filterStorage.defaultAppliedFilter['Reputation Bounty'] as Map<String, dynamic>;
          }
        } else if (widget.category == 'Abyss') {
          if ((filterStorage.defaultAppliedFilter['Abyss'] as Map<String, dynamic>)
              .contentNotEquals(filterStorage.appliedFilter)) {
            if (filterStorage.appliedFilter['region'] != null) {
              regionController.value = filterStorage.appliedFilter['region'] as String?;
            }
            if (filterStorage.appliedFilter['characters'] != null) {
              charactersController.value = filterStorage.rawFilter['characters'] as List<String?>;
            }
            if (filterStorage.appliedFilter['attack_type'] != null) {
              attackTypeController.value = filterStorage.rawFilter['attack_type'] as String?;
            }
            if (filterStorage.appliedFilter['competitor'] != null) {
              nameController.value = filterStorage.rawFilter['competitor'] as CompetitorSearchResult?;
            }
            if (filterStorage.appliedFilter['enemy'] != null) {
              enemyController.value = filterStorage.rawFilter['enemy'] as String?;
            }
            localFilter = filterStorage.appliedFilter;
          } else {
            regionController.value = filterStorage.defaultFitlerValuesAbyss['region'] as String?;
            charactersController.value = filterStorage.defaultFitlerValuesAbyss['characters'] as List<String?>;
            attackTypeController.value = filterStorage.defaultFitlerValuesAbyss['attack_type'] as String?;
            nameController.value = filterStorage.defaultFitlerValuesAbyss['competitor'] as CompetitorSearchResult?;
            enemyController.value = filterStorage.defaultFitlerValuesAbyss['enemy'] as String?;
            localFilter = filterStorage.defaultAppliedFilter['Abyss'] as Map<String, dynamic>;
          }
        } else if (widget.category == 'Domain') {
          if ((filterStorage.defaultAppliedFilter['Domain'] as Map<String, dynamic>)
              .contentNotEquals(filterStorage.appliedFilter)) {
            if (filterStorage.appliedFilter['region'] != null) {
              regionController.value = filterStorage.appliedFilter['region'] as String?;
            }
            if (filterStorage.appliedFilter['characters'] != null) {
              charactersController.value = filterStorage.rawFilter['characters'] as List<String?>;
            }
            if (filterStorage.appliedFilter['attack_type'] != null) {
              attackTypeController.value = filterStorage.rawFilter['attack_type'] as String?;
            }
            if (filterStorage.appliedFilter['competitor'] != null) {
              nameController.value = filterStorage.rawFilter['competitor'] as CompetitorSearchResult?;
            }
            if (filterStorage.appliedFilter['domain'] != null) {
              domainController.value = filterStorage.rawFilter['domain'] as String;
            }
            localFilter = filterStorage.appliedFilter;
          } else {
            regionController.value = filterStorage.defaultFitlerValuesDomain['region'] as String?;
            charactersController.value = filterStorage.defaultFitlerValuesDomain['characters'] as List<String?>;
            attackTypeController.value = filterStorage.defaultFitlerValuesDomain['attack_type'] as String?;
            nameController.value = filterStorage.defaultFitlerValuesDomain['competitor'] as CompetitorSearchResult?;
            domainController.value = filterStorage.defaultFitlerValuesDomain['domain'] as String;
            localFilter = filterStorage.defaultAppliedFilter['Domain'] as Map<String, dynamic>;
          }
        } else if (widget.category == 'Event') {
          if ((filterStorage.defaultAppliedFilter['Event'] as Map<String, dynamic>)
              .contentNotEquals(filterStorage.appliedFilter)) {
            if (filterStorage.appliedFilter['region'] != null) {
              regionController.value = filterStorage.appliedFilter['region'] as String?;
            }
            if (filterStorage.appliedFilter['characters'] != null) {
              charactersController.value = filterStorage.rawFilter['characters'] as List<String?>;
            }
            if (filterStorage.appliedFilter['attack_type'] != null) {
              attackTypeController.value = filterStorage.rawFilter['attack_type'] as String?;
            }
            if (filterStorage.appliedFilter['competitor'] != null) {
              nameController.value = filterStorage.rawFilter['competitor'] as CompetitorSearchResult?;
            }
            if (filterStorage.appliedFilter['event'] != null) {
              eventController.value = filterStorage.rawFilter['event'] as String;
            }
            localFilter = filterStorage.appliedFilter;
          } else {
            regionController.value = filterStorage.defaultFitlerValuesEvent['region'] as String?;
            charactersController.value = filterStorage.defaultFitlerValuesEvent['characters'] as List<String?>;
            attackTypeController.value = filterStorage.defaultFitlerValuesEvent['attack_type'] as String?;
            nameController.value = filterStorage.defaultFitlerValuesEvent['competitor'] as CompetitorSearchResult?;
            eventController.value = filterStorage.defaultFitlerValuesEvent['event'] as String;
            localFilter = filterStorage.defaultAppliedFilter['Event'] as Map<String, dynamic>;
          }
        }
      }
    } catch (e, stackTrace) {
      log(e.toString(), name: 'Error in Filter');
      log(stackTrace.toString(), name: 'Error in Filter');
    } finally {
      // Reset the flag after initialization is complete
      _isInitializing = false;
    }
  }

  @override
  void dispose() {
    // Clean up listeners to prevent memory leaks
    charactersController.dispose();
    nameController.dispose();
    regionController.dispose();
    abyssVersionController.dispose();
    floorController.dispose();
    enemyController.dispose();
    domainController.dispose();
    eventController.dispose();
    attackTypeController.dispose();
    super.dispose();
  }
}
