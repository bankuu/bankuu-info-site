import 'package:bankuu_info_site/controller/page/welcome.dart';
import 'package:bankuu_info_site/utility.dart';
import 'package:bankuu_info_site/view/page/portfolio.dart';
import 'package:bankuu_info_site/view/page/welcome.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:get/get.dart';

import 'controller/page/portfolio.dart';

void main() {
  setPathUrlStrategy();
  runApp(
    GetCupertinoApp(
      title: "BANKUU - Curriculum Vitae",
      initialRoute: "/",
      theme: CupertinoThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: ColorSet.background.color,
        textTheme: const CupertinoTextThemeData(
          textStyle: TextStyle(fontFamily: "IanCPU"),
        ),
      ),
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 800),
      getPages: [
        GetPage(
          name: "/",
          page: () => WelcomePage(),
          binding: WelcomeControllerBinding(),
        ),
        GetPage(
          name: "/portfolio",
          page: () => PortfolioPage(),
          binding: PortfolioControllerBinding(),
        ),
      ],
    ),
  );
}
