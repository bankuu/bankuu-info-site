import 'package:bankuu_info_site/controller/layout.dart';
import 'package:bankuu_info_site/utility.dart';
import 'package:bankuu_info_site/view/layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    GetCupertinoApp(
      title: "Bankuu Info",
      initialRoute: "/",
      theme: CupertinoThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: ColorSet.background.color,
        // barBackgroundColor: ColorSet.background.color,
        textTheme: const CupertinoTextThemeData(
          // navLargeTitleTextStyle: TextStyle(fontSize: 42,fontFamily: ),
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
