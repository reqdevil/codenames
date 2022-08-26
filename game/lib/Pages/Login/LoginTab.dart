// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:game/Helpers/AppColors.dart';
import 'package:game/Helpers/Helpers.dart';
import 'package:game/Models/Helper/LoginTabs.dart';
import 'package:game/Pages/Login/Tabs/LoginPage.dart';
import 'package:game/Pages/Login/Tabs/SignPage.dart';
import 'package:game/Pages/Login/Tabs/AnonymousPage.dart';
import 'package:game/Widgets/WidgetSlider.dart';

List<LoginTabs> loginTabs = [
  LoginTabs(1, "Log In"),
  LoginTabs(2, "Anonymous"),
  LoginTabs(3, "Sign Up"),
];

class LoginTab extends StatefulWidget {
  const LoginTab({Key? key}) : super(key: key);

  @override
  State<LoginTab> createState() => _LoginTabState();
}

class _LoginTabState extends State<LoginTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: loginTabs.length,
      vsync: this,
      initialIndex: 1,
    );
    _tabController.addListener(requestTabChange);
    changeTab(_tabController.index);
  }

  @override
  void dispose() {
    super.dispose();

    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double top;
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;

    if (isKeyboard) {
      top = 50;
    } else {
      top = 100;
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              radius: 1,
              colors: [
                AppColors.bgColor,
                AppColors.bgColorDark,
              ],
            ),
          ),
          child: AnimatedPadding(
            padding: EdgeInsets.only(
              left: 45,
              right: 45,
              top: top,
            ),
            duration: Duration.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SlideFadeTransition(
                  delayStart: const Duration(milliseconds: 400),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 4,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.asset('lib/assets/logo.png'),
                    ),
                  ),
                ),
                Expanded(
                  child: _tabWidget(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _tabWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border(
              bottom: BorderSide(
                color: AppColors.black.withOpacity(0.28),
                width: 2,
              ),
            ),
          ),
          child: TabBar(
            onTap: (value) {
              setState(() {
                for (var i = 0; i < loginTabs.length; i++) {
                  if (i == value) {
                    loginTabs[i].isSelected = true;
                    continue;
                  }

                  loginTabs[i].isSelected = false;
                }
              });
            },
            controller: _tabController,
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 2,
            labelColor: AppColors.black,
            indicatorColor: AppColors.black,
            indicatorPadding: const EdgeInsets.only(top: 10),
            labelPadding: const EdgeInsets.only(
              right: 10,
              left: 10,
              top: 10,
              bottom: 10,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 20.0,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w300,
            ),
            tabs: _tabs(),
            physics: const BouncingScrollPhysics(),
          ),
        ),
        Expanded(
          child: TabBarView(
            physics: const BouncingScrollPhysics(),
            controller: _tabController,
            children: const [
              LoginPage(),
              AnonymousPage(),
              SignPage(),
            ],
          ),
        )
      ],
    );
  }

  List<Widget> _tabs() {
    List<Widget> loginTabsWidget = [];

    for (var i = 0; i < loginTabs.length; i++) {
      loginTabsWidget.add(
        Container(
          alignment: Alignment.center,
          child: Text(
            loginTabs[i].text,
            style: loginTabs[i].isSelected
                ? const TextStyle(
                    fontSize: 22.0,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0,
                  )
                : const TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w300,
                  ),
          ),
        ),
      );
    }

    return loginTabsWidget;
  }

  void requestTabChange() {
    BasicHelpers().dissmissKeyboard(context);
    changeTab(_tabController.index);
  }

  void changeTab(int index) {
    setState(() {
      for (var i = 0; i < loginTabs.length; i++) {
        if (i == index) {
          loginTabs[i].isSelected = true;
          continue;
        }

        loginTabs[i].isSelected = false;
      }
    });
  }
}
