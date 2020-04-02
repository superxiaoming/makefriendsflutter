import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:makeriends/api/api.dart';
import 'package:makeriends/utils/net.dart';
import 'package:makeriends/utils/share.dart';

class ShowPersonInfo extends StatefulWidget {

  ShowPersonInfo();

  @override
  _ShowPersonInfo createState() => _ShowPersonInfo();
}

class _ShowPersonInfo extends State<ShowPersonInfo>{

  var userId;
  var personInfo;
  int count = 0;
  bool connection = false;

  @override
  Widget build(BuildContext context) {
    init();

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          //AppBar，包含一个导航栏
          SliverAppBar(
              pinned: true,
              expandedHeight: 250.0,
              flexibleSpace: FlexibleSpaceBar(
                background: personInfo == null ? null : Image.network(personInfo['headpic'], fit: BoxFit.cover),
              ),
              actions: <Widget>[
                Container(
                    padding: EdgeInsets.only(right: 10),
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).pushNamed("views/addMessage", arguments: personInfo['id']);
                      },
                      child: Text('写留言', style: TextStyle(fontSize: 18)),
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
                      child: Text(personInfo == null ? '' : personInfo['nickname'], style: TextStyle(fontSize: 28, color: Colors.black, fontWeight: FontWeight.bold)),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                          margin: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                              color: (personInfo == null ? true : personInfo['sex'] == 0) ? Colors.lightBlueAccent : Colors.pinkAccent,
                              borderRadius: BorderRadius.all(Radius.circular(5))),
                          child: Row(
                            children: <Widget>[
                              (personInfo == null ? true : personInfo['sex'] == 0) ? Image.asset('images/male.png', width: 10, height: 10) :
                              Image.asset('images/female.png', width: 10, height: 10),
                              Padding(padding: EdgeInsets.only(right: 5),),
                              Text(personInfo == null ? '' : personInfo['age'].toString(), style: TextStyle(color: Colors.white))
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
                                Text(personInfo == null ? '' : personInfo['nickname'], style: TextStyle(fontSize: 20))
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
                              Text(personInfo == null ? '' : personInfo['school'], style: TextStyle(fontSize: 20))
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
                              Text(personInfo == null ? '' : personInfo['college'], style: TextStyle(fontSize: 20))
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
                              Text(personInfo == null ? '' : personInfo['major'], style: TextStyle(fontSize: 20))
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
                                  child: Text(personInfo == null ? '' : personInfo['tags'], style: TextStyle(color: Colors.white, fontSize: 16))
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
                              Text(personInfo == null ? '' : personInfo['sign'], style: TextStyle(fontSize: 20))
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
      floatingActionButton: FloatingActionButton(
        child: connection ? Icon(Icons.favorite, color: Colors.red, size: 35) : Icon(Icons.favorite, color: Colors.black, size: 35),
        onPressed: _foucesOnSomeone,
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  init() {
    if(count == 0){
      var args = ModalRoute.of(context).settings.arguments;
      this.userId = args;
      getPersonInfo();
      getConnection();
    }
    this.count += 1;
  }

  getPersonInfo() async {
    var response = await netUtils.get(Api.BASE_URL + Api.GETUSERINFOBYID, {
      'userId': userId
    });
    if(response['code'] == 10000){
      var resultData = response['data'];
      setState(() {
        personInfo = resultData;
      });
    } else {
      BotToast.showText(text:"获取用户信息失败");
    }
  }

  getConnection() async {
    int followerId = await Share.getIntValue('userId');
    var response = await netUtils.get(Api.BASE_URL + Api.GETCONNECTION, {
      'followerId': followerId,
      'beWatchedId': userId
    });
    print(followerId);
    print(userId);
    if(response['code'] == 10000){
      var resultData = response['data'];
      setState(() {
        connection = resultData;
      });
    } else {
      BotToast.showText(text:"获取关注信息失败");
    }
  }

  _foucesOnSomeone() async {
    int followerId = await Share.getIntValue('userId');
    if(!connection){
      var response = await netUtils.get(Api.BASE_URL + Api.FOCUSON, {
        'followerId': followerId,
        'beWatchedId': userId
      });
      if(response['code'] == 10000){
        BotToast.showText(text:"关注成功");
        setState(() {
          connection = true;
        });
      } else {
        BotToast.showText(text:"关注失败");
      }
    } else {
      var response = await netUtils.get(Api.BASE_URL + Api.DELETECONNECTION, {
        'followerId': followerId,
        'beWatchedId': userId
      });
      if(response['code'] == 10000){
        setState(() {
          connection = false;
        });
        BotToast.showText(text:"取消关注成功");
      } else {
        BotToast.showText(text:"取消关注失败");
      }
    }
  }
}