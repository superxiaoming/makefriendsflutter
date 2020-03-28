import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../utils/net.dart';
import '../../api/api.dart';
import '../../utils/share.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

class AddMemoryday extends StatefulWidget{

  AddMemoryday();

  @override
  _AddMemoryday createState() => _AddMemoryday();
}

class _AddMemoryday extends State<AddMemoryday> {
  TextEditingController content = new TextEditingController();
  String _initTime;

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('添加纪念日'),
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
                    hintText: "在纪念日里，做了什么值得留恋的事",
                    border: InputBorder.none //隐藏下划线
                ),
                controller: content,
              ),
              decoration: BoxDecoration(
                // 下滑线浅灰色，宽度1像素
                  border: Border(bottom: BorderSide(color: Colors.grey[200], width: 1.0))
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                alignment: Alignment.topLeft,
                child: Row(
                  children: <Widget>[
                    OutlineButton.icon(
                      icon: Icon(Icons.add),
                      label: Text("添加日期"),
                      onPressed: _onPressed,
                    ),
                    Padding(padding: EdgeInsets.only(right: 20)),
                    Text(_initTime == null ? '请添加日期' : _initTime)
                  ],
                )
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
      'content': content.text,
      'memoryDay': _initTime
    });
    var response = await netUtils.post(Api.BASE_URL + Api.ADDDAYS, formData);
    if(response['code'] == 10000){
      BotToast.showText(text:"添加成功");
      Navigator.pop(context, true);
    }
  }

  _onPressed(){
    DatePicker.showDatePicker(
        context,
        pickerTheme: DateTimePickerTheme(
          showTitle: true,
          confirm: Text('确定',style:TextStyle(color:Colors.red)),
          cancel: Text('取消',style: TextStyle(color: Colors.cyan)),
        ),
        minDateTime: DateTime(1990, 1),
        maxDateTime: DateTime(2099, 1),
        initialDateTime: DateTime.now(),
        dateFormat: 'yyyy-MMMM-dd',
        locale: DateTimePickerLocale.zh_cn,
        onCancel: (){
          debugPrint("onCancel");
        },
        onConfirm: (dateTime,List<int> index){
          setState(() {
            _initTime = dateTime.year.toString() + '-' + dateTime.month.toString() + '-' + dateTime.day.toString();
          });
        }
    );
  }
}