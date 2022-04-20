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
  var textOpacity = 1.00.obs;
  late _SpeedController welcomeFooter;
  var isEntering = false.obs;
  var isToMainMenu = false.obs;

  HomeScreenController._internal();

  @override
  void onInit() {
    super.onInit();
    welcomeFooter = _SpeedController('runner', speedMultiplier: 1);
  }

  onEnter() {
    if (isEntering.isTrue) {
      return;
    }

    isEntering.value = true;

    // Flash Text

    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (timer.tick % 3 == 0) {
        if (textOpacity.value == 0) {
          textOpacity.value = 1;
        } else {
          textOpacity.value = 0;
        }
      }

      if (welcomeFooter.speedMultiplier.value > 0.1 && isToMainMenu.isFalse) {
        welcomeFooter.speedMultiplier.value = welcomeFooter.speedMultiplier.value - (welcomeFooter.speedMultiplier.value / 8);
      } else {
        if (isToMainMenu.isFalse) {
          welcomeFooter.speedMultiplier.value = 0.01;
          isToMainMenu.value = true;
        }

        if (welcomeFooter.speedMultiplier.value < 8) {
          welcomeFooter.speedMultiplier.value = welcomeFooter.speedMultiplier.value + 0.25;
        }
      }
    });

    // Create enter Animation
    // welcomeFooter.changeSpeed(5);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

class _SpeedController extends SimpleAnimation {
  final speedMultiplier = Rx<double>(1);

  _SpeedController(
    String animationName, {
    double mix = 1,
    double speedMultiplier = 1,
  }) : super(animationName, mix: mix) {
    this.speedMultiplier.value = speedMultiplier;
  }

  @override
  void apply(RuntimeArtboard artboard, double elapsedSeconds) {
    if (instance == null || !instance!.keepGoing) {
      isActive = false;
    }
    instance!
      ..animation.apply(instance!.time, coreContext: artboard, mix: mix)
      ..advance(elapsedSeconds * speedMultiplier.value);
  }
}
