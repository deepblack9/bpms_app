import 'package:flutter/material.dart';

/**
 * title 控件
 * Created by guoshuyu
 * on 2018/7/24.
 */
class BPMSTitleBar extends StatelessWidget {
  final String title;

  final List<Widget> children;

  final IconData iconData;

  final VoidCallback onPressed;

  final bool needRightLocalIcon;

  final Widget rightWidget;

  final bool needPopMenu;

  BPMSTitleBar(this.title, {this.children, this.iconData, this.onPressed, this.needRightLocalIcon = false, this.needPopMenu = false, this.rightWidget});

  @override
  Widget build(BuildContext context) {
    List<Widget> actionWidget = new List();
    actionWidget.add(
        new Expanded(
          child: new Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        )
    );
    if (children != null && children.length != 0) {
      actionWidget.addAll(children);
    }
    Widget widget = rightWidget;
    if (rightWidget == null) {
      widget = (needRightLocalIcon)
          ? new IconButton(
              icon: new Icon(
                iconData,
                size: 19.0,
              ),
              onPressed: onPressed)
          : new Container();
    }
    return Container(
      child: new Row(
        children: actionWidget,
//        children: <Widget>[
//          new Expanded(
//            child: new Text(
//              title,
//              maxLines: 1,
//              overflow: TextOverflow.ellipsis,
//            ),
//          ),
//          widget
//        ],
      ),
    );
  }
}
