// ignore_for_file: non_constant_identifier_names

import 'package:tgh_mobile/imports.dart';
import 'package:dropdown_search/dropdown_search.dart';

class SpeedrunAbyssFields extends ConsumerStatefulWidget {
  const SpeedrunAbyssFields({super.key, required this.updateSubmitInfo});
  final void Function(String key, dynamic value) updateSubmitInfo;

  @override
  ConsumerState<SpeedrunAbyssFields> createState() => _SpeedrunAbyssFieldsState();
}

class _SpeedrunAbyssFieldsState extends ConsumerState<SpeedrunAbyssFields> {
  bool _hasSegment = false;
  bool _initRegion = false;
  final TextEditingController _abyssVersionController = TextEditingController(text: ABYSS_VERSION_HISTORY.last);
  final TextEditingController _gameVersionController = TextEditingController();
  final TextEditingController _videoLinkController = TextEditingController();
  final _abyssFloorKey = GlobalKey<DropdownSearchState<String>>();
  final _regionKey = GlobalKey<DropdownSearchState<String>>();

  // Add form field keys for validation
  final _abyssVersionFieldKey = GlobalKey<FormFieldState>();
  final _gameVersionFieldKey = GlobalKey<FormFieldState>();
  final _videoLinkFieldKey = GlobalKey<FormFieldState>();

  // Add keys for segment fields
  final _12_1_1FieldKey = GlobalKey<FormFieldState>();
  final _12_1_2FieldKey = GlobalKey<FormFieldState>();
  final _12_2_1FieldKey = GlobalKey<FormFieldState>();
  final _12_2_2FieldKey = GlobalKey<FormFieldState>();
  final _12_3_1FieldKey = GlobalKey<FormFieldState>();
  final _12_3_2FieldKey = GlobalKey<FormFieldState>();

  /// 12-1-1
  final TextEditingController _12_1_1Controller = TextEditingController();

  /// 12-1-2
  final TextEditingController _12_1_2Controller = TextEditingController();

  /// 12-2-1
  final TextEditingController _12_2_1Controller = TextEditingController();

  /// 12-2-2
  final TextEditingController _12_2_2Controller = TextEditingController();

  /// 12-3-1
  final TextEditingController _12_3_1Controller = TextEditingController();

  /// 12-3-2
  final TextEditingController _12_3_2Controller = TextEditingController();

  double _dragAccumulator = 0.0;

  @override
  void initState() {
    _abyssVersionController.addListener(() {
      widget.updateSubmitInfo('abyss_version', _abyssVersionController.text);
    });
    _gameVersionController.addListener(() {
      widget.updateSubmitInfo('game_version', _gameVersionController.text);
    });
    _videoLinkController.addListener(() {
      widget.updateSubmitInfo('video_link', _videoLinkController.text);
    });
    _12_1_1Controller.addListener(() {
      widget.updateSubmitInfo('12_1_1', _12_1_1Controller.text);
    });
    _12_1_2Controller.addListener(() {
      widget.updateSubmitInfo('12_1_2', _12_1_2Controller.text);
    });
    _12_2_1Controller.addListener(() {
      widget.updateSubmitInfo('12_2_1', _12_2_1Controller.text);
    });
    _12_2_2Controller.addListener(() {
      widget.updateSubmitInfo('12_2_2', _12_2_2Controller.text);
    });
    _12_3_1Controller.addListener(() {
      widget.updateSubmitInfo('12_3_1', _12_3_1Controller.text);
    });
    _12_3_2Controller.addListener(() {
      widget.updateSubmitInfo('12_3_2', _12_3_2Controller.text);
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
          Expanded(flex: 1, child: abyssVersionField(context)),
        ]),
      ] else ...[
        regionField(context),
        const SizedBox(height: 20),
        gameVersionField(context),
        const SizedBox(height: 20),
        abyssVersionField(context)
      ],
      if (MediaQuery.of(context).size.width > 600) ...[
        const SizedBox(height: 20),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(flex: 4, child: abyssFloorField(context)),
          SizedBox(width: 10.wr),
          Expanded(flex: 5, child: videoLinkField(context)),
          SizedBox(width: 10.wr),
          segmentCheckBox(context)
        ])
      ] else ...[
        const SizedBox(height: 20),
        abyssFloorField(context),
        const SizedBox(height: 20),
        Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Expanded(child: videoLinkField(context)), SizedBox(width: 10.wr), segmentCheckBox(context)])
      ],
      const SizedBox(height: 20),
      if (_hasSegment) ...[
        if (_abyssFloorKey.currentState?.getSelectedItem == '12-1-1')
          segmentField(context, 'Chamber 12-1-1', _12_1_1Controller, _12_1_1FieldKey),
        if (_abyssFloorKey.currentState?.getSelectedItem == '12-1-2')
          segmentField(context, 'Chamber 12-1-2', _12_1_2Controller, _12_1_2FieldKey),
        if (_abyssFloorKey.currentState?.getSelectedItem == '12-2-1')
          segmentField(context, 'Chamber 12-2-1', _12_2_1Controller, _12_2_1FieldKey),
        if (_abyssFloorKey.currentState?.getSelectedItem == '12-2-2')
          segmentField(context, 'Chamber 12-2-2', _12_2_2Controller, _12_2_2FieldKey),
        if (_abyssFloorKey.currentState?.getSelectedItem == '12-3-1')
          segmentField(context, 'Chamber 12-3-1', _12_3_1Controller, _12_3_1FieldKey),
        if (_abyssFloorKey.currentState?.getSelectedItem == '12-3-2')
          segmentField(context, 'Chamber 12-3-2', _12_3_2Controller, _12_3_2FieldKey),
        if (_abyssFloorKey.currentState?.getSelectedItem == '12-1') ...[
          if (MediaQuery.of(context).size.width > 600) ...[
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(flex: 1, child: segmentField(context, 'Chamber 12-1-1', _12_1_1Controller, _12_1_1FieldKey)),
              SizedBox(width: 10.wr),
              Expanded(flex: 1, child: segmentField(context, 'Chamber 12-1-2', _12_1_2Controller, _12_1_2FieldKey)),
            ]),
          ] else ...[
            segmentField(context, 'Chamber 12-1-1', _12_1_1Controller, _12_1_1FieldKey),
            const SizedBox(height: 20),
            segmentField(context, 'Chamber 12-1-2', _12_1_2Controller, _12_1_2FieldKey),
          ]
        ],
        if (_abyssFloorKey.currentState?.getSelectedItem == '12-2') ...[
          if (MediaQuery.of(context).size.width > 600) ...[
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(flex: 1, child: segmentField(context, 'Chamber 12-2-1', _12_2_1Controller, _12_2_1FieldKey)),
              SizedBox(width: 10.wr),
              Expanded(flex: 1, child: segmentField(context, 'Chamber 12-2-2', _12_2_2Controller, _12_2_2FieldKey)),
            ]),
          ] else ...[
            segmentField(context, 'Chamber 12-2-1', _12_2_1Controller, _12_2_1FieldKey),
            const SizedBox(height: 20),
            segmentField(context, 'Chamber 12-2-2', _12_2_2Controller, _12_2_2FieldKey),
          ]
        ],
        if (_abyssFloorKey.currentState?.getSelectedItem == '12-3') ...[
          if (MediaQuery.of(context).size.width > 600) ...[
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(flex: 1, child: segmentField(context, 'Chamber 12-3-1', _12_3_1Controller, _12_3_1FieldKey)),
              SizedBox(width: 10.wr),
              Expanded(flex: 1, child: segmentField(context, 'Chamber 12-3-2', _12_3_2Controller, _12_3_2FieldKey)),
            ]),
          ] else ...[
            segmentField(context, 'Chamber 12-3-1', _12_3_1Controller, _12_3_1FieldKey),
            const SizedBox(height: 20),
            segmentField(context, 'Chamber 12-3-2', _12_3_2Controller, _12_3_2FieldKey),
          ]
        ],
        if (_abyssFloorKey.currentState?.getSelectedItem == '12-top') ...[
          if (MediaQuery.of(context).size.width > 600) ...[
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(flex: 1, child: segmentField(context, 'Chamber 12-1-1', _12_1_1Controller, _12_1_1FieldKey)),
              SizedBox(width: 10.wr),
              Expanded(flex: 1, child: segmentField(context, 'Chamber 12-2-1', _12_2_1Controller, _12_2_1FieldKey)),
              SizedBox(width: 10.wr),
              Expanded(flex: 1, child: segmentField(context, 'Chamber 12-3-1', _12_3_1Controller, _12_3_1FieldKey)),
            ]),
          ] else ...[
            segmentField(context, 'Chamber 12-1-1', _12_1_1Controller, _12_1_1FieldKey),
            const SizedBox(height: 20),
            segmentField(context, 'Chamber 12-2-1', _12_2_1Controller, _12_2_1FieldKey),
            const SizedBox(height: 20),
            segmentField(context, 'Chamber 12-3-1', _12_3_1Controller, _12_3_1FieldKey),
          ]
        ],
        if (_abyssFloorKey.currentState?.getSelectedItem == '12-bot') ...[
          if (MediaQuery.of(context).size.width > 600) ...[
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(flex: 1, child: segmentField(context, 'Chamber 12-1-2', _12_1_2Controller, _12_1_2FieldKey)),
              SizedBox(width: 10.wr),
              Expanded(flex: 1, child: segmentField(context, 'Chamber 12-2-2', _12_2_2Controller, _12_2_2FieldKey)),
              SizedBox(width: 10.wr),
              Expanded(flex: 1, child: segmentField(context, 'Chamber 12-3-2', _12_3_2Controller, _12_3_2FieldKey)),
            ]),
          ] else ...[
            segmentField(context, 'Chamber 12-1-2', _12_1_2Controller, _12_1_2FieldKey),
            const SizedBox(height: 20),
            segmentField(context, 'Chamber 12-2-2', _12_2_2Controller, _12_2_2FieldKey),
            const SizedBox(height: 20),
            segmentField(context, 'Chamber 12-3-2', _12_3_2Controller, _12_3_2FieldKey),
          ]
        ],
        if (_abyssFloorKey.currentState?.getSelectedItem == '12-all') ...[
          if (MediaQuery.of(context).size.width > 600) ...[
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(flex: 1, child: segmentField(context, 'Chamber 12-1-1', _12_1_1Controller, _12_1_1FieldKey)),
              SizedBox(width: 10.wr),
              Expanded(flex: 1, child: segmentField(context, 'Chamber 12-1-2', _12_1_2Controller, _12_1_2FieldKey)),
              SizedBox(width: 10.wr),
              Expanded(flex: 1, child: segmentField(context, 'Chamber 12-2-1', _12_2_1Controller, _12_2_1FieldKey)),
            ]),
            const SizedBox(height: 20),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(flex: 1, child: segmentField(context, 'Chamber 12-3-1', _12_3_1Controller, _12_3_1FieldKey)),
              SizedBox(width: 10.wr),
              Expanded(flex: 1, child: segmentField(context, 'Chamber 12-3-2', _12_3_2Controller, _12_3_2FieldKey)),
              SizedBox(width: 10.wr),
              Expanded(flex: 1, child: segmentField(context, 'Chamber 12-2-2', _12_2_2Controller, _12_2_2FieldKey)),
            ]),
          ] else ...[
            segmentField(context, 'Chamber 12-1-1', _12_1_1Controller, _12_1_1FieldKey),
            const SizedBox(height: 20),
            segmentField(context, 'Chamber 12-1-2', _12_1_2Controller, _12_1_2FieldKey),
            const SizedBox(height: 20),
            segmentField(context, 'Chamber 12-2-1', _12_2_1Controller, _12_2_1FieldKey),
            const SizedBox(height: 20),
            segmentField(context, 'Chamber 12-2-2', _12_2_2Controller, _12_2_2FieldKey),
            const SizedBox(height: 20),
            segmentField(context, 'Chamber 12-3-1', _12_3_1Controller, _12_3_1FieldKey),
            const SizedBox(height: 20),
            segmentField(context, 'Chamber 12-3-2', _12_3_2Controller, _12_3_2FieldKey),
          ]
        ],
        const SizedBox(height: 20),
      ]
    ]);
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
                      baseStyle: const TextStyle(fontSize: 16),
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

  Widget abyssVersionField(BuildContext context) {
    return UniformTextFormField(
      fieldKey: _abyssVersionFieldKey, // Add field key for validation
      padding: EdgeInsets.zero,
      controller: _abyssVersionController,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Abyss version is required';
        }
        return null;
      },
      decoration: InputDecoration(
        filled: true,
        labelText: 'Abyss Version',
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

  Widget abyssFloorField(BuildContext context) {
    return GestureDetector(
        onVerticalDragUpdate: (details) {
          _dragAccumulator += details.primaryDelta!;
          const double dragThreshold = 10.0;

          const items = SPEEDRUN_ABYSS_CHAMBERS;
          final currentValue = _abyssFloorKey.currentState?.getSelectedItem;

          if (currentValue == null) {
            _abyssFloorKey.currentState?.changeSelectedItem(items.first);
            return;
          }

          int currentIndex = items.indexOf(currentValue);

          if (_dragAccumulator > dragThreshold) {
            if (currentIndex < items.length - 1) {
              _abyssFloorKey.currentState?.changeSelectedItem(items[currentIndex + 1]);
            }
            _dragAccumulator = 0.0;
          } else if (_dragAccumulator < -dragThreshold) {
            if (currentIndex > 0) {
              _abyssFloorKey.currentState?.changeSelectedItem(items[currentIndex - 1]);
            }
            _dragAccumulator = 0.0;
          }
        },
        child: SizedBox(
          // height: 76,
          child: DropdownSearch<String>(
              key: _abyssFloorKey,
              items: (f, cs) => SPEEDRUN_ABYSS_CHAMBERS,
              popupProps: PopupProps.menu(
                  fit: FlexFit.loose,
                  menuProps: MenuProps(
                    backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                  )),
              validator: (value) {
                if (value == null) {
                  return 'Abyss floor is required';
                }
                return null;
              },
              onChanged: (value) {
                widget.updateSubmitInfo('speedrun_subcategory', value);
                setState(() {
                  _12_1_1Controller.clear();
                  _12_1_2Controller.clear();
                  _12_2_1Controller.clear();
                  _12_2_2Controller.clear();
                  _12_3_1Controller.clear();
                  _12_3_2Controller.clear();
                });
              },
              autoValidateMode: AutovalidateMode.onUserInteraction,
              selectedItem: SPEEDRUN_ABYSS_CHAMBERS[0],
              decoratorProps: DropDownDecoratorProps(
                  baseStyle: const TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                      labelText: 'Abyss Floor',
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

  Widget segmentCheckBox(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Checkbox(
            value: _hasSegment,
            onChanged: (value) {
              setState(() {
                _hasSegment = value!;
              });
            }),
        SizedBox(width: 5.wr),
        Text('Specify segment', style: TextStyle(fontSize: 16.swr)),
        SizedBox(width: 5.wr),
        Tooltip(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
            ),
            richMessage: WidgetSpan(
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    constraints: const BoxConstraints(maxWidth: 300),
                    child: Text(
                      '''If your video contains more chambers than the category you are submitting or there are other Abyss chambers that are not part of the category, you should check box and specify the segments of the chambers belong to the category.

Format: [start time] - [end time] (in seconds) Example: If 12-1-1 portion of the video starts at 1:42 and ends at 2:37. Your input would be 102 - 157.

Make sure to not include other chambers in the duration and the STARTING/ENDING FRAME MUST BE INCLUDED''',
                      style: TextStyle(fontSize: 16.swr, color: Theme.of(context).extension<TextColors>()!.text),
                    ))),
            child: Icon(Icons.info, size: 16.swr, color: Theme.of(context).colorScheme.outline))
      ]),
    );
  }

  Widget segmentField(
      BuildContext context, String label, TextEditingController controller, GlobalKey<FormFieldState> fieldKey) {
    return UniformTextFormField(
      fieldKey: fieldKey, // Add field key for validation
      padding: EdgeInsets.zero,
      // height: 76,
      controller: controller,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (_hasSegment && (value == null || value.isEmpty)) {
          return 'Segment is required';
        }
        return null;
      },
      decoration: InputDecoration(
        filled: true,
        labelText: label,
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
}
