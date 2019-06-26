import 'dart:async';

import 'package:bpms_app/page/baidu_map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bpms_app/common/router/size_route.dart';
//import 'package:bpms_app/page/code_detail_page.dart';
//import 'package:bpms_app/page/code_detail_page_web.dart';
//import 'package:bpms_app/page/common_list_page.dart';
//import 'package:bpms_app/page/bpms_webview.dart';
import 'package:bpms_app/page/home_page.dart';
//import 'package:bpms_app/page/issue_detail_page.dart';
import 'package:bpms_app/page/login_page.dart';
//import 'package:bpms_app/page/notify_page.dart';
//import 'package:bpms_app/page/person_page.dart';
//import 'package:bpms_app/page/photoview_page.dart';
//import 'package:bpms_app/page/push_detail_page.dart';
//import 'package:bpms_app/page/release_page.dart';
//import 'package:bpms_app/page/repository_detail_page.dart';
//import 'package:bpms_app/page/search_page.dart';
//import 'package:bpms_app/page/user_profile_page.dart';

/**
 * 导航栏
 * Created by guoshuyu
 * Date: 2018-07-16
 */
class NavigatorUtils {
  ///替换
  static pushReplacementNamed(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }

  ///切换无参数页面
  static pushNamed(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  ///主页
  static goHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, HomePage.sName);
  }

  ///登录页
  static goLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, LoginPage.sName);
  }

  ///登录页
  static goBaiduMap(BuildContext context) {
    Navigator.push(context,new MaterialPageRoute(builder: (context) => new BaiduMap()));
//    Navigator.pushNamed(context, BaiduMap.sName);
  }

//  ///个人中心
//  static goPerson(BuildContext context, String userName) {
//    NavigatorRouter(context, new PersonPage(userName));
//  }

//  ///仓库详情
//  static Future goReposDetail(
//      BuildContext context, String userName, String reposName) {
//    ///利用 SizeRoute 动画大小打开
//    return Navigator.push(
//        context,
//        new SizeRoute(
//            widget: pageContainer(RepositoryDetailPage(userName, reposName))));
//  }

//  ///仓库版本列表
//  static Future goReleasePage(BuildContext context, String userName,
//      String reposName, String releaseUrl, String tagUrl) {
//    return NavigatorRouter(
//        context,
//        new ReleasePage(
//          userName,
//          reposName,
//          releaseUrl,
//          tagUrl,
//        ));
//  }

//  ///issue详情
//  static Future goIssueDetail(
//      BuildContext context, String userName, String reposName, String num,
//      {bool needRightLocalIcon = false}) {
//    return NavigatorRouter(
//        context,
//        new IssueDetailPage(
//          userName,
//          reposName,
//          num,
//          needHomeIcon: needRightLocalIcon,
//        ));
//  }

//  ///通用列表
//  static gotoCommonList(
//      BuildContext context, String title, String showType, String dataType,
//      {String userName, String reposName}) {
//    NavigatorRouter(
//        context,
//        new CommonListPage(
//          title,
//          showType,
//          dataType,
//          userName: userName,
//          reposName: reposName,
//        ));
//  }

//  ///文件代码详情
//  static gotoCodeDetailPage(BuildContext context,
//      {String title,
//      String userName,
//      String reposName,
//      String path,
//      String data,
//      String branch,
//      String htmlUrl}) {
//    NavigatorRouter(
//        context,
//        new CodeDetailPage(
//          title: title,
//          userName: userName,
//          reposName: reposName,
//          path: path,
//          data: data,
//          branch: branch,
//          htmlUrl: htmlUrl,
//        ));
//  }

//  ///仓库详情通知
//  static Future goNotifyPage(BuildContext context) {
//    return NavigatorRouter(context, new NotifyPage());
//  }

//  ///搜索
//  static Future goSearchPage(BuildContext context) {
//    return NavigatorRouter(context, new SearchPage());
//  }

//  ///提交详情
//  static Future goPushDetailPage(BuildContext context, String userName,
//      String reposName, String sha, bool needHomeIcon) {
//    return NavigatorRouter(
//        context,
//        new PushDetailPage(
//          sha,
//          userName,
//          reposName,
//          needHomeIcon: needHomeIcon,
//        ));
//  }

//  ///全屏Web页面
//  static Future goBPMSWebView(BuildContext context, String url, String title) {
//    return NavigatorRouter(context, new BPMSWebView(url, title));
//  }

//  ///文件代码详情Web
//  static gotoCodeDetailPageWeb(BuildContext context,
//      {String title,
//      String userName,
//      String reposName,
//      String path,
//      String data,
//      String branch,
//      String htmlUrl}) {
//    NavigatorRouter(
//        context,
//        new CodeDetailPageWeb(
//          title: title,
//          userName: userName,
//          reposName: reposName,
//          path: path,
//          data: data,
//          branch: branch,
//          htmlUrl: htmlUrl,
//        ));
//  }

//  ///根据平台跳转文件代码详情Web
//  static gotoCodeDetailPlatform(BuildContext context,
//      {String title,
//      String userName,
//      String reposName,
//      String path,
//      String data,
//      String branch,
//      String htmlUrl}) {
//    NavigatorUtils.gotoCodeDetailPageWeb(
//      context,
//      title: title,
//      reposName: reposName,
//      userName: userName,
//      data: data,
//      path: path,
//      branch: branch,
//    );
//  }

//  ///图片预览
//  static gotoPhotoViewPage(BuildContext context, String url) {
//    NavigatorRouter(context, new PhotoViewPage(url));
//  }

//  ///用户配置
//  static gotoUserProfileInfo(BuildContext context) {
//    NavigatorRouter(context, new UserProfileInfo());
//  }

  ///公共打开方式
  static NavigatorRouter(BuildContext context, Widget widget) {
    return Navigator.push(context,
        new CupertinoPageRoute(builder: (context) => pageContainer(widget)));
  }

  ///Page页面的容器，做一次通用自定义
  static Widget pageContainer(widget) {
    return MediaQuery(

        ///不受系统字体缩放影响
        data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
            .copyWith(textScaleFactor: 1),
        child: widget);
  }

  ///弹出 dialog
  static Future<T> showBPMSDialog<T>({
    @required BuildContext context,
    bool barrierDismissible = true,
    WidgetBuilder builder,
  }) {
    return showDialog<T>(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) {
          return MediaQuery(
              ///不受系统字体缩放影响
              data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                  .copyWith(textScaleFactor: 1),
              child: new SafeArea(child: builder(context)));
        });
  }
}
