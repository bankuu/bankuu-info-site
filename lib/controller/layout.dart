import 'dart:async';

import 'package:get/get.dart';
import 'package:rive/rive.dart';

class HomeScreenControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeScreenController._internal());
  }
}

class HomeScreenController extends GetxController {
  late Timer? _timer;
  var textOpacity = 0.00.obs;
  late RiveAnimationController welcomeFooter;

  HomeScreenController._internal();

  @override
  void onInit() {
    super.onInit();
    _timer = Timer.periodic(const Duration(milliseconds: 750), (timer) {
      if (textOpacity.value == 0) {
        textOpacity.value = 1;
      } else {
        textOpacity.value = 0;
      }
    });
    welcomeFooter = OneShotAnimation('runner', autoplay: true);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
