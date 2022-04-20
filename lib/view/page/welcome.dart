import 'package:bankuu_info_site/controller/layout.dart';
import 'package:bankuu_info_site/utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart' as rive;

class WelcomePage extends StatelessWidget {
  final FocusNode _focusNode = FocusNode();

  final HomeScreenController controller;

  WelcomePage(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      autofocus: true,
      onKey: (value) {
        controller.onEnter();
      },
      focusNode: _focusNode,
      child: GestureDetector(
        onTap: () {
          controller.onEnter();
        },
        behavior: HitTestBehavior.opaque,
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 80),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (bounds) => LinearGradient(colors: [
                      ColorSet.textBegin.color,
                      ColorSet.textEnd.color,
                    ]).createShader(
                      Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                    ),
                    child: TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0, end: 1),
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.easeOutCubic,
                      builder: (BuildContext context, double size, Widget? child) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "Curriculum Vitae",
                                style: TextStyle(fontSize: size * 40, height: 0.75),
                              ),
                            ),
                            const SizedBox(height: 10),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text("BANKUU", style: TextStyle(fontSize: size * 450, height: 0.6)),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height / 2.25),
                      Align(
                        alignment: Alignment.center,
                        child: Obx(
                          () => Opacity(
                            opacity: controller.textOpacity.value,
                            child: Text(
                              controller.isEntering.isTrue ? "Please wait..." :"Any key or click to enter",
                              style: TextStyle(fontSize: 30, color: ColorSet.textEnd.color),
                            ),
                          ),
                        ),
                      ),
                    ],
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
        ),
      ),
    );
  }
}
