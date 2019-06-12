import 'package:bpms_app/common/style/bpms_style.dart';
import 'package:flutter/material.dart';

class ExaminePage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<ExaminePage> {
  List<String> headerList = [];


  @override
  void initState() {
    headerList.add("企业1");
    headerList.add("企业2");
    headerList.add("企业3");
    headerList.add("企业4");
    headerList.add("企业5");
    headerList.add("企业6");
  }

  @override
  Widget build(BuildContext context) {
    /// 企业信息
    Widget buildComponyRow(String text) {
      return Row(
        children: [
//            new Container(
//              width: 160,
//              alignment: FractionalOffset.center,
//              padding: const EdgeInsets.only(bottom: 8.0),
//              child: new Text(text,
//                style: TextStyle(
////                  inherit: true,
////                  color: Colors.white,
//                  fontSize: 30.0,
////                  fontWeight: FontWeight.w400,
////                  fontStyle: FontStyle.italic,
////                  letterSpacing: 5,
////                  wordSpacing: 20,
////                  textBaseline: TextBaseline.alphabetic,
////                  height: 1.2,
////                  locale: Locale('fr', 'CH'),
////                  background: Paint() ..color = Colors.blue,
////                  shadows: [Shadow(color:Colors.black,offset: Offset(6, 3), blurRadius: 10)],
////                  decoration: TextDecoration.underline,
////                  decorationColor: Colors.black54,
////                  decorationStyle: TextDecorationStyle.dashed,
////                  debugLabel: 'test',
//                ),
//              ),
//            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    child: new Text('企业：晨鑫'),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    child: new Text('仓库：中心仓库'),
                  ),
                ],
              ),
              Row(
                children: <Widget> [
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    child: new Text('类型：入库'),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    child: new Text('状态：出入库完成'),
                  ),
                ],
              ),
              Row(
                children: <Widget> [
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    child: new Text('备注：'),
                  ),
                ],
              ),
              Row(
                children: <Widget> [
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    child: new Text('申请时间：2019-06-12 13:55:37'),
                  ),
                ],
              ),
              Row(
                children: <Widget> [
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    child: new Text('完成时间：2019-06-12 15:13:40'),
                  ),
                ]
              ),
            ],
          ),
        ],
      );
    }

    return Container(
      margin: new EdgeInsets.only(left: 3.0, right: 3.0),
      child: new ListView.builder(
//        scrollDirection: Axis.horizontal,
        itemCount: headerList.length,
        itemBuilder: (context, index) {
          return new Container(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                elevation: 15.0,  //设置阴影
                child: buildComponyRow('${headerList[index]}'),
//                new Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  mainAxisSize: MainAxisSize.min,
//                  children: <Widget>[
//                    buildComponyRow('${headerList[index]}'),
////                    buildWarehouseRow(),
//                  ],
//                ),
              )
          );
//          return new ListTile(
//            title: new Text('${headerList[index]}'),
//          );
//          return new RawMaterialButton(
//            constraints: new BoxConstraints(minWidth: 0.0, minHeight: 0.0),
//            padding: new EdgeInsets.all(4.0),
//            onPressed: () {
////              _resolveHeaderClick(index);
//            },
//            child: new Text(headerList[index] + " > ", style: BPMSConstant.smallText),
//          );
        },
      ),);
  }

//  @override
//  requestRefresh() async {
//    return await _getDataLogic(this.searchText);
//  }
}
