import 'package:flutter/material.dart';

class EditInfo extends StatefulWidget{

  EditInfo();

  @override
  _EditInfo createState() => _EditInfo();
}

class _EditInfo extends State<EditInfo>{
  TextEditingController editData = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    init();

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('编辑'),
        leading: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.chevron_left,size: 40,color: Colors.white),
              onPressed: (){
                Navigator.pop(context);
              },
            )
          ]
        ),
        actions: <Widget>[
          Container(
              padding: EdgeInsets.only(right: 10),
              alignment: Alignment.center,
              child: FlatButton(
                color: Colors.white,
                highlightColor: Colors.white70,
                colorBrightness: Brightness.dark,
                splashColor: Colors.blue,
                child: Text("确定", style: TextStyle(fontSize: 14, color: Colors.blue)),
                shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                onPressed: () async {
                  Navigator.pop(context, editData.text);
                },
              )
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            maxLines: 2,
            decoration: InputDecoration(
                hintText: "请输入",
                border: InputBorder.none //隐藏下划线
            ),
            controller: editData,
          ),
          decoration: BoxDecoration(
            // 下滑线浅灰色，宽度1像素
              border: Border(bottom: BorderSide(color: Colors.grey[200], width: 1.0))
          ),
        ),
      )
    );
  }

  init() {
    var args=ModalRoute.of(context).settings.arguments;
    this.editData.text = args;
  }
}