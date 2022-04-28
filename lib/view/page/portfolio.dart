import 'package:auto_size_text/auto_size_text.dart';
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
                shaderCallback: (bounds) =>
                    LinearGradient(colors: [
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
                    () =>
                    Expanded(
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
        return _buildExperiencePage(context);
    // case Menu.anythingElse:
      case Menu.contact:
        return _buildContactPage(context);
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
                  Text("🎓  Bachelor Computer Engineering", style: textStyle.copyWith(fontSize: 18)),
                  const SizedBox(height: 5),
                  Text("🏫  Dhurakij Pundit University", style: textStyle.copyWith(fontSize: 18)),
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
            height: MediaQuery
                .of(context)
                .size
                .height / 5,
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
            shaderCallback: (bounds) =>
                LinearGradient(colors: [
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
            Text("Frontend", style: TextStyle(color: Color(0xFFE98AEF), fontSize: 45)),
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
                "Dart, TS, JS\n"
                    "Kotlin, Swift, CSS\n"
                    "HTML, Markdown",
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
                "Flutter, Angular, Nuxt.js\n"
                    "Svelte, Mobile Native\n"
                    "Tailwind, D3.js",
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
                "Reactive Programming\n"
                    "Clean Architecture\n"
                    "MV[C/P/VM], JAMStack",
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
            Text("Backend", style: TextStyle(color: Color(0xFF8A94EF), fontSize: 45)),
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
                "Golang, Python\n"
                    "C#, Java, JS\n"
                    "JSON, XML, YAML, Protobuf",
                textAlign: TextAlign.center,
                style: textStyle.copyWith(fontSize: 15),
              ),
            ]),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                "Framework & Core Library",
                style: TextStyle(color: Color(0xFF8A94EF), fontSize: 25),
              ),
              Text(
                "Echo, Gofiber, Django+DRF\n"
                    ".NET, FastAPI, Falcon\n"
                    "GORM, SQLAlchemy, EF.NET\n"
                    "Asynq, Celery\n"
                    "OpenFaaS, Cloudflare Worker",
                textAlign: TextAlign.center,
                style: textStyle.copyWith(fontSize: 15),
              ),
            ]),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                "Storage Management",
                style: TextStyle(color: Color(0xFF8A94EF), fontSize: 25),
              ),
              Text(
                "RDBMS, TSDB, NoSQL\n"
                    "Redis, Memcache\n"
                    "Strapi, Directus, NocoDB",
                textAlign: TextAlign.center,
                style: textStyle.copyWith(fontSize: 15),
              ),
            ]),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                "Theory & Principle",
                style: TextStyle(color: Color(0xFF8A94EF), fontSize: 25),
              ),
              Text(
                "Data Structure & Algorithm\n"
                    "OOP + Design Pattern, N-Tier\n"
                    "Clean Architecture",
                textAlign: TextAlign.center,
                style: textStyle.copyWith(fontSize: 15),
              ),
            ]),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                "Technique & Strategy",
                style: TextStyle(color: Color(0xFF8A94EF), fontSize: 25),
              ),
              Text(
                "ORM, Multi-Processing\n"
                    "Caching, Message Queue",
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
            Icon(Icons.control_camera, color: Color(0xFF8AEFC0)),
            SizedBox(width: 10),
            Text("Operations", style: TextStyle(color: Color(0xFF8AEFC0), fontSize: 45)),
            SizedBox(width: 10),
            Icon(Icons.cloud_queue, color: Color(0xFF8AEFC0)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                "System Operation",
                style: TextStyle(color: Color(0xFF8AEFC0), fontSize: 25),
              ),
              Text(
                "UNIX & Linux Kernel\n"
                    "VMware ESXi, Hyper-V, Docker\n"
                    "Nginx, IIS, Gunicorn, Traefik",
                textAlign: TextAlign.center,
                style: textStyle.copyWith(fontSize: 15),
              ),
            ]),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                "Cloud Operation",
                style: TextStyle(color: Color(0xFF8AEFC0), fontSize: 25),
              ),
              Text(
                "AWS, DigitalOcean, Cloudflare\n"
                    "EC2, EKS, RDS, S3\n"
                    "Droplet, Space\n"
                    "Page, Worker & KV",
                textAlign: TextAlign.center,
                style: textStyle.copyWith(fontSize: 15),
              ),
            ]),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                "Others",
                style: TextStyle(color: Color(0xFF8AEFC0), fontSize: 25),
              ),
              Text(
                "SSH, FTP, RPC\n"
                    "TeamCity, Github CI\n"
                    "Monday, Taskade",
                textAlign: TextAlign.center,
                style: textStyle.copyWith(fontSize: 15),
              ),
            ]),
          ],
        ),
        const Spacer(),
      ],
    );
  }

  Widget _buildExperiencePage(BuildContext context) {
    var pageController = PageController();
    return PageView(
      controller: pageController,
      children: [
        _buildExperiencePageNysiisPageItem(pageController),
        _buildExperiencePageUIHPageItem(pageController),
        _buildExperiencePagePinpertyPageItem(pageController),
        _buildExperiencePageBigheadPageItem(pageController),
        _buildExperiencePageTDEVPageItem(pageController),
        // _buildExperiencePageFreelancePageItem(pageController),
        // _buildExperiencePageGoRuTANPageItem(pageController),
      ],
    );
  }

  Widget _buildExperiencePageNysiisPageItem(PageController pageController) {
    var textStyle = TextStyle(fontFamily: 'RobotoMono', color: Colors.orange.shade100);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 150,
                  width: 700,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "asset/image/nysiis/nysiis-doa-logo.png",
                        fit: BoxFit.fitHeight,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          constraints: const BoxConstraints(minWidth: 500),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                "NSW Project - Department of Agriculture",
                                style: textStyle.copyWith(
                                  fontSize: 22,
                                ),
                                maxLines: 1,
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                height: 100,
                                child: AutoSizeText.rich(
                                  const TextSpan(children: [
                                    TextSpan(text: " - Develop Web Application  of Customer in e-Documentary Request System\n"),
                                    TextSpan(text: " - Develop Application  of Administrator in e-Documentary Approval System\n"),
                                    TextSpan(text: " - Develop Service Layer to WebService"),
                                  ]),
                                  style: textStyle.copyWith(fontSize: 16),
                                  minFontSize: 0,
                                  stepGranularity: 0.1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 150,
                  width: 700,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "asset/image/nysiis/nysiis-ecs-logo.png",
                        fit: BoxFit.fitHeight,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              "Internal ERP System - ECS",
                              style: textStyle.copyWith(
                                fontSize: 22,
                              ),
                              maxLines: 1,
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 100,
                              child: AutoSizeText.rich(
                                const TextSpan(children: [
                                  TextSpan(text: " - Fixbug & Troubleshoot ERP Application of Internal System\n"),
                                  TextSpan(text: " - Support & Test Step on ERP Application\n"),
                                ]),
                                style: textStyle.copyWith(fontSize: 16),
                                minFontSize: 0,
                                stepGranularity: 0.1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        _buildExperiencePageButtonBar(pageController,
            title: ".NET Developer | Nysiis Solutions Co., Ltd.",
            subtitle: "February 2012 - January 2014",
            colorList: [
              Colors.blue,
              Colors.yellow,
              Colors.deepOrange,
            ],
            isHideBack: true,
            assetImage: "asset/image/nysiis-logo.png"),
      ],
    );
  }

  Widget _buildExperiencePageUIHPageItem(PageController pageController) {
    var textStyle = TextStyle(fontFamily: 'RobotoMono', color: Colors.green.shade100);
    return Column(children: [
      Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 150,
                width: 700,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AutoSizeText(
                            "Internal Company Group",
                            style: textStyle.copyWith(
                              fontSize: 22,
                            ),
                            maxLines: 1,
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 100,
                            child: AutoSizeText.rich(
                              const TextSpan(children: [
                                TextSpan(text: " - Develop Backends Service Website to contact consumers\n"),
                                TextSpan(text: " - Develop E-Mobile Top-up with Handle slip printer\n"),
                                TextSpan(text: " - Develop Web Application to Display Layer-Map on google maps to browser for Wiring network"),
                              ]),
                              style: textStyle.copyWith(fontSize: 16),
                              minFontSize: 0,
                              stepGranularity: 0.1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      _buildExperiencePageButtonBar(pageController,
          title: ".NET Developer | UIH Co., Ltd.",
          subtitle: "April 2014 - April 2015",
          colorList: [
            Colors.green,
            Colors.greenAccent,
            Colors.green,
          ],
          assetImage: "asset/image/uih-logo.png"),
    ]);
  }

  Widget _buildExperiencePagePinpertyPageItem(PageController pageController) {
    var textStyle = TextStyle(fontFamily: 'RobotoMono', color: Colors.blue.shade200);

    return Column(children: [
      Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                width: 750,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AutoSizeText(
                            "Real Estate Trading Platform",
                            style: textStyle.copyWith(
                              fontSize: 22,
                            ),
                            maxLines: 1,
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 150,
                            child: AutoSizeText.rich(
                              const TextSpan(children: [
                                TextSpan(text: " - Design DBS and Use Flexview to optimized in RDBMS\n"),
                                TextSpan(text: " - Design InfoBase to keeping BigData in MongoDB\n"),
                                TextSpan(text: " - Build SphinxSearch in Full-Text Search Engine\n"),
                                TextSpan(text: " - Deploy OLAP server to Reporting applications on sites\n"),
                                TextSpan(text: " - Create Glue Language in passing between process\n"),
                                TextSpan(text: " - Build WebSocket to realtime-process in applications\n"),
                                TextSpan(text: " - Develop Mobile-Application using for Survey\n"),
                                TextSpan(text: " - Install and Maintenance Server in project"),
                              ]),
                              style: textStyle.copyWith(fontSize: 16),
                              minFontSize: 0,
                              stepGranularity: 0.1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 200,
                child: Image.asset(
                  "asset/image/pinperty/pinperty-project-view.png",
                  fit: BoxFit.fitHeight,
                ),
              )
            ],
          ),
        ),
      ),
      _buildExperiencePageButtonBar(pageController,
          title: "Startup Member, System Engineer | Pinperty Co., Ltd.",
          subtitle: "April 2015 - April 2016",
          colorList: [
            Colors.lightBlue,
            Colors.lightBlue,
            Colors.deepOrange,
          ],
          assetImage: "asset/image/pinperty-logo.png"),
    ]);
  }

  Widget _buildExperiencePageBigheadPageItem(PageController pageController) {
    var textStyle = TextStyle(fontFamily: 'RobotoMono', color: Colors.red.shade100);

    return Column(children: [
      Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              AutoSizeText(
                "CRM & Privilege Application",
                style: textStyle.copyWith(
                  fontSize: 22,
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: AutoSizeText.rich(
                  const TextSpan(children: [
                    TextSpan(text: "MTL Smile Service\n"),
                    TextSpan(text: " - Implement on MVP Concept\n"),
                    TextSpan(text: " - Use with Mobile Native Language\n"),
                    TextSpan(text: " - Communicate Service Layer with SOAP\n\n"),
                    TextSpan(text: "Toyota T-Mex & Privilege\n"),
                    TextSpan(text: " - Design on Reactive Programing Concept (ReactiveX)\n"),
                    TextSpan(text: " - Use with Mobile Native Language\n"),
                    TextSpan(text: " - Communicate Service Layer with REST\n\n"),
                    TextSpan(text: "Meetang\n"),
                    TextSpan(text: " - Implement on MVC Concept\n"),
                    TextSpan(text: " - Use with Cross-platform Language (Xamarin)\n"),
                  ]),
                  style: textStyle.copyWith(fontSize: 24),
                  minFontSize: 0,
                  stepGranularity: 0.1,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Some project that contribute to the developed",
                style: textStyle.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 20),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Row(children: [
                  Expanded(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 80,
                            width: 80,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(
                                "asset/image/bighead/bighead-mtl-app-logo.png",
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text("MTL Smile Service", textAlign: TextAlign.center, style: textStyle)
                        ],
                      )),
                  Expanded(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 80,
                            width: 80,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(
                                "asset/image/bighead/bighead-tmex-app-logo.png",
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text("Toyota T-MEx", textAlign: TextAlign.center, style: textStyle)
                        ],
                      )),
                  Expanded(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 80,
                            width: 80,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(
                                "asset/image/bighead/bighead-toyota-app-logo.png",
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text("Toyota Privilege", textAlign: TextAlign.center, style: textStyle),
                        ],
                      )),
                  Expanded(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 80,
                            width: 80,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(
                                "asset/image/bighead/bighead-meetang-app-logo.png",
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text("Meetang", textAlign: TextAlign.center, style: textStyle),
                        ],
                      )),
                ]),
              ),
            ],
          ),
        ),
      ),
      _buildExperiencePageButtonBar(pageController,
          title: "Mobile Developer | Bighead Co., Ltd.",
          subtitle: "June 2016 - February 2018",
          colorList: [
            Colors.redAccent,
            Colors.pink,
            Colors.redAccent,
          ],
          assetImage: "asset/image/bighead-logo.png"),
    ]);
  }

  Widget _buildExperiencePageTDEVPageItem(PageController pageController) {
    var textStyle = TextStyle(fontFamily: 'RobotoMono', color: Colors.lightBlueAccent.shade100);

    return Column(children: [
      Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              AutoSizeText(
                "CRM System & IoT Platform",
                style: textStyle.copyWith(
                  fontSize: 22,
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: AutoSizeText.rich(
                  const TextSpan(children: [
                    TextSpan(text: "Otteri ORM Platform\n"),
                    TextSpan(text: " - Implement on Bloc Pattern & N-Tier Concept\n"),
                    TextSpan(text: " - Implement on MVT+Serializer Concept\n"),
                    TextSpan(text: " - Use Dart on Frontend Language\n"),
                    TextSpan(text: " - Use Python on Backend Language\n\n"),
                    TextSpan(text: "Laundromat Control Platform & Internal Payment Gateway\n"),
                    TextSpan(text: " - Use Golang Language\n"),
                    TextSpan(text: " - Implement on Microservice + Clean Architecture Concept\n"),
                    TextSpan(text: " - Used MQTT Broker to Communicate Service and IoT Unit\n\n"),
                    TextSpan(text: "IoT Box Service & Reserve Tray Service\n"),
                    TextSpan(text: " - Use Python Language\n"),
                    TextSpan(text: " - Implement on MVT+Serializer Concept\n\n"),
                  ]),
                  style: textStyle.copyWith(fontSize: 24),
                  minFontSize: 0,
                  stepGranularity: 0.1,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Some project that contribute to the developed",
                style: textStyle.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 20),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 650),
                child: Row(children: [
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 70,
                          width: 70,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              "asset/image/tdev/tdev-otteri-app-logo.png",
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text("Otteri CRM Platform", textAlign: TextAlign.center, style: textStyle)
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 70,
                          width: 70,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              "asset/image/tdev/tdev-lcp-app-logo.png",
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        AutoSizeText("LC Platform", textAlign: TextAlign.center, style: textStyle)
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 70,
                          width: 70,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              "asset/image/tdev/tdev-knexpay-app-logo.png",
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text("Internal PG", textAlign: TextAlign.center, style: textStyle),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 70,
                          width: 70,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              "asset/image/tdev/tdev-2eh-app-logo.png",
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text("IoT Box Service", textAlign: TextAlign.center, style: textStyle),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 70,
                          width: 70,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              "asset/image/tdev/tdev-railway-app-logo.png",
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text("Reserve Tray Service", textAlign: TextAlign.center, style: textStyle),
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
      _buildExperiencePageButtonBar(pageController,
          title: "Co-Founder, R&D Initiator | T-DEV Co., Ltd.",
          subtitle: "August 2018 - May 2022",
          colorList: [
            Colors.lightBlueAccent,
            Colors.blue,
            Colors.lightBlueAccent,
          ],
          assetImage: "asset/image/tdev-logo.png",
          isHideNext: true),
    ]);
  }

  Widget _buildExperiencePageFreelancePageItem(PageController pageController) {
    var textStyle = const TextStyle(fontFamily: 'RobotoMono', color: Colors.white24);

    return Column(children: [
      Expanded(
        child: Text("Coming Soon...", style: textStyle),
      ),
      _buildExperiencePageButtonBar(pageController,
          title: "Freelance Coder",
          subtitle: "2018 - NOW",
          colorList: [
            Colors.red,
            Colors.green,
            Colors.blue,
          ],
          isHideNext: true),
    ]);
  }

  Widget _buildExperiencePageGoRuTANPageItem(PageController pageController) {
    return Column(children: [
      const Spacer(),
      _buildExperiencePageButtonBar(pageController,
          title: "Middle Brother, Tech Support Unit | GoRUTAN",
          subtitle: "10 April 1990 - FOREVER",
          colorList: [
            Colors.yellow,
            Colors.orange,
            Colors.yellow,
          ],
          assetImage: "asset/image/gorutan-logo.png",
          isHideNext: true),
    ]);
  }

  Widget _buildExperiencePageButtonBar(PageController pageController, {
    required String title,
    required String subtitle,
    required List<Color> colorList,
    String? assetImage,
    bool isHideBack = false,
    bool isHideNext = false,
  }) {
    return SizedBox(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          if (!isHideBack)
            SizedBox(
              width: 40,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTapDown: (_) {
                    pageController.previousPage(
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Icon(Icons.arrow_back_ios_sharp, color: colorList.first, size: 30),
                ),
              ),
            )
          else
            const SizedBox(width: 40),
          if (assetImage != null) Image.asset(assetImage, fit: BoxFit.fitHeight),
          Expanded(
            child: ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) =>
                  LinearGradient(colors: colorList).createShader(
                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                  ),
              child: Column(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: AutoSizeText(
                        title,
                        style: const TextStyle(fontSize: 40, height: 0.8),
                      ),
                    ),
                  ),
                  Expanded(
                    child: AutoSizeText(
                      subtitle,
                      style: const TextStyle(fontSize: 30, height: 0.8),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (!isHideNext)
            SizedBox(
                width: 40,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTapDown: (_) {
                      pageController.nextPage(
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Icon(Icons.arrow_forward_ios_sharp, color: colorList.last, size: 30),
                  ),
                ))
          else
            const SizedBox(width: 40),
        ]),
      ),
    );
  }

  Widget _buildContactPage(BuildContext context) {
    var textStyle = const TextStyle(color: Colors.white70, fontSize: 50);
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            SelectableText("EMAIL : ban.kuu@yahoo.com", style: textStyle),
            SelectableText("PHONE : (+66) 95-525-1704", style: textStyle),
            SelectableText("LINKEDIN : linkedin.com/in/bankuu", style: textStyle),
          ],
        ),
        Opacity(
          opacity: 0.1,
          child: Image.asset("asset/image/contact-bg.png"),
        ),
      ],
    );
  }
}
