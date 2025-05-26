import 'package:tgh_mobile/imports.dart';
import 'package:dropdown_search/dropdown_search.dart';

class SpeedrunDomainFields extends ConsumerStatefulWidget {
  const SpeedrunDomainFields({super.key, required this.updateSubmitInfo});
  final void Function(String key, dynamic value) updateSubmitInfo;

  @override
  ConsumerState<SpeedrunDomainFields> createState() => _SpeedrunDomainState();
}

class _SpeedrunDomainState extends ConsumerState<SpeedrunDomainFields> {
  bool _initRegion = false;
  final TextEditingController _gameVersionController = TextEditingController();
  final TextEditingController _videoLinkController = TextEditingController();
  final _domainKey = GlobalKey<DropdownSearchState<String>>();
  final _regionKey = GlobalKey<DropdownSearchState<String>>();

  // Add form field keys for validation
  final _gameVersionFieldKey = GlobalKey<FormFieldState>();
  final _videoLinkFieldKey = GlobalKey<FormFieldState>();
  double _dragAccumulator = 0.0;

  @override
  void initState() {
    _gameVersionController.addListener(() {
      widget.updateSubmitInfo('game_version', _gameVersionController.text);
    });
    _videoLinkController.addListener(() {
      widget.updateSubmitInfo('video_link', _videoLinkController.text);
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
          Expanded(flex: 1, child: domainField(context)),
        ]),
      ] else ...[
        regionField(context),
        const SizedBox(height: 20),
        gameVersionField(context),
        const SizedBox(height: 20),
        domainField(context)
      ],
      const SizedBox(height: 20),
      videoLinkField(context),
      const SizedBox(height: 20),
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
                widget.updateSubmitInfo('speedrun_subcategory', value);
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
}
