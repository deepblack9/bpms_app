import 'dart:async';
import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';

import 'package:bpms_app/common/localization/default_localizations.dart';
import 'package:bpms_app/common/style/bpms_style.dart';
import 'package:bpms_app/common/utils/common_utils.dart';
import 'package:bpms_app/common/utils/navigator_utils.dart';
//import 'package:bpms_app/page/dynamic_page.dart';
//import 'package:bpms_app/page/my_page.dart';
//import 'package:bpms_app/page/trend_page.dart';
import 'package:bpms_app/widget/bpms_tabbar_widget.dart';
import 'package:bpms_app/widget/bpms_title_bar.dart';
import 'package:bpms_app/widget/home_drawer.dart';

/**
 * 主页
 * Created by guoshuyu
 * Date: 2018-07-16
 */
class HomePage extends StatelessWidget {
  static final String sName = "home";

  /// 不退出
  Future<bool> _dialogExitApp(BuildContext context) async {
    ///如果是 android 回到桌面
    if (Platform.isAndroid) {
      AndroidIntent intent = AndroidIntent(
        action: 'android.intent.action.MAIN',
        category: "android.intent.category.HOME",
      );
      await intent.launch();
    }

    return Future.value(false);
  }

  _renderTab(icon, text) {
    return new Tab(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[new Icon(icon, size: 16.0), new Text(text)],
      ),
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      _renderTab(BPMSICons.MAIN_DT, CommonUtils.getLocale(context).home_dynamic),
      _renderTab(BPMSICons.MAIN_QS, CommonUtils.getLocale(context).home_trend),
      _renderTab(BPMSICons.MAIN_MY, CommonUtils.getLocale(context).home_my),
    ];
    ///增加返回按键监听
    return WillPopScope(
      onWillPop: () {
        return _dialogExitApp(context);
      },
      child: new BPMSTabBarWidget(
        drawer: new HomeDrawer(),
        type: BPMSTabBarWidget.BOTTOM_TAB,
        tabItems: tabs,
        tabViews: [
//          new DynamicPage(),
//          new TrendPage(),
//          new MyPage(),
        ],
        backgroundColor: BPMSColors.primarySwatch,
        indicatorColor: Color(BPMSColors.white),
        title: BPMSTitleBar(
          BPMSLocalizations.of(context).currentLocalized.app_name,
          iconData: BPMSICons.MAIN_SEARCH,
          needRightLocalIcon: true,
          onPressed: () {
//            NavigatorUtils.goSearchPage(context);
          },
        ),
      ),
    );
  }
}
