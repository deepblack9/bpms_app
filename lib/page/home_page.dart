import 'dart:async';
import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:qr_utils/qr_utils.dart';

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

import 'examine_page.dart';
import 'function_page.dart';
import 'my_page.dart';
import 'supervision_page.dart';

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
        children: <Widget>[new Icon(icon, size: 24.0), new Text(text)],
      ),
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      _renderTab(BPMSICons.MAIN_DT, CommonUtils.getLocale(context).home_supervision),
      _renderTab(BPMSICons.MAIN_QS, CommonUtils.getLocale(context).home_examine),
      _renderTab(BPMSICons.MAIN_QS, CommonUtils.getLocale(context).home_function),
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
          new SupervisionPage(),
          new ExaminePage(),
          new FunctionPage(),
          new MyPage(),
        ],
        backgroundColor: BPMSColors.primarySwatch,
        indicatorColor: Color(BPMSColors.white),
        title: BPMSTitleBar(
          BPMSLocalizations.of(context).currentLocalized.app_name,
          children: [
//            popMenu(context),
            _NomalPopMenu(),
          ],
        ),
      ),
    );
  }

  Widget _NomalPopMenu() {
    return new PopupMenuButton<String>(
      itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
        new PopupMenuItem<String>(
            value: 'qrscan', child: new Text('扫码')),
        new PopupMenuItem<String>(
            value: 'value02', child: new Text('Item Two')),
        new PopupMenuItem<String>(
            value: 'value03', child: new Text('Item Three')),
        new PopupMenuItem<String>(
            value: 'value04', child: new Text('I am Item Four'))
      ],
      onSelected: (String value) {
        print(value);
        switch(value) {
//          case "qrscan": _openQRScanner();break;
        }
//          setState(() { _bodyStr = value; });
      }
    );
  }

//  Widget popMenu(BuildContext context) {
//    return new IconButton(
//      icon: new Icon(
//        BPMSICons.MORE,
//        size: 19.0,
//      ),
//      onPressed: () async {
//        final result = await showMenu(
//          context: context,
////          position: RelativeRect.fromLTRB(
////                          2000.0,
////                          kBottomNavigationBarHeight +
////                              MediaQueryData.fromWindow(window).padding.top,
////                          0.0,
////                          0.0),
//          position: RelativeRect.fromLTRB(250.0, 86.0, 5.0, 100.0),
////    position: RelativeRect.fromLTRB(1000.0, 1000.0, 0.0, 10.0),
//          items: <PopupMenuItem<String>>[
//            new PopupMenuItem<String>( value: 'qrscan', child: new Text('扫码')),
//            new PopupMenuItem<String>( value: 'value02', child: new Text('Item Two')),
//            new PopupMenuItem<String>( value: 'value03', child: new Text('Item Three')),
//            new PopupMenuItem<String>( value: 'value04', child: new Text('I am Item Four'))
//          ],
//        );
////            NavigatorUtils.goSearchPage(context);
//      },
//    );
//  }
}
