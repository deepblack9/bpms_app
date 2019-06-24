import 'dart:async';

import 'package:redux/redux.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_lottie/flutter_lottie.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:bpms_app/common/redux/bpms_state.dart';
import 'package:bpms_app/common/dao/user_dao.dart';
import 'package:bpms_app/common/style/bpms_style.dart';
import 'package:bpms_app/common/utils/common_utils.dart';
import 'package:bpms_app/common/utils/navigator_utils.dart';


/**
 * 欢迎页
 * Created by guoshuyu
 * Date: 2018-07-16
 */

class WelcomePage extends StatefulWidget {
  static final String sName = "/";

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool hadInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (hadInit) {
      return;
    }
    hadInit = true;

    ///防止多次进入
    Store<BPMSState> store = StoreProvider.of(context);
    CommonUtils.initStatusBarHeight(context);
    new Future.delayed(const Duration(seconds: 2, milliseconds: 500), () {
      UserDao.initUserInfo(store).then((res) {
        if (res != null && res.result) {
          NavigatorUtils.goHome(context);
        } else {
          NavigatorUtils.goLogin(context);
        }
        return true;
      });
    });
  }

//  void onViewCreatedFile(LottieController controller) {}

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<BPMSState>(
      builder: (context, store) {
        double size = 200;
        return new Container(
          color: Color(BPMSColors.white),
          child: Stack(
            children: <Widget>[
              new Center(
                child: new Image(
                    image: new AssetImage('assets/images/welcome.png')),
              ),
              new Align(
                alignment: Alignment.bottomCenter,
                child: new Container(
                  width: size,
                  height: size,
                  child: new FlareActor("assets/file/flare_flutter_logo_.flr",
                      alignment: Alignment.topCenter,
                      fit: BoxFit.fill,
                      animation: "Placeholder"),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
