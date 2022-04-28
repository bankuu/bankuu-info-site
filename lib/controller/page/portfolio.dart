import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "dart:html" as html;

enum Menu { about, skills, experience,
  // anythingElse,
  contact }

extension MenuExtension on Menu {
  String get name {
    switch (this) {
      case Menu.about:
        return "About";
      case Menu.skills:
        return "Skill";
      case Menu.experience:
        return "Experience";
      // case Menu.anythingElse:
      //   return "Anything-Else";
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
      // case Menu.anythingElse:
      //   return Colors.pink;
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

  @override
  onReady() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (selectedMenu == null) {
        if (Get.parameters.containsKey("menu")) {
          var menu = Menu.values.singleWhere((element) => element.name.toLowerCase() == Get.parameters["menu"]?.toLowerCase(), orElse: () => Menu.about);
          selectMenu(menu);
        } else {
          selectMenu(Menu.about);
        }
      }
    });
  }

  selectMenu(Menu menu) {
    _selectedMenu.value = menu;
    html.window.history.pushState(null, 'portfolio', '/portfolio?menu=${menu.name.toLowerCase()}');
  }
}
