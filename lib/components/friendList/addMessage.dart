import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../utils/net.dart';
import '../../api/api.dart';
import '../../utils/share.dart';

class AddMessage extends StatefulWidget{

  AddMessage();

  @override
  _AddMessage createState() => _AddMessage();
}

class _AddMessage extends State<AddMessage> {
  TextEditingController contents = new TextEditingController();
  int userId;

  @override
  Widget build(BuildContext context) {
    init();

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('发布动态'),
        centerTitle: true,
        leading: GestureDetector(
          child: Container(
            child: Text('取消', style: TextStyle(fontSize: 16)),
            alignment: Alignment.center,
          ),
          onTap: (){
            Navigator.pop(context);
          },
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
                  child: Text("留言", style: TextStyle(fontSize: 16, color: Colors.blue)),
                  shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                  onPressed: CommitTopic
              )
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Container(
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "想对他/她说点什么",
                  border: InputBorder.none //隐藏下划线
                ),
                controller: contents,
              ),
              decoration: BoxDecoration(
                // 下滑线浅灰色，宽度1像素
                border: Border(bottom: BorderSide(color: Colors.grey[200], width: 1.0))
              ),
            )
          ],
        ),
      ),
    );
  }

  CommitTopic () async {
    int creatorId = await Share.getIntValue('userId');
    FormData formData = FormData.from({
      'creatorId': creatorId,
      'content': contents.text,
      'createFor': userId
    });
    var response = await netUtils.post(Api.BASE_URL + Api.ADDLEAVEMESSAGE, formData);
    if(response['code'] == 10000){
      BotToast.showText(text:"留言成功");
      Navigator.pop(context);
    }
  }

  init() {
    int args = ModalRoute.of(context).settings.arguments;
    this.userId = args;
  }
}