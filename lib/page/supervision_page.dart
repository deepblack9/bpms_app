import 'package:bpms_app/common/style/bpms_style.dart';
import 'package:flutter/material.dart';

class SupervisionPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<SupervisionPage> {
  List<String> headerList = ["."];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: new EdgeInsets.only(left: 3.0, right: 3.0),
      child: new ListView.builder(
//        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return new RawMaterialButton(
            constraints: new BoxConstraints(minWidth: 0.0, minHeight: 0.0),
            padding: new EdgeInsets.all(4.0),
            onPressed: () {
//              _resolveHeaderClick(index);
            },
            child: new Text(headerList[index] + " > ", style: BPMSConstant.smallText),
          );
        },
//        itemCount: headerList.length,
      ),);
  }


//  @override
//  requestRefresh() async {
//    return await _getDataLogic(this.searchText);
//  }
}
