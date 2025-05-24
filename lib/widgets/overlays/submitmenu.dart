import 'package:tgh_mobile/imports.dart';

class SubmitMenu extends StatelessWidget {
  const SubmitMenu({super.key, required this.customPopupMenuController});
  final CustomPopupMenuController customPopupMenuController;

  @override
  Widget build(BuildContext context) {
    final currentRoute = GoRouter.of(context).routeInformationProvider.value.uri.path;

    return Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHigh, borderRadius: BorderRadius.circular(5.wr)),
        child: Consumer(
          builder: (context, ref, child) {
            return Material(
                color: Colors.transparent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.wr)),
                child: IntrinsicWidth(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                      InkWell(
                          onTap: () {
                            if (currentRoute == Routes.submitSpeedrun ||
                                currentRoute == Routes.submitDps ||
                                currentRoute == Routes.submitRestrictedDps) {
                              context.pushReplacement(Routes.submitSpeedrun);
                            } else {
                              context.push(Routes.submitSpeedrun);
                            }
                            customPopupMenuController.hideMenu();
                          },
                          highlightColor: Theme.of(context).colorScheme.surfaceContainerHigh,
                          splashColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5.wr),
                            topRight: Radius.circular(5.wr),
                          ),
                          child: Padding(
                              padding: EdgeInsets.only(right: 10.wr, left: 10.wr, top: 10.wr, bottom: 5.wr),
                              child: Row(children: [
                                // Icon(Icons.timer, size: 24.wr),
                                // SizedBox(width: 5.wr),
                                Text('Submit Speedrun', style: TextStyle(fontSize: 12.wr, fontWeight: FontWeight.bold))
                              ]))),
                      InkWell(
                          onTap: () {
                            if (currentRoute == Routes.submitSpeedrun ||
                                currentRoute == Routes.submitDps ||
                                currentRoute == Routes.submitRestrictedDps) {
                              context.pushReplacement(Routes.submitDps);
                            } else {
                              context.push(Routes.submitDps);
                            }
                            customPopupMenuController.hideMenu();
                          },
                          highlightColor: Theme.of(context).colorScheme.surfaceContainerHigh,
                          splashColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                          borderRadius:
                              BorderRadius.only(bottomLeft: Radius.circular(5.wr), bottomRight: Radius.circular(5.wr)),
                          child: Ink(
                              padding: EdgeInsets.symmetric(vertical: 5.wr, horizontal: 10.wr),
                              child: Row(children: [
                                // SvgPicture.asset('assets/icons/whale.svg', width: 24.wr, height: 24.wr),
                                // SizedBox(width: 5.wr),
                                Text('Submit DPS', style: TextStyle(fontSize: 12.wr, fontWeight: FontWeight.bold))
                              ]))),
                      InkWell(
                          onTap: () {
                            if (currentRoute == Routes.submitSpeedrun ||
                                currentRoute == Routes.submitDps ||
                                currentRoute == Routes.submitRestrictedDps) {
                              context.pushReplacement(Routes.submitRestrictedDps);
                            } else {
                              context.push(Routes.submitRestrictedDps);
                            }
                            customPopupMenuController.hideMenu();
                          },
                          highlightColor: Theme.of(context).colorScheme.surfaceContainerHigh,
                          splashColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                          borderRadius:
                              BorderRadius.only(bottomLeft: Radius.circular(5.wr), bottomRight: Radius.circular(5.wr)),
                          child: Padding(
                              padding: EdgeInsets.only(right: 10.wr, left: 10.wr, top: 5.wr, bottom: 10.wr),
                              child: Row(children: [
                                // SvgPicture.asset('assets/icons/fish.svg', width: 24.wr, height: 24.wr),
                                // SizedBox(width: 5.wr),
                                Text('Submit Restricted DPS',
                                    style: TextStyle(fontSize: 12.wr, fontWeight: FontWeight.bold))
                              ])))
                    ])));
          },
        ));
  }
}
