import 'package:flutter/material.dart';
import 'package:makeriends/api/api.dart';
import 'package:makeriends/params/Person.dart';
import 'package:makeriends/utils/net.dart';
import 'package:makeriends/utils/share.dart';
import 'dart:convert';

void main() {
  // 解析对象
  String jsonStr1 = '{"name":"Curry","email":"SC@GSW.com"}';
  Map<String, dynamic> map = json.decode(jsonStr1);
  print(map['name']);

  // 解析列表
  String jsonStr2 = '[{"name":"Curry"},{"name":"Thompson"}]';
  List list = json.decode(jsonStr2);
  // 输出列表第一个对象的"name"属性
  print(list[0]["name"]);
}

class PersonInfo extends StatefulWidget {

  PersonInfo();

  @override
  _PersonInfo createState() => _PersonInfo();
}

class _PersonInfo extends State<PersonInfo>{

  Person data;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    init();

    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          //AppBar，包含一个导航栏
          SliverAppBar(
              pinned: true,
              expandedHeight: 250.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(data.headpic, fit: BoxFit.cover),
              ),
              actions: <Widget>[
                Container(
                    padding: EdgeInsets.only(right: 10),
                    alignment: Alignment.center,
                    child: IconButton(
                      icon: Icon(Icons.edit, color: Colors.white),
                      onPressed: (){
                        Navigator.of(context).pushNamed("views/personInfoEdit", arguments: Person(
                          data.age,
                          data.college,
                          data.headpic,
                          data.major,
                          data.nickname,
                          data.school,
                          data.sex,
                          data.sign,
                          data.tags,
                        )).then((data) {
                          if(data != null){
                            getPersonInfo();
                          }
                        });
                      },
                    )
                ),
              ]
          ),
          SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(data.nickname, style: TextStyle(fontSize: 28, color: Colors.black, fontWeight: FontWeight.bold)),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                          margin: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                              color: data.sex == 0 ? Colors.lightBlueAccent : Colors.pinkAccent,
                              borderRadius: BorderRadius.all(Radius.circular(5))),
                          child: Row(
                            children: <Widget>[
                              data.sex == 0 ? Image.asset('images/male.png', width: 10, height: 10) :
                              Image.asset('images/female.png', width: 10, height: 10),
                              Padding(padding: EdgeInsets.only(right: 5),),
                              Text(data.age == null ? '' : data.age.toString(), style: TextStyle(color: Colors.white))
                            ],
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text('姓名', style: TextStyle(fontSize: 28, color: Colors.black, fontWeight: FontWeight.bold)),
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 15)),
                              Text(data.nickname, style: TextStyle(fontSize: 20))
                            ],
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 15)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text('学校', style: TextStyle(fontSize: 28, color: Colors.black, fontWeight: FontWeight.bold)),
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 15)),
                              Text(data.school, style: TextStyle(fontSize: 20))
                            ],
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 15)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text('学院', style: TextStyle(fontSize: 28, color: Colors.black, fontWeight: FontWeight.bold)),
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 15)),
                              Text(data.college, style: TextStyle(fontSize: 20))
                            ],
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 15)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text('专业', style: TextStyle(fontSize: 28, color: Colors.black, fontWeight: FontWeight.bold)),
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 15)),
                              Text(data.major, style: TextStyle(fontSize: 20))
                            ],
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 15)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text('标签', style: TextStyle(fontSize: 28, color: Colors.black, fontWeight: FontWeight.bold)),
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 15)),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                                margin: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                    color: Colors.lightBlueAccent,
                                    borderRadius: BorderRadius.all(Radius.circular(5))),
                                child: Text(data.tags, style: TextStyle(color: Colors.white, fontSize: 16))
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text('个性签名', style: TextStyle(fontSize: 28, color: Colors.black, fontWeight: FontWeight.bold)),
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 15)),
                              Text(data.sign, style: TextStyle(fontSize: 20))
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
          )
          //List
        ],
      ),
    );
  }

  init() {
    if(count == 0){
      Person args=ModalRoute.of(context).settings.arguments;
      this.data = args;
    }
    this.count += 1;
  }

  getPersonInfo() async {
    int userId = await Share.getIntValue('userId');
    var response = await netUtils.get(Api.BASE_URL + Api.GETUSERINFOBYID, {
      'userId': userId
    });
    if(response['code'] == 10000){
      var resultData = response['data'];
      Person result = new Person(resultData['age'], resultData['college'],
          resultData['headpic'], resultData['major'], resultData['nickname'],
          resultData['school'], resultData['sex'], resultData['sign'], resultData['tags']);
      setState(() {
        data = result;
      });
    }
  }
}