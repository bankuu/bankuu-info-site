import 'package:bankuu_info_site/controller/layout.dart';
import 'package:bankuu_info_site/utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

class WelcomePage extends StatelessWidget {
  final HomeScreenController controller;

  const WelcomePage(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Obx(
            () => Opacity(
              opacity: controller.textOpacity.value,
              child: Text(
                "Something is beginning...",
                style: TextStyle(fontSize: 30, color: ColorSet.textEnd.color),
              ),
            ),
          ),
        ),
        RiveAnimation.asset(
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
