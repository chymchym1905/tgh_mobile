import 'package:flutter/gestures.dart';
import 'package:tgh_mobile/imports.dart';
import 'package:tgh_mobile/screens/submitscreen/formfields/dps.dart';
import 'package:tgh_mobile/screens/submitscreen/formfields/dps_abyss.dart';
import 'package:tgh_mobile/screens/submitscreen/profileinfo.dart';

class SubmitDpsBody extends ConsumerStatefulWidget {
  const SubmitDpsBody({super.key});

  @override
  ConsumerState<SubmitDpsBody> createState() => _SubmitDpsBodyState();
}

class _SubmitDpsBodyState extends ConsumerState<SubmitDpsBody> {
  int _dpsCategoryIndex = 0;
  String _currentDpsCategory = DPS_CATEGORY_ORDER.first;
  bool _agree = false;
  FToast fToast = FToast();

  final TextEditingController _aliasController = TextEditingController();
  final TextEditingController _uidController = TextEditingController();
  final TextEditingController _discordTagController = TextEditingController();

  final TextEditingController _notesController = TextEditingController();

  // Add form key for validation
  final _formKey = GlobalKey<FormState>();

  Map<String, dynamic> submitInformation = {
    'dps_category': DPS_CATEGORY_ORDER.first,
    'food_used': false,
    'stunned': false
  };

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
                    DPS_CATEGORY_ORDER.length,
                    (index) => Padding(
                        padding: EdgeInsets.only(right: 8.wr),
                        child: CategoryTab(
                            name: DPS_CATEGORY_ORDER[index],
                            selected: _dpsCategoryIndex == index,
                            onTap: () => setState(() {
                                  _dpsCategoryIndex = index;
                                  _currentDpsCategory = DPS_CATEGORY_ORDER[index];
                                  submitInformation['dps_category'] = DPS_CATEGORY_ORDER[index];
                                  submitInformation.removeWhere((key, value) => key == 'domain');
                                  submitInformation.removeWhere((key, value) => key == 'event');
                                  submitInformation.removeWhere((key, value) => key == 'enemy');
                                  submitInformation.removeWhere((key, value) => key == 'abyss_version');
                                  submitInformation.removeWhere((key, value) => key == 'abyss_floor');
                                  if (_currentDpsCategory == 'Abyss') {
                                    submitInformation['abyss_floor'] = ABYSS_FLOORS.first;
                                    submitInformation['abyss_version'] = ABYSS_VERSION_HISTORY.last;
                                  }
                                  if (_currentDpsCategory == 'Domain') {
                                    submitInformation['domain'] = DOMAIN.first;
                                  }
                                  if (_currentDpsCategory == 'Event') {
                                    submitInformation['event'] = DPS_EVENTS.first;
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
              if (_currentDpsCategory == 'Overworld')
                DpsFields(updateSubmitInfo: updateSubmitInfo, category: 'Overworld'),
              if (_currentDpsCategory == 'Weekly Boss')
                DpsFields(updateSubmitInfo: updateSubmitInfo, category: 'Weekly Boss'),
              if (_currentDpsCategory == 'World Boss')
                DpsFields(updateSubmitInfo: updateSubmitInfo, category: 'World Boss'),
              if (_currentDpsCategory == 'Reputation Bounty')
                DpsFields(updateSubmitInfo: updateSubmitInfo, category: 'Reputation Bounty'),
              if (_currentDpsCategory == 'Event')
                DpsFields(updateSubmitInfo: updateSubmitInfo, category: 'Event', event: true),
              if (_currentDpsCategory == 'Domain')
                DpsFields(updateSubmitInfo: updateSubmitInfo, category: 'Domain', domain: true),
              if (_currentDpsCategory == 'Abyss') DpsAbyssFields(updateSubmitInfo: updateSubmitInfo),
              // if (_currentDpsCategory == 'Abyss') SpeedrunAbyssFields(updateSubmitInfo: updateSubmitInfo),
              // if (_currentDpsCategory == 'Domain') SpeedrunDomainFields(updateSubmitInfo: updateSubmitInfo),
              // if (_currentDpsCategory == 'World Boss')
              //   SpeedrunBossFields(updateSubmitInfo: updateSubmitInfo, category: 'World Boss'),
              // if (_currentDpsCategory == 'Weekly Boss')
              //   SpeedrunBossFields(updateSubmitInfo: updateSubmitInfo, category: 'Weekly Boss'),
              // if (_currentDpsCategory == 'Event') SpeedrunEventFields(updateSubmitInfo: updateSubmitInfo),
              // if (MediaQuery.of(context).size.width <= 600) ...[
              //   supportsField(context),
              //   const SizedBox(height: 20),
              // ] else ...[
              //   Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              //     Expanded(child: supportsField(context)),
              //     SizedBox(width: 10.wr),
              //   ]),
              // ],
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
              Text('''*Submissions will not show up on our leaderboard until approved by our moderation team''',
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
                              final submitInfo = DpsSubmit.fromJson(Map<String, dynamic>.from(submitInformation));
                              await ref.watch(submitDpsProvider(submitInfo).future);
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

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }
}
