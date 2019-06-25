import 'package:flutter/material.dart';

class BaiduMap extends StatefulWidget {
  @override
  _BaiduMapState createState() => _BaiduMapState();
}

class _BaiduMapState extends State<BaiduMap> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: new EdgeInsets.only(left: 3.0, right: 3.0),
      child: new AndroidView(viewType: 'BaiduMap'),
    );
  }
}
