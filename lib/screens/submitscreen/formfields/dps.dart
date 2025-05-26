import 'package:tgh_mobile/imports.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:dropdown_search/src/widgets/custom_scroll_view.dart';
import 'package:collection/collection.dart';

class DpsFields extends ConsumerStatefulWidget {
  const DpsFields(
      {super.key, required this.updateSubmitInfo, required this.category, this.domain = false, this.event = false});
  final void Function(String key, dynamic value) updateSubmitInfo;
  final String category;
  final bool domain;
  final bool event;

  @override
  ConsumerState<DpsFields> createState() => _DpsFieldsState();
}

class _DpsFieldsState extends ConsumerState<DpsFields> {
  final _enemyKey = GlobalKey<DropdownSearchState<String>>();
  final _gameVersionFieldKey = GlobalKey<FormFieldState>();
  final _enemyLevelFieldKey = GlobalKey<FormFieldState>();
  final _damageDealtFieldKey = GlobalKey<FormFieldState>();
  final _videoLinkFieldKey = GlobalKey<FormFieldState>();

  final TextEditingController _supportsController = TextEditingController();
  final TextEditingController _nukerController = TextEditingController();
  final TextEditingController _gameVersionController = TextEditingController();
  final TextEditingController _enemyLevelController = TextEditingController();
  final TextEditingController _damageDealtController = TextEditingController();
  final TextEditingController _videoLinkController = TextEditingController();

  bool _initRegion = false;
  bool stunned = false;
  bool food = false;

  final _regionKey = GlobalKey<DropdownSearchState<String>>();
  final _supportsKey = GlobalKey<DropdownSearchState<String>>();
  final _nukerKey = GlobalKey<DropdownSearchState<String>>();
  final _attackTypeKey = GlobalKey<DropdownSearchState<String>>();
  final _domainKey = GlobalKey<DropdownSearchState<String>>();
  final _eventKey = GlobalKey<DropdownSearchState<String>>();
  double _dragAccumulator = 0.0;

  @override
  void initState() {
    _videoLinkController.addListener(() {
      widget.updateSubmitInfo('video_link', _videoLinkController.text);
    });
    _gameVersionController.addListener(() {
      widget.updateSubmitInfo('game_version', _gameVersionController.text);
    });
    _enemyLevelController.addListener(() {
      widget.updateSubmitInfo('enemy_lv', _enemyLevelController.text);
    });
    _damageDealtController.addListener(() {
      widget.updateSubmitInfo('damage_dealt', _damageDealtController.text);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      if (MediaQuery.of(context).size.width > 600) ...[
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(flex: 1, child: regionField(context)),
          SizedBox(width: 10.wr),
          Expanded(flex: 1, child: gameVersionField(context)),
          SizedBox(width: 10.wr),
          Expanded(flex: 1, child: videoLinkField(context)),
        ]),
        const SizedBox(height: 20),
        if (widget.domain) domainField(context),
        if (widget.event) eventField(context),
        if (widget.domain || widget.event) const SizedBox(height: 20),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(flex: 1, child: nukerField(context)),
          SizedBox(width: 10.wr),
          Expanded(flex: 1, child: supportsField(context)),
          SizedBox(width: 10.wr),
          Expanded(flex: 1, child: attackTypeField(context)),
          SizedBox(width: 10.wr),
          stunCheckBox(context),
        ]),
        const SizedBox(height: 20),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(flex: 1, child: enemyField(context)),
          SizedBox(width: 10.wr),
          Expanded(flex: 1, child: enemyLevelField(context)),
          SizedBox(width: 10.wr),
          Expanded(flex: 1, child: damageDealtField(context)),
          SizedBox(width: 10.wr),
          foodCheckBox(context),
        ]),
      ] else ...[
        regionField(context),
        const SizedBox(height: 20),
        gameVersionField(context),
        const SizedBox(height: 20),
        videoLinkField(context),
        const SizedBox(height: 20),
        if (widget.domain) domainField(context),
        if (widget.event) eventField(context),
        const SizedBox(height: 20),
        enemyField(context),
        const SizedBox(height: 20),
        enemyLevelField(context),
        const SizedBox(height: 20),
        damageDealtField(context),
        const SizedBox(height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          stunCheckBox(context),
          foodCheckBox(context),
        ]),
        const SizedBox(height: 20),
        nukerField(context),
        const SizedBox(height: 20),
        supportsField(context),
        const SizedBox(height: 20),
        attackTypeField(context),
      ],
    ]);
  }

  Widget supportsField(BuildContext context) {
    return SizedBox(
        // height: 76,
        child: ref.watch(gameAssetProvider).when(
              data: (data) {
                switch (data) {
                  case GameAssetStateLoaded(:final characters):
                    return DropdownSearch<String>.multiSelection(
                      key: _supportsKey,
                      items: (filter, loadProps) => characters?.map((e) => e.name).toList() ?? [],
                      onChanged: (value) => widget.updateSubmitInfo('team', value),
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      suffixProps: const DropdownSuffixProps(clearButtonProps: ClearButtonProps(isVisible: true)),
                      decoratorProps: DropDownDecoratorProps(
                          decoration: InputDecoration(
                        filled: true,
                        labelText: 'Supports',
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                        // helperText: ' ',
                        errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 2)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Theme.of(context).colorScheme.outline, width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Theme.of(context).colorScheme.outline, width: 2)),
                      )),
                      popupProps: PopupPropsMultiSelection.menu(
                        showSearchBox: true,
                        searchFieldProps: TextFieldProps(
                            controller: _supportsController,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Theme.of(context).colorScheme.surfaceContainerLow,
                                hintText: 'Search characters',
                                suffixIcon: const Icon(Icons.search, size: 24),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Theme.of(context).colorScheme.outline, width: 1)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Theme.of(context).colorScheme.outline, width: 2)))),
                        validationBuilder: (context, items) {
                          return const SizedBox.shrink();
                        },
                        checkBoxBuilder: (context, item, isDisabled, isSelected) => Container(
                          margin: const EdgeInsets.only(right: 8),
                          child: Checkbox(
                            value: isSelected,
                            onChanged: (value) {
                              if (isDisabled) return;
                              if (value!) {
                                _supportsKey.currentState?.changeSelectedItems(<String>[item]);
                                _supportsController.clear();
                              } else {
                                _supportsKey.currentState?.removeItem(item);
                              }
                            },
                          ),
                        ),
                        itemBuilder: (context, item, isDisabled, isSelected) => ListTile(
                          title: Text(item),
                          leading: UniformCircleAvatar(
                              url: characters?.firstWhereOrNull((element) => element.name == item)?.avatar ?? '',
                              radius: 20),
                          selected: isSelected,
                          enabled: !isDisabled,
                          onTap: () {
                            if (isDisabled) return;
                            if (isSelected) {
                              _supportsKey.currentState?.removeItem(item);
                            } else {
                              _supportsKey.currentState?.changeSelectedItems(<String>[item]);
                              _supportsController.clear();
                            }
                          },
                        ),
                        menuProps: MenuProps(
                          backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Theme.of(context).colorScheme.outline, width: 1)),
                        ),
                        fit: FlexFit.loose,
                        onItemAdded: (selectedItems, addedItem) {
                          _supportsKey.currentState?.changeSelectedItems(<String>[...selectedItems]);
                          _supportsController.clear();
                        },
                        onItemRemoved: (selectedItems, removedItem) {
                          _supportsKey.currentState?.removeItem(removedItem);
                        },
                      ),
                      dropdownBuilder: (context, selectedItems) {
                        return CustomSingleScrollView(
                            scrollProps: const ScrollProps(scrollDirection: Axis.horizontal),
                            child: Wrap(
                                direction: Axis.horizontal,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: selectedItems.map((e) {
                                  return Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: RemoveableChip(
                                          label: e,
                                          onDeleted: () {
                                            _supportsKey.currentState?.removeItem(e);
                                          }));
                                }).toList()));
                      },
                    );
                  default:
                    return const SizedBox.shrink();
                }
              },
              loading: () => Center(child: SizedBox(height: 48, child: ShimmerComponent.regtangular(height: 48))),
              error: (error, stackTrace) =>
                  Center(child: SizedBox(height: 48, child: ShimmerComponent.regtangular(height: 48))),
            ));
  }

  Widget nukerField(BuildContext context) {
    return SizedBox(
        // height: 76,
        child: ref.watch(gameAssetProvider).when(
              data: (data) {
                switch (data) {
                  case GameAssetStateLoaded(:final characters):
                    return GestureDetector(
                        onVerticalDragUpdate: (details) {
                          _dragAccumulator += details.primaryDelta!;
                          const double dragThreshold = 10.0;

                          List<String> items = characters?.map((e) => e.name).toList() ?? [];
                          final currentValue = _nukerKey.currentState?.getSelectedItem;

                          if (currentValue == null) {
                            _nukerKey.currentState?.changeSelectedItem(items.first);
                            return;
                          }

                          int currentIndex = items.indexOf(currentValue);

                          if (_dragAccumulator > dragThreshold) {
                            if (currentIndex < items.length - 1) {
                              _nukerKey.currentState?.changeSelectedItem(items[currentIndex + 1]);
                            }
                            _dragAccumulator = 0.0;
                          } else if (_dragAccumulator < -dragThreshold) {
                            if (currentIndex > 0) {
                              _nukerKey.currentState?.changeSelectedItem(items[currentIndex - 1]);
                            }
                            _dragAccumulator = 0.0;
                          }
                        },
                        child: SizedBox(
                          // height: 76,
                          child: DropdownSearch<String>(
                              key: _nukerKey,
                              items: (f, cs) => characters?.map((e) => e.name).toList() ?? [],
                              validator: (value) {
                                if (value == null) {
                                  return 'Nuker is required';
                                }
                                return null;
                              },
                              autoValidateMode: AutovalidateMode.onUserInteraction,
                              popupProps: PopupProps.menu(
                                  fit: FlexFit.loose,
                                  itemBuilder: (context, item, isDisabled, isSelected) => ListTile(
                                      title: Text(item),
                                      leading: UniformCircleAvatar(
                                          url:
                                              characters?.firstWhereOrNull((element) => element.name == item)?.avatar ??
                                                  '',
                                          radius: 20),
                                      selected: isSelected,
                                      enabled: !isDisabled,
                                      onTap: () {
                                        if (isDisabled) return;
                                        if (isSelected) {
                                          _nukerKey.currentState?.removeItem(item);
                                        } else {
                                          _nukerKey.currentState?.changeSelectedItems(<String>[item]);
                                          _nukerController.clear();
                                        }
                                      }),
                                  menuProps: MenuProps(
                                    backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                                  )),
                              onChanged: (value) => widget.updateSubmitInfo('dps_character', value),
                              decoratorProps: DropDownDecoratorProps(
                                  baseStyle: const TextStyle(fontSize: 16, overflow: TextOverflow.ellipsis),
                                  decoration: InputDecoration(
                                      labelText: 'Nuker',
                                      filled: true,
                                      // helperText: ' ',
                                      errorBorder:
                                          const OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 2)),
                                      border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Theme.of(context).colorScheme.outline, width: 1)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Theme.of(context).colorScheme.primary, width: 2)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Theme.of(context).colorScheme.outline, width: 2))))),
                        ));
                  default:
                    return const SizedBox.shrink();
                }
              },
              loading: () => Center(child: SizedBox(height: 48, child: ShimmerComponent.regtangular(height: 48))),
              error: (error, stackTrace) =>
                  Center(child: SizedBox(height: 48, child: ShimmerComponent.regtangular(height: 48))),
            ));
  }

  Widget regionField(BuildContext context) {
    final auth = ref.watch(authNotifierProvider);
    return auth.when(
      data: (data) {
        Competitor? competitor;
        switch (data) {
          case AuthStateAuthenticated(:final user):
            competitor = user.competitor;
            break;
          default:
            competitor = null;
            break;
        }
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          if (!_initRegion) {
            widget.updateSubmitInfo('region', uidToRegion(competitor?.uid.toString() ?? ''));
            _initRegion = true;
          }
        });
        return GestureDetector(
            onVerticalDragUpdate: (details) {
              _dragAccumulator += details.primaryDelta!;
              const double dragThreshold = 10.0;

              const items = REGIONS;
              final currentValue = _regionKey.currentState?.getSelectedItem;

              if (currentValue == null) {
                _regionKey.currentState?.changeSelectedItem(items.first);
                return;
              }

              int currentIndex = items.indexOf(currentValue);

              if (_dragAccumulator > dragThreshold) {
                if (currentIndex < items.length - 1) {
                  _regionKey.currentState?.changeSelectedItem(items[currentIndex + 1]);
                }
                _dragAccumulator = 0.0;
              } else if (_dragAccumulator < -dragThreshold) {
                if (currentIndex > 0) {
                  _regionKey.currentState?.changeSelectedItem(items[currentIndex - 1]);
                }
                _dragAccumulator = 0.0;
              }
            },
            child: SizedBox(
              // height: 76,
              child: DropdownSearch<String>(
                  key: _regionKey,
                  items: (f, cs) => REGIONS,
                  validator: (value) {
                    if (value == null) {
                      return 'Region is required';
                    }
                    return null;
                  },
                  selectedItem: uidToRegion(competitor?.uid.toString() ?? ''),
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  popupProps: PopupProps.menu(
                      fit: FlexFit.loose,
                      menuProps: MenuProps(
                        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                      )),
                  onChanged: (value) => widget.updateSubmitInfo('region', value),
                  decoratorProps: DropDownDecoratorProps(
                      baseStyle: const TextStyle(fontSize: 16, overflow: TextOverflow.ellipsis),
                      decoration: InputDecoration(
                          labelText: 'Region',
                          filled: true,
                          // helperText: ' ',
                          errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 2)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).colorScheme.outline, width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).colorScheme.outline, width: 2))))),
            ));
      },
      error: (error, stackTrace) =>
          Center(child: SizedBox(height: 50, child: ShimmerComponent.regtangular(height: 50))),
      loading: () => Center(child: SizedBox(height: 50, child: ShimmerComponent.regtangular(height: 50))),
    );
  }

  Widget enemyLevelField(BuildContext context) {
    return UniformTextFormField(
      fieldKey: _enemyLevelFieldKey, // Add field key for validation
      padding: EdgeInsets.zero,
      controller: _enemyLevelController,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enemy level is required';
        }
        return null;
      },
      decoration: InputDecoration(
        filled: true,
        labelText: 'Enemy level',
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        // helperText: ' ',
        errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 2)),
        border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.outline, width: 1)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2)),
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.outline, width: 2)),
      ),
    );
  }

  Widget damageDealtField(BuildContext context) {
    return UniformTextFormField(
      fieldKey: _damageDealtFieldKey, // Add field key for validation
      padding: EdgeInsets.zero,
      controller: _damageDealtController,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Damage dealt is required';
        }
        return null;
      },
      decoration: InputDecoration(
        filled: true,
        labelText: 'Damage dealt',
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        // helperText: ' ',
        errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 2)),
        border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.outline, width: 1)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2)),
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.outline, width: 2)),
      ),
    );
  }

  Widget gameVersionField(BuildContext context) {
    return UniformTextFormField(
      fieldKey: _gameVersionFieldKey, // Add field key for validation
      padding: EdgeInsets.zero,
      controller: _gameVersionController,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Game version is required';
        }
        return null;
      },
      decoration: InputDecoration(
        filled: true,
        labelText: 'Game Version',
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        // helperText: ' ',
        errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 2)),
        border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.outline, width: 1)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2)),
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.outline, width: 2)),
      ),
    );
  }

  Widget videoLinkField(BuildContext context) {
    return UniformTextFormField(
      fieldKey: _videoLinkFieldKey, // Add field key for validation
      padding: EdgeInsets.zero,
      controller: _videoLinkController,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Video link is required';
        }
        return null;
      },
      maxLines: 1,
      decoration: InputDecoration(
          filled: true,
          labelText: 'Video Link',
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          // helperText: ' ',
          errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 2)),
          border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.outline, width: 1)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2)),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.outline, width: 2))),
    );
  }

  Widget enemyField(BuildContext context) {
    return GestureDetector(
        onVerticalDragUpdate: (details) {
          _dragAccumulator += details.primaryDelta!;
          const double dragThreshold = 10.0;

          var items = widget.category == 'Weekly Boss'
              ? WEEKLY_BOSSES
              : widget.category == 'World Boss'
                  ? WORLD_BOSSES
                  : OVERWORLD_MOBS;
          final currentValue = _enemyKey.currentState?.getSelectedItem;

          if (currentValue == null) {
            _enemyKey.currentState?.changeSelectedItem(items.first);
            return;
          }

          int currentIndex = items.indexOf(currentValue);

          if (_dragAccumulator > dragThreshold) {
            if (currentIndex < items.length - 1) {
              _enemyKey.currentState?.changeSelectedItem(items[currentIndex + 1]);
            }
            _dragAccumulator = 0.0;
          } else if (_dragAccumulator < -dragThreshold) {
            if (currentIndex > 0) {
              _enemyKey.currentState?.changeSelectedItem(items[currentIndex - 1]);
            }
            _dragAccumulator = 0.0;
          }
        },
        child: SizedBox(
          // height: 76,
          child: DropdownSearch<String>(
              key: _enemyKey,
              items: (f, cs) => widget.category == 'Weekly Boss'
                  ? WEEKLY_BOSSES
                  : widget.category == 'World Boss'
                      ? WORLD_BOSSES
                      : OVERWORLD_MOBS,
              popupProps: PopupProps.menu(
                  fit: FlexFit.loose,
                  menuProps: MenuProps(
                    backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                  )),
              validator: (value) {
                if (value == null) {
                  return 'Enemy is required';
                }
                return null;
              },
              onChanged: (value) {
                widget.updateSubmitInfo('enemy', value);
              },
              autoValidateMode: AutovalidateMode.onUserInteraction,
              decoratorProps: DropDownDecoratorProps(
                  baseStyle: const TextStyle(fontSize: 16, overflow: TextOverflow.ellipsis),
                  decoration: InputDecoration(
                      labelText: 'Enemy',
                      filled: true,
                      // helperText: ' ',
                      errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 2)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).colorScheme.outline, width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).colorScheme.outline, width: 2))))),
        ));
  }

  Widget attackTypeField(BuildContext context) {
    return GestureDetector(
        onVerticalDragUpdate: (details) {
          _dragAccumulator += details.primaryDelta!;
          const double dragThreshold = 10.0;

          var items = ATTACK_TYPES;
          final currentValue = _attackTypeKey.currentState?.getSelectedItem;

          if (currentValue == null) {
            _attackTypeKey.currentState?.changeSelectedItem(items.first);
            return;
          }

          int currentIndex = items.indexOf(currentValue);

          if (_dragAccumulator > dragThreshold) {
            if (currentIndex < items.length - 1) {
              _attackTypeKey.currentState?.changeSelectedItem(items[currentIndex + 1]);
            }
            _dragAccumulator = 0.0;
          } else if (_dragAccumulator < -dragThreshold) {
            if (currentIndex > 0) {
              _attackTypeKey.currentState?.changeSelectedItem(items[currentIndex - 1]);
            }
            _dragAccumulator = 0.0;
          }
        },
        child: SizedBox(
          // height: 76,
          child: DropdownSearch<String>(
              key: _attackTypeKey,
              items: (f, cs) => ATTACK_TYPES,
              popupProps: PopupProps.menu(
                  fit: FlexFit.loose,
                  menuProps: MenuProps(
                    backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                  )),
              validator: (value) {
                if (value == null) {
                  return 'Attack type is required';
                }
                return null;
              },
              onChanged: (value) {
                widget.updateSubmitInfo('attack_type', value);
              },
              autoValidateMode: AutovalidateMode.onUserInteraction,
              decoratorProps: DropDownDecoratorProps(
                  baseStyle: const TextStyle(fontSize: 16, overflow: TextOverflow.ellipsis),
                  decoration: InputDecoration(
                      labelText: 'Attack type',
                      filled: true,
                      // helperText: ' ',
                      errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 2)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).colorScheme.outline, width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).colorScheme.outline, width: 2))))),
        ));
  }

  Widget stunCheckBox(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Checkbox(
            value: stunned,
            onChanged: (value) {
              setState(() {
                stunned = value!;
                widget.updateSubmitInfo('stunned', value);
              });
            }),
        SizedBox(width: 5.wr),
        Text('Stunned?', style: TextStyle(fontSize: 16.swr)),
      ]),
    );
  }

  Widget foodCheckBox(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Checkbox(
            value: food,
            onChanged: (value) {
              setState(() {
                food = value!;
                widget.updateSubmitInfo('food_used', value);
              });
            }),
        SizedBox(width: 5.wr),
        Text('Food used?', style: TextStyle(fontSize: 16.swr)),
      ]),
    );
  }

  Widget domainField(BuildContext context) {
    return GestureDetector(
        onVerticalDragUpdate: (details) {
          _dragAccumulator += details.primaryDelta!;
          const double dragThreshold = 10.0;

          const items = SPEEDRUN_ABYSS_CHAMBERS;
          final currentValue = _domainKey.currentState?.getSelectedItem;

          if (currentValue == null) {
            _domainKey.currentState?.changeSelectedItem(items.first);
            return;
          }

          int currentIndex = items.indexOf(currentValue);

          if (_dragAccumulator > dragThreshold) {
            if (currentIndex < items.length - 1) {
              _domainKey.currentState?.changeSelectedItem(items[currentIndex + 1]);
            }
            _dragAccumulator = 0.0;
          } else if (_dragAccumulator < -dragThreshold) {
            if (currentIndex > 0) {
              _domainKey.currentState?.changeSelectedItem(items[currentIndex - 1]);
            }
            _dragAccumulator = 0.0;
          }
        },
        child: SizedBox(
          // height: 76,
          child: DropdownSearch<String>(
              key: _domainKey,
              items: (f, cs) => DOMAIN,
              popupProps: PopupProps.menu(
                  fit: FlexFit.loose,
                  menuProps: MenuProps(
                    backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                  )),
              validator: (value) {
                if (value == null) {
                  return 'Domain name is required';
                }
                return null;
              },
              onChanged: (value) {
                widget.updateSubmitInfo('domain', value);
              },
              autoValidateMode: AutovalidateMode.onUserInteraction,
              selectedItem: DOMAIN[0],
              decoratorProps: DropDownDecoratorProps(
                  baseStyle: const TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                      labelText: 'Domain',
                      filled: true,
                      // helperText: ' ',
                      errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 2)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).colorScheme.outline, width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).colorScheme.outline, width: 2))))),
        ));
  }

  Widget eventField(BuildContext context) {
    return GestureDetector(
        onVerticalDragUpdate: (details) {
          _dragAccumulator += details.primaryDelta!;
          const double dragThreshold = 10.0;

          const items = DPS_EVENTS;
          final currentValue = _eventKey.currentState?.getSelectedItem;

          if (currentValue == null) {
            _eventKey.currentState?.changeSelectedItem(items.first);
            return;
          }

          int currentIndex = items.indexOf(currentValue);

          if (_dragAccumulator > dragThreshold) {
            if (currentIndex < items.length - 1) {
              _eventKey.currentState?.changeSelectedItem(items[currentIndex + 1]);
            }
            _dragAccumulator = 0.0;
          } else if (_dragAccumulator < -dragThreshold) {
            if (currentIndex > 0) {
              _eventKey.currentState?.changeSelectedItem(items[currentIndex - 1]);
            }
            _dragAccumulator = 0.0;
          }
        },
        child: SizedBox(
          // height: 76,
          child: DropdownSearch<String>(
              key: _eventKey,
              items: (f, cs) => DPS_EVENTS,
              popupProps: PopupProps.menu(
                  fit: FlexFit.loose,
                  menuProps: MenuProps(
                    backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                  )),
              validator: (value) {
                if (value == null) {
                  return 'Event name is required';
                }
                return null;
              },
              onChanged: (value) {
                widget.updateSubmitInfo('event', value);
              },
              autoValidateMode: AutovalidateMode.onUserInteraction,
              selectedItem: DPS_EVENTS[0],
              decoratorProps: DropDownDecoratorProps(
                  baseStyle: const TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                      labelText: 'Event',
                      filled: true,
                      // helperText: ' ',
                      errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 2)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).colorScheme.outline, width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).colorScheme.outline, width: 2))))),
        ));
  }

  @override
  void dispose() {
    _videoLinkController.dispose();
    _gameVersionController.dispose();
    _enemyLevelController.dispose();
    _damageDealtController.dispose();
    _nukerController.dispose();
    _supportsController.dispose();
    super.dispose();
  }
}
