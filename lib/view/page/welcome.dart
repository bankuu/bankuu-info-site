import 'package:bankuu_info_site/controller/layout.dart';
import 'package:bankuu_info_site/utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart' as rive;

class WelcomePage extends StatelessWidget {
  final HomeScreenController controller;

  const WelcomePage(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) => LinearGradient(colors: [
                  ColorSet.textBegin.color,
                  ColorSet.textEnd.color,
                ]).createShader(
                  Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                ),
                child: Column(
                  children: const [
                    Text(
                      "200 in 1 : Curriculum Vitae",
                      style: TextStyle(fontSize: 50),
                    ),
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text("BANKUU", style: TextStyle(fontSize: 400, height: 0.75)),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Obx(
                  () => Opacity(
                    opacity: controller.textOpacity.value,
                    child: Text(
                      "Any key or click to enter... ",
                      style: TextStyle(fontSize: 30, color: ColorSet.textEnd.color),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        rive.RiveAnimation.asset(
          'asset/rive/welcome-footer.riv',
          fit: BoxFit.fill,
          controllers: [
            controller.welcomeFooter,
          ],
        )
      ],
    );
  }
}
