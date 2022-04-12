import 'package:bankuu_info_site/controller/layout.dart';
import 'package:bankuu_info_site/utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'page/welcome.dart';

class HomeScreen extends GetView<HomeScreenController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Stack(children: [
        WelcomePage(controller),
        _buildButtonBar(),
      ]),
    );
  }

  Widget _buildButtonBar() {
    final String url = Uri(scheme: 'mailto', path: 'ban.kuu@yahoo.com', query: 'subject=Contact to  バンクー').toString();
    return Container(
      alignment: Alignment.bottomCenter,
      child: ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (bounds) => LinearGradient(colors: [
          ColorSet.textBegin.color,
          ColorSet.textEnd.color,
        ]).createShader(
          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
        ),
        child: Text.rich(
          TextSpan(children: [
            const TextSpan(text: "Create with L#v : bankuu (", style: TextStyle(fontSize: 20)),
            TextSpan(
              text: "ban.kuu@yahoo.com",
              mouseCursor: SystemMouseCursors.click,
              style: const TextStyle(fontSize: 20),
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  if (await canLaunch(url)) {
                    await launch(url);
                  }
                },
            ),
            const TextSpan(text: ")", style: TextStyle(fontSize: 20)),
          ]),
        ),
      ),
    );
  }
}

