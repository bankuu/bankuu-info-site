import 'package:bankuu_info_site/utility.dart';
import 'package:bankuu_info_site/view/share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/page/portfolio.dart';

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
    var _menuSelectedItemHeight = MediaQuery.of(context).size.height - (_menuItemHeight * Menu.values.length) - 25;
    return Row(
      children: [
        SizedBox(
          width: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: Menu.values.map((element) {
              return Obx(() {
                var isSelected = controller.selectedMenu == element;
                return AnimatedContainer(
                    height: isSelected ? _menuSelectedItemHeight : _menuItemHeight,
                    curve: Curves.easeInOut,
                    duration: const Duration(milliseconds: 350),
                    child: Center(
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
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
                    ));
              });
            }).toList(),
          ),
        ),
        Expanded(
          child: Container(color: Colors.green),
        )
      ],
    );
  }
}
