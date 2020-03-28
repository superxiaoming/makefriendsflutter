import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:makeriends/api/api.dart';
import 'package:makeriends/params/Person.dart';
import 'package:image_picker/image_picker.dart';
import 'package:makeriends/utils/net.dart';
import 'package:makeriends/utils/share.dart';

class PersonInfoEdit extends StatefulWidget{

  PersonInfoEdit();

  @override
  _PersonInfoState createState() => _PersonInfoState();
}

class _PersonInfoState extends State<PersonInfoEdit>{
  Person data;
  File _image;

  @override
  Widget build(BuildContext context) {
    init();

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('编辑资料'),
        centerTitle: true,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Container(
            padding: EdgeInsets.only(left: 15),
            alignment: Alignment.center,
            child: Text('取消', style: TextStyle(fontSize: 18, color: Colors.white))
          ),
        ),
        actions: <Widget>[
          GestureDetector(
            child: Container(
                padding: EdgeInsets.only(right: 10),
                alignment: Alignment.center,
                child: FlatButton(
                  color: Colors.blue,
                  highlightColor: Colors.blue[700],
                  colorBrightness: Brightness.dark,
                  splashColor: Colors.grey,
                  child: Text("保存", style: TextStyle(fontSize: 18)),
                  shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                  onPressed: _commitPersonInfo,
                )
            ),
          )
        ]
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25,vertical: 15),
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: _getImageFromGallery,
                    child: Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Container(
                            alignment: Alignment.centerLeft,
                            child: Text('头像', style: TextStyle(fontSize: 20))
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              _image == null ? Image.network( data.headpic, width: 50, height: 50) : Image.file(_image, width: 50, height: 50),
                              Icon(Icons.chevron_right,size: 30,color: Colors.grey)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(bottom: 15)
                  ),
                  GestureDetector(
                    child: Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Container(
                            alignment: Alignment.centerLeft,
                            child: Text('姓名', style: TextStyle(fontSize: 20))
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerRight,
                                width: 200,
                                child: Text(data.nickname, style: TextStyle(fontSize: 20), overflow: TextOverflow.ellipsis),
                              ),
                              Icon(Icons.chevron_right,size: 30,color: Colors.grey)
                            ],
                          ),
                        )
                      ],
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed("views/editInfo", arguments: data.nickname).then((res) {
                        if(res != null){
                          data.nickname = res;
                        }
                      });
                    },
                  ),
                  Padding(
                      padding: EdgeInsets.only(bottom: 15)
                  ),
                  GestureDetector(
                    child: Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Container(
                            alignment: Alignment.centerLeft,
                            child: Text('年龄', style: TextStyle(fontSize: 20))
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerRight,
                                width: 200,
                                child: Text(data.age.toString(), style: TextStyle(fontSize: 20), overflow: TextOverflow.ellipsis),
                              ),
                              Icon(Icons.chevron_right,size: 30,color: Colors.grey)
                            ],
                          ),
                        )
                      ],
                    ),
                    onTap: (){
                      Navigator.of(context).pushNamed("views/editInfo", arguments: data.age.toString()).then((res) {
                        if(res != null){
                          data.age = int.parse(res);
                        }
                      });
                    },
                  ),
                  Padding(
                      padding: EdgeInsets.only(bottom: 15)
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Container(
                          alignment: Alignment.centerLeft,
                          child: Text('性别', style: TextStyle(fontSize: 20))
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text("男"),
                            Radio(
                              value: 0,
                              groupValue: data.sex,
                              onChanged: (value) {
                                setState(() {
                                  data.sex = value;
                                });
                              },
                            ),
                            Text("女"),
                            Radio(
                              value: 1,
                              groupValue: data.sex,
                              onChanged: (value) {
                                setState(() {
                                  data.sex = value;
                                });
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.only(bottom: 15)
                  ),
                  GestureDetector(
                    child: Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Container(
                            alignment: Alignment.centerLeft,
                            child: Text('学校', style: TextStyle(fontSize: 20))
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerRight,
                                width: 200,
                                child: Text(data.school, style: TextStyle(fontSize: 20), overflow: TextOverflow.ellipsis),
                              ),
                              Icon(Icons.chevron_right,size: 30,color: Colors.grey)
                            ],
                          ),
                        )
                      ],
                    ),
                    onTap: (){
                      Navigator.of(context).pushNamed("views/editInfo", arguments: data.school).then((res) {
                        if(res != null){
                          data.school = res;
                        }
                      });
                    },
                  ),
                  Padding(
                      padding: EdgeInsets.only(bottom: 15)
                  ),
                  GestureDetector(
                    child: Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Container(
                            alignment: Alignment.centerLeft,
                            child: Text('学院', style: TextStyle(fontSize: 20))
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerRight,
                                width: 200,
                                child: Text(data.college, style: TextStyle(fontSize: 20), overflow: TextOverflow.ellipsis),
                              ),
                              Icon(Icons.chevron_right,size: 30,color: Colors.grey)
                            ],
                          ),
                        )
                      ],
                    ),
                    onTap: (){
                      Navigator.of(context).pushNamed("views/editInfo", arguments: data.college).then((res) {
                        if(res != null){
                          data.college = res;
                        }
                      });
                    },
                  ),
                  Padding(
                      padding: EdgeInsets.only(bottom: 15)
                  ),
                  GestureDetector(
                    child: Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text('专业', style: TextStyle(fontSize: 20)),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerRight,
                                width: 200,
                                child: Text(data.major, style: TextStyle(fontSize: 20), overflow: TextOverflow.ellipsis),
                              ),
                              Icon(Icons.chevron_right,size: 30,color: Colors.grey)
                            ],
                          ),
                        )
                      ],
                    ),
                    onTap: (){
                      Navigator.of(context).pushNamed("views/editInfo", arguments: data.major).then((res) {
                        if(res != null){
                          data.major = res;
                        }
                      });
                    },
                  ),
                  Padding(
                      padding: EdgeInsets.only(bottom: 15)
                  ),
                  GestureDetector(
                    child: Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Container(
                            alignment: Alignment.centerLeft,
                            child: Text('标签', style: TextStyle(fontSize: 20))
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                                margin: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                    color: Colors.lightBlueAccent,
                                    borderRadius: BorderRadius.all(Radius.circular(5))),
                                child: Row(
                                  children: <Widget>[
                                    Text(data.tags, style: TextStyle(color: Colors.white, fontSize: 16))
                                  ],
                                ),
                              ),
                              Icon(Icons.chevron_right,size: 30,color: Colors.grey)
                            ],
                          ),
                        )
                      ],
                    ),
                    onTap: (){
                      Navigator.of(context).pushNamed("views/editInfo", arguments: data.tags).then((res) {
                        if(res != null){
                          data.tags = res;
                        }
                      });
                    },
                  ),
                  Padding(
                      padding: EdgeInsets.only(bottom: 15)
                  ),
                  GestureDetector(
                    child: Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Container(
                            width: 100,
                            alignment: Alignment.centerLeft,
                            child: Text('个性签名', style: TextStyle(fontSize: 20))
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                width: 200,
                                child: Text(data.sign, style: TextStyle(fontSize: 20), overflow: TextOverflow.ellipsis),
                              ),
                              Icon(Icons.chevron_right,size: 30,color: Colors.grey)
                            ],
                          ),
                        )
                      ],
                    ),
                    onTap: (){
                      Navigator.of(context).pushNamed("views/editInfo", arguments: data.sign).then((res) {
                        if(res != null){
                          data.sign = res;
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      )
    );
  }

  //相册选择
  Future _getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  init() {
    Person args=ModalRoute.of(context).settings.arguments;
    this.data = args;
  }

  _commitPersonInfo () async {
    int userId = await Share.getIntValue('userId');
    FormData formData = FormData.from({
      'userId': userId,
      'nickname': data.nickname,
      'school': data.school,
      'age': data.age,
      'college': data.college,
      'major': data.major,
      'tags': data.tags,
      'sign': data.sign,
      'sex': data.sex
    });
    if(_image != null){
      formData.add('headPic', UploadFileInfo(_image, "imageName.png"));
    }
    var response = await netUtils.post(Api.BASE_URL + Api.EDITUSERINFO, formData);
    if(response['code'] == 10000){
      BotToast.showText(text:"编辑成功");
      Navigator.pop(context, true);
    }
  }
}