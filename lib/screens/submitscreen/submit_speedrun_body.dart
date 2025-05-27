import 'package:dropdown_search/dropdown_search.dart';
import 'package:dropdown_search/src/widgets/custom_scroll_view.dart';
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:tgh_mobile/imports.dart';
import 'package:tgh_mobile/screens/submitscreen/formfields/speedrun_abyss.dart';
import 'package:tgh_mobile/screens/submitscreen/formfields/speedrun_boss.dart';
import 'package:tgh_mobile/screens/submitscreen/formfields/speedrun_domain.dart';
import 'package:tgh_mobile/screens/submitscreen/formfields/speedrun_event.dart';
import 'package:tgh_mobile/screens/submitscreen/profileinfo.dart';

class SubmitSpeedrunBody extends ConsumerStatefulWidget {
  const SubmitSpeedrunBody({super.key});

  @override
  ConsumerState<SubmitSpeedrunBody> createState() => _SubmitSpeedrunBodyState();
}

class _SubmitSpeedrunBodyState extends ConsumerState<SubmitSpeedrunBody> {
  int _speedrunCategoryIndex = 0;
  String _currentSpeedrunCategory = SPEEDRUN_CATEGORY_ORDER.first;
  bool _agree = false;
  FToast fToast = FToast();

  final TextEditingController _aliasController = TextEditingController();
  final TextEditingController _uidController = TextEditingController();
  final TextEditingController _discordTagController = TextEditingController();

  final SingleSelectController<String> _worldBossController = SingleSelectController<String>(WORLD_BOSSES.first);
  final SingleSelectController<String> _weeklyBossController = SingleSelectController<String>(WEEKLY_BOSSES.first);
  final SingleSelectController<String> _eventController = SingleSelectController<String>(SPEEDRUN_EVENTS.first);
  final _team1Key = GlobalKey<DropdownSearchState<String>>();
  final TextEditingController _team1Controller = TextEditingController();
  final TextEditingController _team2Controller = TextEditingController();
  final _team2Key = GlobalKey<DropdownSearchState<String>>();

  final TextEditingController _notesController = TextEditingController();

  // Add form key for validation
  final _formKey = GlobalKey<FormState>();

  Map<String, dynamic> submitInformation = {'speedrun_category': SPEEDRUN_CATEGORY_ORDER.first};

  @override
  void initState() {
    fToast.init(context);
    _notesController.addListener(() {
      updateSubmitInfo('notes', _notesController.text);
    });
    super.initState();
  }

  void updateSubmitInfo(String key, dynamic value) {
    setState(() {
      submitInformation[key] = value;
      if (value == null || value == '' || value == []) {
        submitInformation.remove(key);
      }
      // if (['12_1_1', '12_1_2', '12_2_1', '12_2_2', '12_3_1', '12_3_2'].contains(key)) {

      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authNotifierProvider);
    return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer,
          border: Border.all(color: Theme.of(context).colorScheme.outline),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.wr, vertical: 16.wr),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Wrap(
                direction: Axis.horizontal,
                runSpacing: 8,
                children: List<Widget>.generate(
                    SPEEDRUN_CATEGORY_ORDER.length,
                    (index) => Padding(
                        padding: EdgeInsets.only(right: 8.wr),
                        child: CategoryTab(
                            name: SPEEDRUN_CATEGORY_ORDER[index],
                            selected: _speedrunCategoryIndex == index,
                            onTap: () => setState(() {
                                  _speedrunCategoryIndex = index;
                                  _currentSpeedrunCategory = SPEEDRUN_CATEGORY_ORDER[index];
                                  submitInformation['speedrun_category'] = SPEEDRUN_CATEGORY_ORDER[index];
                                  submitInformation.removeWhere((key, value) => key == 'speedrun_subcategory');
                                  submitInformation.removeWhere((key, value) => key == 'abyss_version');
                                  submitInformation.removeWhere((key, value) => key == 'video_segment');
                                  submitInformation.removeWhere((key, value) => key == '12_1_1');
                                  submitInformation.removeWhere((key, value) => key == '12_1_2');
                                  submitInformation.removeWhere((key, value) => key == '12_2_1');
                                  submitInformation.removeWhere((key, value) => key == '12_2_2');
                                  submitInformation.removeWhere((key, value) => key == '12_3_1');
                                  submitInformation.removeWhere((key, value) => key == '12_3_2');
                                  if (_currentSpeedrunCategory == 'Abyss') {
                                    submitInformation['abyss_version'] = ABYSS_VERSION_HISTORY.last;
                                    submitInformation['speedrun_subcategory'] = SPEEDRUN_ABYSS_CHAMBERS.first;
                                  }
                                  if (_currentSpeedrunCategory == 'Domain') {
                                    submitInformation['speedrun_subcategory'] = DOMAIN.first;
                                  }
                                  if (_currentSpeedrunCategory == 'Event') {
                                    submitInformation['abyss_version'] = SUBMITABLE_EVENTS.first;
                                  }
                                  if (_currentSpeedrunCategory == 'World Boss') {
                                    submitInformation['speedrun_subcategory'] = WORLD_BOSSES.first;
                                  }
                                  if (_currentSpeedrunCategory == 'Weekly Boss') {
                                    submitInformation['speedrun_subcategory'] = WEEKLY_BOSSES.first;
                                  }
                                })))),
              ),
              const SizedBox(height: 20),
              if (MediaQuery.of(context).size.width < kMaxWidthMobile)
                const ProfileInformation()
              else ...[
                auth.when(
                    data: (data) {
                      switch (data) {
                        case AuthStateAuthenticated(:final user):
                          if (user.competitor != null) {
                            _aliasController.text = user.competitor!.alias;
                            _uidController.text = user.competitor!.uid.toString();
                            _discordTagController.text = user.competitor!.discordtag.toString();
                            submitInformation['alias'] = user.competitor!.alias;
                            submitInformation['uid'] = user.competitor!.uid;
                            submitInformation['discord_tag'] = user.competitor!.discordtag;
                          }
                          return userProfileInfoRow(context);
                        default:
                          return userProfileInfoRow(context);
                      }
                    },
                    error: (error, stackTrace) => userProfileInfoRow(context),
                    loading: () => _shimmerRow()),
              ],
              const SizedBox(height: 20),
              Align(
                  alignment: Alignment.center,
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: 'If you need to update your profile information, go to your ',
                        style: TextStyle(fontSize: 16.swr, color: Theme.of(context).extension<TextColors>()!.text)),
                    TextSpan(
                        text: 'profile',
                        style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 16.swr),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.push(Routes.profile);
                          })
                  ]))),
              const SizedBox(height: 20),
              if (_currentSpeedrunCategory == 'Abyss') SpeedrunAbyssFields(updateSubmitInfo: updateSubmitInfo),
              if (_currentSpeedrunCategory == 'Domain') SpeedrunDomainFields(updateSubmitInfo: updateSubmitInfo),
              if (_currentSpeedrunCategory == 'World Boss')
                SpeedrunBossFields(updateSubmitInfo: updateSubmitInfo, category: 'World Boss'),
              if (_currentSpeedrunCategory == 'Weekly Boss')
                SpeedrunBossFields(updateSubmitInfo: updateSubmitInfo, category: 'Weekly Boss'),
              if (_currentSpeedrunCategory == 'Event') SpeedrunEventFields(updateSubmitInfo: updateSubmitInfo),
              if (MediaQuery.of(context).size.width <= 600) ...[
                team1Field(context),
                const SizedBox(height: 20),
                team2Field(context),
              ] else ...[
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Expanded(child: team1Field(context)),
                  SizedBox(width: 10.wr),
                  Expanded(child: team2Field(context)),
                ]),
              ],
              const SizedBox(height: 20),
              UniformTextFormField(
                padding: EdgeInsets.zero,
                controller: _notesController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    filled: true,
                    labelText: 'Notes',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).colorScheme.outline, width: 2)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).colorScheme.outline, width: 2))),
              ),
              const SizedBox(height: 20),
              Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Checkbox(
                        value: _agree,
                        onChanged: (value) {
                          setState(() {
                            _agree = value!;
                          });
                        }),
                    SizedBox(width: 5.wr),
                    Expanded(
                      child: Text(
                          'I acknowledge that if an UID is provided, at the point of submission a record will be generated of characters used on the run that are also on my in-game character card. This record will be publically viewable on my run submission. For most accurate data, please ensure that all characters used on the run are being displayed on your in-game profile.',
                          style: TextStyle(fontSize: 12.swr)),
                    ),
                  ])),
              const SizedBox(height: 20),
              Text('''*Runs submitted will not show up on our leaderboard until approved by our moderation team.
*Abyss submissions must show the key pressing action at the start of each chamber''',
                  style: TextStyle(fontSize: 12.swr)),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Material(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      child: InkWell(
                          onTap: () async {
                            // Validate the form
                            if (_formKey.currentState?.validate() ?? false) {
                              if (!_agree) {
                                // Show error if user hasn't agreed to terms
                                fToast.showToast(
                                    child: toast(context, 'Please agree to the terms before submitting'),
                                    gravity: ToastGravity.BOTTOM,
                                    toastDuration: const Duration(seconds: 5));
                                return;
                              }

                              // Proceed with submission
                              print('Form is valid, submitting: $submitInformation');
                              if (_currentSpeedrunCategory == 'Abyss') {
                                final submitInitial = Map<String, dynamic>.from(submitInformation);
                                final submitInfoCopy = Map<String, dynamic>.from(submitInformation)
                                  ..removeWhere((key, value) => [
                                        '12_1_1',
                                        '12_1_2',
                                        '12_2_1',
                                        '12_2_2',
                                        '12_3_1',
                                        '12_3_2',
                                        'video_segment'
                                      ].contains(key));
                                submitInfoCopy['video_segment'] = determineSegment(submitInformation);
                                setState(() {
                                  submitInformation = submitInitial;
                                  submitInformation['video_segment'] = submitInfoCopy['video_segment'];
                                });
                              }
                              await ref
                                  .watch(submitSpeedrunProvider(SpeedrunSubmit.fromJson(submitInformation)).future);
                              // Submit with submitInfoCopy
                            } else {
                              // Show error if form is invalid
                              fToast.showToast(
                                  child: toast(context, 'Please fix the errors in the form'),
                                  gravity: ToastGravity.BOTTOM,
                                  toastDuration: const Duration(seconds: 5));
                            }
                          },
                          borderRadius: BorderRadius.circular(5),
                          splashColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
                          child: Ink(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primaryContainer,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                                child: Center(
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(
                                        fontSize: 16, color: Theme.of(context).colorScheme.onPrimaryContainer),
                                  ),
                                ),
                              ))),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(submitInformation.toString()),
            ]),
          ),
        ));
  }

  List<String> determineSegment(Map<String, dynamic> submitInfo) {
    final List<String> segment = [];
    if (submitInfo['12_1_1'] != null && submitInfo['12_1_1'] != '') {
      segment.add(submitInfo['12_1_1'] as String);
    }
    if (submitInfo['12_1_2'] != null && submitInfo['12_1_2'] != '') {
      segment.add(submitInfo['12_1_2'] as String);
    }
    if (submitInfo['12_2_1'] != null && submitInfo['12_2_1'] != '') {
      segment.add(submitInfo['12_2_1'] as String);
    }
    if (submitInfo['12_2_2'] != null && submitInfo['12_2_2'] != '') {
      segment.add(submitInfo['12_2_2'] as String);
    }
    if (submitInfo['12_3_1'] != null && submitInfo['12_3_1'] != '') {
      segment.add(submitInfo['12_3_1'] as String);
    }
    if (submitInfo['12_3_2'] != null && submitInfo['12_3_2'] != '') {
      segment.add(submitInfo['12_3_2'] as String);
    }
    return segment;
  }

  Widget userProfileInfoRow(BuildContext context) {
    return Row(children: [
      Expanded(
          child: UniformTextFormField(
        height: 56,
        padding: EdgeInsets.zero,
        controller: _aliasController,
        keyboardType: TextInputType.text,
        enabled: false,
        expands: true,
        decoration: InputDecoration(
          filled: true,
          labelText: 'Alias',
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.outline, width: 2)),
        ),
      )),
      SizedBox(width: 10.wr),
      Expanded(
          child: UniformTextFormField(
        height: 56,
        padding: EdgeInsets.zero,
        controller: _uidController,
        keyboardType: TextInputType.text,
        enabled: false,
        expands: true,
        decoration: InputDecoration(
          filled: true,
          labelText: 'UID',
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.outline, width: 2)),
        ),
      )),
      SizedBox(width: 10.wr),
      Expanded(
          child: UniformTextFormField(
        height: 56,
        padding: EdgeInsets.zero,
        controller: _discordTagController,
        keyboardType: TextInputType.text,
        enabled: false,
        expands: true,
        decoration: InputDecoration(
          filled: true,
          labelText: 'Discord Username',
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.outline, width: 2)),
        ),
      )),
    ]);
  }

  Widget _shimmerRow() {
    return Row(
      children: [
        Expanded(flex: 1, child: ShimmerComponent.regtangular(height: 56)),
        SizedBox(width: 10.wr),
        Expanded(flex: 1, child: ShimmerComponent.regtangular(height: 56)),
        SizedBox(width: 10.wr),
        Expanded(flex: 1, child: ShimmerComponent.regtangular(height: 56)),
      ],
    );
  }

  Widget team1Field(BuildContext context) {
    return SizedBox(
        // height: 76,
        child: ref.watch(gameAssetProvider).when(
              data: (data) {
                switch (data) {
                  case GameAssetStateLoaded(:final characters):
                    return DropdownSearch<String>.multiSelection(
                      key: _team1Key,
                      items: (filter, loadProps) => characters?.map((e) => e.name).toList() ?? [],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Team 1 is required';
                        }
                        return null;
                      },
                      onChanged: (value) => updateSubmitInfo('team1', value),
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      suffixProps: const DropdownSuffixProps(clearButtonProps: ClearButtonProps(isVisible: true)),
                      decoratorProps: DropDownDecoratorProps(
                          decoration: InputDecoration(
                        filled: true,
                        labelText: 'Team 1',
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
                            controller: _team1Controller,
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
                                _team1Key.currentState?.changeSelectedItems(<String>[item]);
                                _team1Controller.clear();
                              } else {
                                _team1Key.currentState?.removeItem(item);
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
                              _team1Key.currentState?.removeItem(item);
                            } else {
                              _team1Key.currentState?.changeSelectedItems(<String>[item]);
                              _team1Controller.clear();
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
                          _team1Key.currentState?.changeSelectedItems(<String>[...selectedItems]);
                          _team1Controller.clear();
                        },
                        onItemRemoved: (selectedItems, removedItem) {
                          _team1Key.currentState?.removeItem(removedItem);
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
                                            _team1Key.currentState?.removeItem(e);
                                          }));
                                }).toList()));
                      },
                    );
                  default:
                    return const SizedBox.shrink();
                }
              },
              loading: () => Center(child: SizedBox(height: 56, child: ShimmerComponent.regtangular(height: 56))),
              error: (error, stackTrace) =>
                  Center(child: SizedBox(height: 56, child: ShimmerComponent.regtangular(height: 56))),
            ));
  }

  Widget team2Field(BuildContext context) {
    return SizedBox(
        // height: 76,
        child: ref.watch(gameAssetProvider).when(
              data: (data) {
                switch (data) {
                  case GameAssetStateLoaded(:final characters):
                    return DropdownSearch<String>.multiSelection(
                      key: _team2Key,
                      items: (filter, loadProps) => characters?.map((e) => e.name).toList() ?? [],
                      onChanged: (value) => updateSubmitInfo('team2', value),
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      suffixProps: const DropdownSuffixProps(clearButtonProps: ClearButtonProps(isVisible: true)),
                      decoratorProps: DropDownDecoratorProps(
                          decoration: InputDecoration(
                        filled: true,
                        labelText: 'Team 2',
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
                            controller: _team2Controller,
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
                                _team2Key.currentState?.changeSelectedItems(<String>[item]);
                                _team2Controller.clear();
                              } else {
                                _team2Key.currentState?.removeItem(item);
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
                              _team2Key.currentState?.removeItem(item);
                            } else {
                              _team2Key.currentState?.changeSelectedItems(<String>[item]);
                              _team2Controller.clear();
                            }
                          },
                        ),
                        menuProps: MenuProps(
                            backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                            elevation: 1,
                            shadowColor: Theme.of(context).colorScheme.shadow,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.wr),
                                side: BorderSide(color: Theme.of(context).colorScheme.outline, width: 1))),
                        fit: FlexFit.loose,
                        onItemAdded: (selectedItems, addedItem) {
                          _team2Key.currentState?.changeSelectedItems(<String>[...selectedItems]);
                          _team2Controller.clear();
                        },
                        onItemRemoved: (selectedItems, removedItem) {
                          _team2Key.currentState?.removeItem(removedItem);
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
                                            _team2Key.currentState?.removeItem(e);
                                          }));
                                }).toList()));
                      },
                    );
                  default:
                    return const SizedBox.shrink();
                }
              },
              loading: () => Center(child: SizedBox(height: 56, child: ShimmerComponent.regtangular(height: 56))),
              error: (error, stackTrace) =>
                  Center(child: SizedBox(height: 56, child: ShimmerComponent.regtangular(height: 56))),
            ));
  }

  @override
  void dispose() {
    _aliasController.dispose();
    _uidController.dispose();
    _discordTagController.dispose();
    _worldBossController.dispose();
    _weeklyBossController.dispose();
    _eventController.dispose();
    _notesController.dispose();
    super.dispose();
  }
}
