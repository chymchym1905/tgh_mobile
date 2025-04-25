import 'package:tgh_mobile/imports.dart';

class BiliVideoScreen extends StatelessWidget {
  const BiliVideoScreen({super.key, required this.metadata});
  final VideoMetadata metadata;

  @override
  Widget build(BuildContext context) {
    final html = '''<iframe 
        src="//player.bilibili.com/player.html?isOutside=true&bvid=${metadata.id}" 
        scrolling="no" border="0" frameborder="no" framespacing="0" allowfullscreen="false">
        </iframe>''';
    return Scaffold(body: LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > kMaxWidthMobile) {
        return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(flex: 3, child: Column(children: [HtmlWidget(html)])),
          Expanded(flex: 2, child: Column(children: [Container()]))
        ]);
      } else {
        return ListView(children: [
          HtmlWidget(html),
          16.verticalSpace,
          InkWellTextButton(onTap: () => context.pop(), text: 'Back')
        ]);
      }
    }));
  }
}
