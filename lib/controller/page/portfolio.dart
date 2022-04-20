import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum Menu { about, skills, experience, anythingElse, contact }

extension MenuExtension on Menu {
  String get name {
    switch (this) {
      case Menu.about:
        return "About";
      case Menu.skills:
        return "Skill";
      case Menu.experience:
        return "Experience";
      case Menu.anythingElse:
        return "Anything Else";
      case Menu.contact:
        return "Contact";
    }
  }

  Color get color {
    switch (this) {
      case Menu.about:
        return Colors.red;
      case Menu.skills:
        return Colors.green;
      case Menu.experience:
        return Colors.blue;
      case Menu.anythingElse:
        return Colors.pink;
      case Menu.contact:
        return Colors.orange;
    }
  }
}

class PortfolioControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(PortfolioController._internal());
  }
}

class PortfolioController extends GetxController {
  final _selectedMenu = Rx<Menu?>(null);

  Menu? get selectedMenu => _selectedMenu.value;

  PortfolioController._internal();


  selectMenu(Menu menu) {
    _selectedMenu.value = menu;
  }
}
