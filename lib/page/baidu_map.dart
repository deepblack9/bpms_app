import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BaiduMap extends StatefulWidget {
  static final String sName = "baidumap";
  @override
  _BaiduMapState createState() => _BaiduMapState();
}

class _BaiduMapState extends State<BaiduMap> {
  static const platform = const MethodChannel("baidumap.flutter.io/draw");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("百度地图"),
          actions: <Widget>[
            new IconButton( // action button
              icon: new Icon(Icons.undo),
              onPressed: () async {
                final int result = await platform.invokeMethod('undo');
              },
            ),
            new IconButton( // action button
              icon: new Icon(Icons.save),
              onPressed: () async {
                final String result = await platform.invokeMethod('save');
              },
            ),
          ],
        ),
        body: Center(child: new AndroidView(viewType: 'BaiduMap'))
    );
    return Container(
      margin: new EdgeInsets.only(left: 3.0, right: 3.0),
      child: new AndroidView(viewType: 'BaiduMap'),
    );
  }
}
