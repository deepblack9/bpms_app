import 'package:bpms_app/common/style/bpms_style.dart';
import 'package:flutter/material.dart';

class SupervisionPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<SupervisionPage> {
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
      return Container(
        padding: const EdgeInsets.all(5.0),
        child:  Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 160,
              alignment: FractionalOffset.center,
              padding: const EdgeInsets.only(bottom: 8.0),
              child: new Text(text,
                style: TextStyle(
//                  inherit: true,
//                  color: Colors.white,
                  fontSize: 30.0,
//                  fontWeight: FontWeight.w400,
//                  fontStyle: FontStyle.italic,
//                  letterSpacing: 5,
//                  wordSpacing: 20,
//                  textBaseline: TextBaseline.alphabetic,
//                  height: 1.2,
//                  locale: Locale('fr', 'CH'),
//                  background: Paint() ..color = Colors.blue,
//                  shadows: [Shadow(color:Colors.black,offset: Offset(6, 3), blurRadius: 10)],
//                  decoration: TextDecoration.underline,
//                  decorationColor: Colors.black54,
//                  decorationStyle: TextDecorationStyle.dashed,
//                  debugLabel: 'test',
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(bottom: 8.0),
                child: new Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Text('融资金额1200万元'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Text('当前货值评估948万元'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    /// 仓库信息
    Widget buildWarehouseRow() {
      return new ListView.builder(
        shrinkWrap: true,
        itemCount: 1,
        itemBuilder: (context, index) {
          return new Container(
            padding: const EdgeInsets.all(5.0),
            child: new Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: new Container(
                    alignment: FractionalOffset.center,
                    padding: const EdgeInsets.all(8.0),
                    child: new Text("中心仓库"),
                  ),
                ),
                Expanded(
                  child: new Container(
                    alignment: FractionalOffset.center,
                    padding: const EdgeInsets.all(8.0),
                    child: new Text("估值948万元"),
                  ),
                ),
              ],
            )
          );
        },
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
              child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    buildComponyRow('${headerList[index]}'),
                    Divider(
                      color: Colors.grey,
                      height: 5.0,
                      //左边缩进
                      // indent: 32.0,
                    ),
                    buildWarehouseRow(),
                  ],
                ),
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
