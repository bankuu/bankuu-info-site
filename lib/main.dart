import 'package:bankuu_info_site/controller/layout.dart';
import 'package:bankuu_info_site/utility.dart';
import 'package:bankuu_info_site/view/layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:get/get.dart';

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
      getPages: [
        GetPage(
          name: "/",
          page: () => const HomeScreen(),
          binding: HomeScreenControllerBinding(),
        ),
      ],
    ),
  );
}
