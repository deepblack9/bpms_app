import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:bpms_app/common/ab/sql_manager.dart';
import 'package:bpms_app/common/config/config.dart';
//import 'package:bpms_app/common/dao/issue_dao.dart';
//import 'package:bpms_app/common/dao/repos_dao.dart';
import 'package:bpms_app/common/dao/user_dao.dart';
import 'package:bpms_app/common/local/local_storage.dart';
import 'package:bpms_app/common/localization/default_localizations.dart';
import 'package:bpms_app/common/model/User.dart';
import 'package:bpms_app/common/redux/bpms_state.dart';
import 'package:bpms_app/common/style/bpms_style.dart';
import 'package:bpms_app/common/utils/common_utils.dart';
import 'package:bpms_app/common/utils/navigator_utils.dart';
import 'package:bpms_app/widget/bpms_flex_button.dart';
import 'package:package_info/package_info.dart';
import 'package:redux/redux.dart';

/**
 * 主页drawer
 * Created by guoshuyu
 * Date: 2018-07-18
 */
class HomeDrawer extends StatelessWidget {
  showAboutDialog(BuildContext context, String versionName) {
    versionName ??= "Null";
    NavigatorUtils.showBPMSDialog(
        context: context,
        builder: (BuildContext context) => AboutDialog(
              applicationName: CommonUtils.getLocale(context).app_name,
              applicationVersion: CommonUtils.getLocale(context).app_version + ": " + versionName,
              applicationIcon: new Image(image: new AssetImage(BPMSICons.DEFAULT_USER_ICON), width: 50.0, height: 50.0),
              applicationLegalese: "http://github.com/CarGuo",
            ));
  }

  showThemeDialog(BuildContext context, Store store) {
    List<String> list = [
      CommonUtils.getLocale(context).home_theme_default,
      CommonUtils.getLocale(context).home_theme_1,
      CommonUtils.getLocale(context).home_theme_2,
      CommonUtils.getLocale(context).home_theme_3,
      CommonUtils.getLocale(context).home_theme_4,
      CommonUtils.getLocale(context).home_theme_5,
      CommonUtils.getLocale(context).home_theme_6,
    ];
    CommonUtils.showCommitOptionDialog(context, list, (index) {
      CommonUtils.pushTheme(store, index);
      LocalStorage.save(Config.THEME_COLOR, index.toString());
    }, colorList: CommonUtils.getThemeListColor());
  }

  showLanguageDialog(BuildContext context, Store store) {
    List<String> list = [
      CommonUtils.getLocale(context).home_language_default,
      CommonUtils.getLocale(context).home_language_zh,
      CommonUtils.getLocale(context).home_language_en,
    ];
    CommonUtils.showCommitOptionDialog(context, list, (index) {
      CommonUtils.changeLocale(store, index);
      LocalStorage.save(Config.LOCALE, index.toString());
    }, height: 150.0);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: new StoreBuilder<BPMSState>(
        builder: (context, store) {
          User user = store.state.userInfo;
          return new Drawer(
            ///侧边栏按钮Drawer
            child: new Container(
              ///默认背景
              color: store.state.themeData.primaryColor,
              child: new SingleChildScrollView(
                ///item 背景
                child: Container(
                  constraints: new BoxConstraints(minHeight: MediaQuery.of(context).size.height),
                  child: new Material(
                    color: Color(BPMSColors.white),
                    child: new Column(
                      children: <Widget>[
                        new UserAccountsDrawerHeader(
                          //Material内置控件
                          accountName: new Text(
                            user.login ?? "---",
                            style: BPMSConstant.largeTextWhite,
                          ),
                          accountEmail: new Text(
                            user.email ?? user.name ?? "---",
                            style: BPMSConstant.normalTextLight,
                          ),
                          //用户名
                          //用户邮箱
                          currentAccountPicture: new GestureDetector(
                            //用户头像
                            onTap: () {},
                            child: new CircleAvatar(
                              //圆形图标控件
                              backgroundImage: new NetworkImage(user.avatar_url ?? BPMSICons.DEFAULT_USER_ICON),
                            ),
                          ),
                          decoration: new BoxDecoration(
                            //用一个BoxDecoration装饰器提供背景图片
                            color: store.state.themeData.primaryColor,
                          ),
                        ),
                        new ListTile(
                            title: new Text(
                              CommonUtils.getLocale(context).home_reply,
                              style: BPMSConstant.normalText,
                            ),
                            onTap: () {
                              String content = "";
                              CommonUtils.showEditDialog(context, CommonUtils.getLocale(context).home_reply, (title) {}, (res) {
                                content = res;
                              }, () {
                                if (content == null || content.length == 0) {
                                  return;
                                }
                                CommonUtils.showLoadingDialog(context);
//                                IssueDao.createIssueDao(
//                                        "CarGuo", "BPMSGithubAppFlutter", {"title": CommonUtils.getLocale(context).home_reply, "body": content})
//                                    .then((result) {
//                                  Navigator.pop(context);
//                                  Navigator.pop(context);
//                                });
                              }, titleController: new TextEditingController(), valueController: new TextEditingController(), needTitle: false);
                            }),
                        new ListTile(
                            title: new Text(
                              CommonUtils.getLocale(context).home_history,
                              style: BPMSConstant.normalText,
                            ),
                            onTap: () {
//                              NavigatorUtils.gotoCommonList(context, CommonUtils.getLocale(context).home_history, "repository", "history",
//                                  userName: "", reposName: "");
                            }),
                        new ListTile(
                            title: new Hero(
                                tag: "home_user_info",
                                child: new Material(
                                    color: Colors.transparent,
                                    child: new Text(
                                      CommonUtils.getLocale(context).home_user_info,
                                      style: BPMSConstant.normalTextBold,
                                    ))),
                            onTap: () {
//                              NavigatorUtils.gotoUserProfileInfo(context);
                            }),
                        new ListTile(
                            title: new Text(
                              CommonUtils.getLocale(context).home_change_theme,
                              style: BPMSConstant.normalText,
                            ),
                            onTap: () {
                              showThemeDialog(context, store);
                            }),
                        new ListTile(
                            title: new Text(
                              CommonUtils.getLocale(context).home_change_language,
                              style: BPMSConstant.normalText,
                            ),
                            onTap: () {
                              showLanguageDialog(context, store);
                            }),
                        new ListTile(
                            title: new Text(
                              CommonUtils.getLocale(context).home_check_update,
                              style: BPMSConstant.normalText,
                            ),
                            onTap: () {
//                              ReposDao.getNewsVersion(context, true);
                            }),
                        new ListTile(
                            title: new Text(
                              BPMSLocalizations.of(context).currentLocalized.home_about,
                              style: BPMSConstant.normalText,
                            ),
                            onTap: () {
                              PackageInfo.fromPlatform().then((value) {
                                print(value);
                                showAboutDialog(context, value.version);
                              });
                            }),
                        new ListTile(
                            title: new BPMSFlexButton(
                              text: CommonUtils.getLocale(context).Login_out,
                              color: Colors.redAccent,
                              textColor: Color(BPMSColors.textWhite),
                              onPress: () {
                                UserDao.clearAll(store);
                                SqlManager.close();
//                                NavigatorUtils.goLogin(context);
                                new Future.delayed(const Duration(milliseconds: 100), () {
                                  NavigatorUtils.goLogin(context);
                                  return true;
                                });
                              },
                            ),
                            onTap: () {}),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
