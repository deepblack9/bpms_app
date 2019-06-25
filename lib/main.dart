import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
//import 'package:flutter_just_toast/flutter_just_toast.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'common/event/http_error_event.dart';
import 'common/event/index.dart';
import 'common/redux/bpms_state.dart';
import 'common/model/User.dart';
import 'common/style/bpms_style.dart';
import 'common/utils/common_utils.dart';
import 'common/net/code.dart';
import 'common/utils/navigator_utils.dart';
import 'common/localization/bpms_localizations_delegate.dart';
import 'page/home_page.dart';
import 'page/login_page.dart';
import 'page/scanView.dart';
import 'page/welcome_page.dart';

void main() {
  runZoned(() {
    runApp(FlutterReduxApp());
    PaintingBinding.instance.imageCache.maximumSize = 100;
  }, onError: (Object obj, StackTrace stack) {
    print(obj);
    print(stack);
  });
}

class FlutterReduxApp extends StatelessWidget {
  /// 创建Store，引用 BPMSState 中的 appReducer 实现 Reducer 方法
  /// initialState 初始化 State
  final store = new Store<BPMSState>(
    appReducer,
    middleware: middleware,

    ///初始化数据
    initialState: new BPMSState(
        userInfo: User.empty(),
        themeData: CommonUtils.getThemeData(BPMSColors.primarySwatch),
        locale: Locale('zh', 'CH')),
  );

  FlutterReduxApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 通过 StoreProvider 应用 store
    return new StoreProvider(
      store: store,
      child: new StoreBuilder<BPMSState>(builder: (context, store) {
        return new MaterialApp(

          ///多语言实现代理
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              BPMSLocalizationsDelegate.delegate,
            ],
            locale: store.state.locale,
            supportedLocales: [store.state.locale],
            theme: store.state.themeData,
            routes: {
              WelcomePage.sName: (context) {
                store.state.platformLocale = Localizations.localeOf(context);
                return WelcomePage();
              },
              HomePage.sName: (context) {
                ///通过 Localizations.override 包裹一层，
                return new BPMSLocalizations(
                    child: NavigatorUtils.pageContainer(new HomePage()));
              },
              LoginPage.sName: (context) {
                return new BPMSLocalizations(
                    child: NavigatorUtils.pageContainer(new LoginPage()));
              },
            });
      }),
    );
  }
}

class BPMSLocalizations extends StatefulWidget {
  final Widget child;

  BPMSLocalizations({Key key, this.child}) : super(key: key);

  @override
  State<BPMSLocalizations> createState() {
    return new _BPMSLocalizations();
  }
}

class _BPMSLocalizations extends State<BPMSLocalizations> {
  StreamSubscription stream;

  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<BPMSState>(builder: (context, store) {
      ///通过 StoreBuilder 和 Localizations 实现实时多语言切换
      return new Localizations.override(
        context: context,
        locale: store.state.locale,
        child: widget.child,
      );
    });
  }

  var flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    super.initState();

    ///Stream演示event bus
    stream = eventBus.on<HttpErrorEvent>().listen((event) {
      errorHandleFunction(event.code, event.message);
    });

    var initializationSettingsAndroid =
    new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidRecieveLocalNotification);
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }
  Future onDidRecieveLocalNotification(
      int id, String title, String body, String payload) async {
    // 展示通知内容的 dialog.
    showDialog(
      context: context,
      builder: (BuildContext context) => new CupertinoAlertDialog(
        title: new Text(title),
        content: new Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: new Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              await Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new ScanView(),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    await Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new ScanView()),
    );
  }

  Future _showNotification() async {
    //安卓的通知配置，必填参数是渠道id, 名称, 和描述, 可选填通知的图标，重要度等等。
//    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
//        'your channel id', 'your channel name', 'your channel description',
//        importance: Importance.Max, priority: Priority.High);
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        '0', '00', '000',
        importance: Importance.Max, priority: Priority.High);
    //IOS的通知配置
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    //显示通知，其中 0 代表通知的 id，用于区分通知。
    await flutterLocalNotificationsPlugin.show(
        0, 'title', 'content', platformChannelSpecifics,
        payload: 'complete');
  }

  @override
  void dispose() {
    super.dispose();
    if (stream != null) {
      stream.cancel();
      stream = null;
    }
  }

  ///网络错误提醒
  errorHandleFunction(int code, message) {
    switch (code) {
      case Code.NETWORK_ERROR:
//        Toast.show(message: CommonUtils.getLocale(context).network_error,duration: Delay.SHORT);
//        Fluttertoast.showToast(
//            msg: CommonUtils.getLocale(context).network_error);
        break;
      case 401:
//        Toast.show(message: CommonUtils.getLocale(context).network_error_401,duration: Delay.SHORT);
//        Fluttertoast.showToast(
//            msg: CommonUtils.getLocale(context).network_error_401);
        break;
      case 403:
//        Toast.show(message: CommonUtils.getLocale(context).network_error_403,duration: Delay.SHORT);
//        Fluttertoast.showToast(
//            msg: CommonUtils.getLocale(context).network_error_403);
        break;
      case 404:
//        Toast.show(message: CommonUtils.getLocale(context).network_error_404,duration: Delay.SHORT);
//        Fluttertoast.showToast(
//            msg: CommonUtils.getLocale(context).network_error_404);
        break;
      case Code.NETWORK_TIMEOUT:
      //超时
//        Toast.show(message: CommonUtils.getLocale(context).network_error_timeout,duration: Delay.SHORT);
//        Fluttertoast.showToast(
//            msg: CommonUtils.getLocale(context).network_error_timeout);
        break;
      default:
//        Toast.show(message: CommonUtils.getLocale(context).network_error_unknown + " " + message,duration: Delay.SHORT);
//        Fluttertoast.showToast(
//            msg: CommonUtils.getLocale(context).network_error_unknown +
//                " " +
//                message);
        break;
    }
  }
}
