import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../utils/net.dart';
import '../../api/api.dart';
import '../../utils/share.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

class AddGoals extends StatefulWidget{

  AddGoals();

  @override
  _AddGoals createState() => _AddGoals();
}

const String MIN_DATETIME = '1997-01-01 00:00:00';
const String MAX_DATETIME = '2099-12-30 23:59:59';

class _AddGoals extends State<AddGoals> {
  TextEditingController content = new TextEditingController();
  int repeatType = 1;
  DateTime _initTime = DateTime.now();

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('新增学习目标'),
        centerTitle: true,
        leading: GestureDetector(
          child: Container(
            child: Text('取消', style: TextStyle(fontSize: 16)),
            alignment: Alignment.center,
          ),
          onTap: (){
            Navigator.pop(context,true);
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
                  child: Text("添加", style: TextStyle(fontSize: 16, color: Colors.blue)),
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
                    hintText: "定下学习内容",
                    border: InputBorder.none //隐藏下划线
                ),
                controller: content,
              ),
              decoration: BoxDecoration(
                // 下滑线浅灰色，宽度1像素
                  border: Border(bottom: BorderSide(color: Colors.grey[200], width: 1.0))
              ),
            ),
            Row(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("每天:"),
                    Radio(
                      value: 1,
                      groupValue: this.repeatType,
                      onChanged: (value) {
                        setState(() {
                          this.repeatType = value;
                        });
                      },
                    ),
                    Text("每周:"),
                    Radio(
                      value: 2,
                      groupValue: this.repeatType,
                      onChanged: (value) {
                        setState(() {
                          this.repeatType = value;
                        });
                      },
                    ),
                    Text("每月:"),
                    Radio(
                      value: 3,
                      groupValue: this.repeatType,
                      onChanged: (value) {
                        setState(() {
                          this.repeatType = value;
                        });
                      },
                    )
                  ],
                )
              ],
            ),
            Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                alignment: Alignment.topLeft,
                child: Row(
                  children: <Widget>[
                    OutlineButton.icon(
                      icon: Icon(Icons.add),
                      label: Text("添加时间"),
                      onPressed: _onPressed,
                    ),
                    Padding(padding: EdgeInsets.only(right: 20)),
                    Text("${_initTime.hour.toString().padLeft(2, '0')}:${_initTime.minute.toString().padLeft(2, '0')}")
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }

  CommitTopic () async {
    int creatorId = await Share.getIntValue('userId');
    FormData formData = FormData.from({
      'creatorId': creatorId,
      'content': content.text,
      'repeatType': repeatType,
      'repeatTime': "${_initTime.hour.toString().padLeft(2, '0')}:${_initTime.minute.toString().padLeft(2, '0')}"
    });
    var response = await netUtils.post(Api.BASE_URL + Api.ADDSTUDYGOAL, formData);
    if(response['code'] == 10000){
      BotToast.showText(text:"添加成功");
      Navigator.pop(context);
    }
  }

  _onPressed(){
    DatePicker.showDatePicker(
        context,
        minDateTime: DateTime.parse(MIN_DATETIME),
        maxDateTime: DateTime.parse(MAX_DATETIME),
        initialDateTime: DateTime.now(),
        pickerMode: DateTimePickerMode.time,
        pickerTheme: DateTimePickerTheme(
          title: Container(
            decoration: BoxDecoration(color: Color(0xFFEFEFEF)),
            width: double.infinity,
            height: 56.0,
            alignment: Alignment.center,
            child: Text(
              '请选择时间',
              style: TextStyle(color: Colors.green, fontSize: 24.0),
            ),
          ),
          titleHeight: 56.0,
        ),
        dateFormat: 'HH:mm',
        locale: DateTimePickerLocale.zh_cn,
        onCancel: (){
          debugPrint("onCancel");
        },
        onChange: (dateTime, List<int> index) {
          setState(() {
            _initTime = dateTime;
          });
        },
        onConfirm: (dateTime, List<int> index) {
          setState(() {
            _initTime = dateTime;
          });
        }
    );
  }
}