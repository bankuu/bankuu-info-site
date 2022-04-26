import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:bankuu_info_site/controller/page/portfolio.dart';
import 'package:bankuu_info_site/utility.dart';
import 'package:bankuu_info_site/view/share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PortfolioPage extends GetView<PortfolioController> {
  const PortfolioPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Stack(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 15),
              child: ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) => LinearGradient(colors: [
                  ColorSet.textBegin.color,
                  ColorSet.textEnd.color,
                ]).createShader(
                  Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                ),
                child: const FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text("BANKUU", style: TextStyle(fontSize: 100, height: 0.6)),
                ),
              ),
            ),
            Expanded(child: _buildDesktopLayout(context)),
          ],
        ),
        ShareView.buildButtonBar(context),
      ]),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    var _menuItemHeight = 50.0;
    var _menuTotalHeight = 500;
    var _menuSelectedItemHeight = _menuTotalHeight - (_menuItemHeight * Menu.values.length) - 25;

    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
      builder: (context, double tween, widget) {
        return Opacity(
          opacity: tween,
          child: Row(
            children: [
              SizedBox(
                width: 400 * tween,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: Menu.values.map((element) {
                        return Obx(() {
                          var isSelected = controller.selectedMenu == element;
                          return TweenAnimationBuilder(
                              tween: Tween<double>(begin: 0, end: 1),
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOutCubic,
                              builder: (BuildContext context, double size, Widget? child) {
                                return AnimatedContainer(
                                  height: isSelected ? _menuSelectedItemHeight : _menuItemHeight,
                                  curve: Curves.easeInOut,
                                  duration: const Duration(milliseconds: 350),
                                  child: Center(
                                    child: MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTapDown: (_) {
                                          controller.selectMenu(element);
                                        },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.baseline,
                                          textBaseline: TextBaseline.ideographic,
                                          children: [
                                            AnimatedSlide(
                                              duration: const Duration(milliseconds: 200),
                                              offset: Offset(isSelected ? 0 : -10, 0),
                                              child: Icon(Icons.arrow_forward_ios_sharp, color: isSelected ? element.color : Colors.white70, size: 30),
                                            ),
                                            Text(
                                              element.name,
                                              style: TextStyle(color: isSelected ? element.color : Colors.white70, fontSize: 75, height: 0.5),
                                            ),
                                            AnimatedSlide(
                                              duration: const Duration(milliseconds: 200),
                                              offset: Offset(isSelected ? 0 : 10, 0),
                                              child: Icon(Icons.arrow_back_ios_sharp, color: isSelected ? element.color : Colors.white70, size: 30),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              });
                        });
                      }).toList(),
                    ),
                  ],
                ),
              ),
              Obx(
                () => Expanded(
                  child: Container(
                    color: ColorSet.background.color,
                    child: Container(
                      // duration: const Duration(milliseconds: 500),
                      margin: EdgeInsets.all(30 * (2 - tween)),
                      decoration: BoxDecoration(
                        border: Border.all(color: controller.selectedMenu?.color ?? ColorSet.background.color, width: 3),
                        color: controller.selectedMenu?.color.withAlpha(10) ?? Colors.transparent,
                      ),
                      child: _buildMenuPage(context),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildMenuPage(BuildContext context) {
    switch (controller.selectedMenu) {
      case Menu.about:
        return _buildAboutPage(context);
      case Menu.skills:
        return _buildSkillPage();
      case Menu.experience:
      case Menu.anythingElse:
      case Menu.contact:
      default:
        return Container();
    }
  }

  Widget _buildAboutPage(BuildContext context) {
    var textStyle = const TextStyle(color: Colors.white, fontFamily: 'RobotoMono');
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("バンクー", style: textStyle.copyWith(fontSize: 38)),
                  Text("BANKUU", style: textStyle.copyWith(fontSize: 30)),
                  const SizedBox(height: 30),
                  Text("🏷  Nutchaitat Tantanasuwan", style: textStyle.copyWith(fontSize: 18)),
                  const SizedBox(height: 5),
                  Text("💼  Fullstack Developer", style: textStyle.copyWith(fontSize: 18)),
                  const SizedBox(height: 5),
                  Text("🏙  Bangkok, Thailand", style: textStyle.copyWith(fontSize: 18)),
                  const SizedBox(height: 5),
                  Text("🎂  10 April 1990", style: textStyle.copyWith(fontSize: 18)),
                  const SizedBox(height: 5),
                ],
              ),
              const SizedBox(width: 20),
              Flexible(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 220,
                      maxWidth: 220,
                    ),
                    child: Image.asset(
                      "asset/image/about-me.jpeg",
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              )
            ],
          ),
          // const SizedBox(height: 50),
          const Spacer(),
          Container(
            height: MediaQuery.of(context).size.height / 5,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: AutoSizeText(
              "           Over 8 years in software development, overseeing all aspects of the software development life cycle, from analysis mockup through implementation, deployment, and troubleshooting, I created a platform for iot to control washer machines in 600+ laundromats all over the country and built 3+ mobile applications in-store with over 10k+ active users.",
              style: textStyle.copyWith(fontSize: 35),
            ),
          ),
          // const SizedBox(height: 50),
          const Spacer(),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () async {
                        await launchUrlString("https://github.com/bankuu");
                      },
                      child: Row(
                        children: [
                          const Icon(
                            FontAwesome.github,
                            color: Colors.white,
                            size: 30,
                          ),
                          const SizedBox(width: 10),
                          Text("bankuu", style: textStyle.copyWith(fontSize: 20)),
                        ],
                      ),
                    )),
                MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () async {
                        await launchUrlString("https://www.instagram.com/bankuu.gorutan");
                      },
                      child: Row(
                        children: [
                          const Icon(
                            FontAwesome.instagram,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Text("bankuu.gorutan", style: textStyle.copyWith(fontSize: 20)),
                        ],
                      ),
                    )),
                MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () async {
                        await launchUrlString("https://www.leetcode.com/bankuu");
                      },
                      child: Row(
                        children: [
                          Text("LeetCode", style: textStyle.copyWith(fontSize: 20)),
                          const SizedBox(width: 10),
                          Text("bankuu", style: textStyle.copyWith(fontSize: 20)),
                        ],
                      ),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSkillPage() {
    var textStyle = const TextStyle(fontFamily: 'RobotoMono', color: Colors.white);
    return Column(
      children: [
        Container(
          alignment: Alignment.bottomCenter,
          child: ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) => LinearGradient(colors: [
              ColorSet.textBegin.color,
              ColorSet.textEnd.color,
            ]).createShader(
              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
            ),
            child: const Text("FullStack Developer", style: TextStyle(fontSize: 75, height: 1)),
          ),
        ),
        Container(
          height: 3,
          color: controller.selectedMenu?.color ?? ColorSet.background.color,
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.devices_other, color: Color(0xFFE98AEF)),
            SizedBox(width: 10),
            Text("Front-end", style: TextStyle(color: Color(0xFFE98AEF), fontSize: 45)),
            SizedBox(width: 10),
            Icon(Icons.web, color: Color(0xFFE98AEF)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                "Language & Markup",
                style: TextStyle(color: Color(0xFFE98AEF), fontSize: 25),
              ),
              Text(
                "JS, TS, CSS\nDart, Kotlin, Swift\nHTML, Markdown",
                textAlign: TextAlign.center,
                style: textStyle.copyWith(fontSize: 15),
              ),
            ]),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                "Framework & Core Library",
                style: TextStyle(color: Color(0xFFE98AEF), fontSize: 25),
              ),
              Text(
                "Angular, Nuxt.js, Svelte\nFlutter, Mobile native\nTailwind, D3.js",
                textAlign: TextAlign.center,
                style: textStyle.copyWith(fontSize: 15),
              ),
            ]),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                "Principle & Technique",
                style: TextStyle(color: Color(0xFFE98AEF), fontSize: 25),
              ),
              Text(
                "MV[C,P,VM], JAMStack\nReactive programming\nClean architecture",
                textAlign: TextAlign.center,
                style: textStyle.copyWith(fontSize: 15),
              ),
            ]),
          ],
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.code, color: Color(0xFF8A94EF)),
            SizedBox(width: 10),
            Text("Back-end", style: TextStyle(color: Color(0xFF8A94EF), fontSize: 45)),
            SizedBox(width: 10),
            Icon(Icons.work_outline, color: Color(0xFF8A94EF)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                "Language & Markup",
                style: TextStyle(color: Color(0xFF8A94EF), fontSize: 25),
              ),
              Text(
                "JS, TS, CSS\nDart, Kotlin, Swift\nHTML, Markdown",
                textAlign: TextAlign.center,
                style: textStyle.copyWith(fontSize: 15),
              ),
            ]),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                "Framework & Library",
                style: TextStyle(color: Color(0xFF8A94EF), fontSize: 25),
              ),
              Text(
                "Angular, Nuxt.js, Svelte\nFlutter, Mobile native\njQuery, Tailwind.css, D3.js, Lodash",
                textAlign: TextAlign.center,
                style: textStyle.copyWith(fontSize: 15),
              ),
            ]),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                "Principles, Pattern & Techniques",
                style: TextStyle(color: Color(0xFFE98AEF), fontSize: 25),
              ),
              Text(
                "MVC, MVP, MVVM, JAMStack\nReactive programming\nClean architecture",
                textAlign: TextAlign.center,
                style: textStyle.copyWith(fontSize: 15),
              ),
            ]),
          ],
        ),
        Spacer(),

      ],
    );
  }
}
