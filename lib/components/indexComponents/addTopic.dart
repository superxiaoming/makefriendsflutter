import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:makeriends/views/index.dart';
import 'package:image_picker/image_picker.dart';
import '../../utils/net.dart';
import '../../api/api.dart';
import '../../utils/share.dart';

class AddTopic extends StatefulWidget{

  AddTopic();

  @override
  _AddTopic createState() => _AddTopic();
}

class _AddTopic extends State<AddTopic> {
  File _image;
  int contentType;
  TextEditingController contents = new TextEditingController();

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
            Navigator.pop(context, contentType);
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
                child: Text("发布", style: TextStyle(fontSize: 16, color: Colors.blue)),
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
                    hintText: "此时此地，想和大家分享什么",
                    border: InputBorder.none //隐藏下划线
                ),
                controller: contents,
              ),
              decoration: BoxDecoration(
                // 下滑线浅灰色，宽度1像素
                  border: Border(bottom: BorderSide(color: Colors.grey[200], width: 1.0))
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(20),
                child: _image == null ?
                Container(
                  child: Text('可以选择图片或者拍照哦'),
                  decoration: BoxDecoration(
                    // 下滑线浅灰色，宽度1像素
                      border: Border(bottom: BorderSide(color: Colors.grey[200], width: 1.0))
                  ),
                ): Image.file(_image, width: 240, height: 200)
              ),
            ),
            Container(
              child: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: RaisedButton.icon(
                      icon: Icon(Icons.picture_in_picture),
                      label: Text("相册"),
                      onPressed: _getImageFromGallery,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: RaisedButton.icon(
                      icon: Icon(Icons.camera_alt),
                      label: Text("拍照"),
                      onPressed: _getImageFromCamera,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  //拍照
  Future _getImageFromCamera() async {
    var image =
    await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 400);
    setState(() {
      _image = image;
    });
  }

  //相册选择
  Future _getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  CommitTopic () async {
    int creatorId = await Share.getIntValue('userId');
    FormData formData = FormData.from({
      'creatorId': creatorId,
      'contents': contents.text,
      'contentType': contentType
    });
    if(_image != null){
      formData.add('pictures', UploadFileInfo(_image, "imageName.png"));
    }
    var response = await netUtils.post(Api.BASE_URL + Api.ADDTOPIC, formData);
    if(response['code'] == 10000){
      BotToast.showText(text:"发布成功");
      Navigator.pop(context, contentType);
    }
  }

  init() {
    Argument args = ModalRoute.of(context).settings.arguments;
    this.contentType = args.contentType;
  }
}