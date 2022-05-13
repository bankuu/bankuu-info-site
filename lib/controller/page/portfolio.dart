import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import "dart:html" as html;

enum Menu {
  about,
  skills,
  experience,
  // anythingElse,
  contact
}

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

  final _pageController = PageController().obs;

  PageController get pageController => _pageController.value;

  final _isWKeyDown = false.obs;
  final _isAKeyDown = false.obs;
  final _isSKeyDown = false.obs;
  final _isDKeyDown = false.obs;

  bool get isWKeyDown => _isWKeyDown.value;
  bool get isAKeyDown => _isAKeyDown.value;
  bool get isSKeyDown => _isSKeyDown.value;
  bool get isDKeyDown => _isDKeyDown.value;

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

  void onKey(RawKeyEvent value) {
    // if (value is RawKeyUpEvent) {
    switch (value.logicalKey.keyLabel) {
      case "Arrow Down":
      case "S":
        if (value is RawKeyUpEvent) {
          _selectDownMenu();
          _isSKeyDown.value = false;
        } else if (value is RawKeyDownEvent) {
          _isSKeyDown.value = true;
        }
        break;
      case "Arrow Left":
      case "A":
        if (value is RawKeyUpEvent) {
          _selectLeftMenu();
          _isAKeyDown.value = false;
        } else if (value is RawKeyDownEvent) {
          _isAKeyDown.value = true;
        }
        break;
      case "Arrow Up":
      case "W":
        if (value is RawKeyUpEvent) {
          _selectUpMenu();
          _isWKeyDown.value = false;
        } else if (value is RawKeyDownEvent) {
          _isWKeyDown.value = true;
        }
        break;
      case "Arrow Right":
      case "D":
        if (value is RawKeyUpEvent) {
          _selectRightMenu();
          _isDKeyDown.value = false;
        } else if (value is RawKeyDownEvent) {
          _isDKeyDown.value = true;
        }
        break;
    }
    // }
  }

  void _selectUpMenu() {
    if (_selectedMenu.value != Menu.values.first) {
      var indexMenu = Menu.values.indexWhere((element) => element == _selectedMenu.value) - 1;
      _selectedMenu.value = Menu.values[indexMenu];
    }
  }

  void _selectDownMenu() {
    if (_selectedMenu.value != Menu.values.last) {
      var indexMenu = Menu.values.indexWhere((element) => element == _selectedMenu.value) + 1;
      _selectedMenu.value = Menu.values[indexMenu];
    }
  }

  void _selectRightMenu() {
    if (_selectedMenu.value == Menu.experience && (_pageController.value.page ?? 0) >= 0.0) {
      _pageController.value.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    }
  }

  void _selectLeftMenu() {
    if (_selectedMenu.value == Menu.experience) {
      _pageController.value.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    }
  }
}
