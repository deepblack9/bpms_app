import 'package:bpms_app/common/style/bpms_style.dart';
import 'package:flutter/material.dart';

class FunctionPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<FunctionPage> {
  List<String> headerList = [];


  @override
  void initState() {
    headerList.add("1");
    headerList.add("2");
    headerList.add("3");
    headerList.add("4");
    headerList.add("5");
    headerList.add("6");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: new EdgeInsets.only(left: 3.0, right: 3.0),
      child: new ListView.builder(
//        scrollDirection: Axis.horizontal,
        itemCount: headerList.length,
        itemBuilder: (context, index) {
          return new ListTile(
            title: new Text('${headerList[index]}'),
          );
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
