import 'package:tgh_mobile/imports.dart';

class Filter extends ConsumerStatefulWidget {
  const Filter({super.key, required this.type, required this.category});
  final String type;
  final String category;

  @override
  ConsumerState<Filter> createState() => _FilterState();
}

class _FilterState extends ConsumerState<Filter> {
  final SingleSelectController<String> abyssVersionController =
      SingleSelectController<String>(ABYSS_VERSION_HISTORY.last);
  final SingleSelectController<String?> regionController = SingleSelectController<String?>(null);
  final SingleSelectController<CompetitorSearchResult?> nameController =
      SingleSelectController<CompetitorSearchResult?>(null);
  final SingleSelectController<String?> floorController = SingleSelectController<String?>(null);
  final MultiSelectController<String?> charactersController = MultiSelectController<String?>([]);
  final SingleSelectController<String?> enemyController = SingleSelectController<String?>(null);
  final SingleSelectController<String?> domainController = SingleSelectController<String?>(null);
  final SingleSelectController<String?> eventController = SingleSelectController<String?>(null);
  final SingleSelectController<String?> attackTypeController = SingleSelectController<String?>(null);
  double _dragAccumulator = 0.0;

  String? abyssVersion;
  String? floor;
  String? region;
  String? name;
  List<String?> characterFilter = [];
  String? enemy;
  String? domain;
  String? event;
  String? attackType;
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
                  onChanged: (p0) {
                    setState(() {
                      name = p0?.alias;
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
                        abyssVersion = p0;
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
                          floor = p0;
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
                        closedSuffixIcon: floorController.hasValue
                            ? SizedBox(
                                width: 12.wr,
                                height: 12.wr,
                                child: IconButton(
                                    onPressed: () {
                                      domainController.clear();
                                    },
                                    padding: const EdgeInsets.all(0),
                                    icon: Icon(Icons.close, size: 10.wr)))
                            : Icon(Icons.arrow_drop_down, size: 10.wr),
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
                          domain = p0;
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
                          event = p0;
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
                          enemy = p0;
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
                          attackType = p0;
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
                        region = p0;
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
                          characterFilter = p0;
                        });
                      })
                ]));
          })
    ]);
  }
}
