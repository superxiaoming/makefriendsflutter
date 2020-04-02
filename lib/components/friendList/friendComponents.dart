import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:makeriends/components/friendList/chat.dart';
import 'package:makeriends/model/message.dart';
import 'package:makeriends/utils/share.dart';
import '../../utils/net.dart';
import '../../api/api.dart';

class FriendComponent extends StatefulWidget{

  FriendComponent({ Key key, this.map: null}): super(key: key);

  final Map map;

  @override
  _FriendComponent createState() => _FriendComponent();
}

class _FriendComponent extends State<FriendComponent> {

  Map _map = new Map();
  List comments = [];
  bool connection = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getComments();
    getConnection();
  }

  @override
  Widget build(BuildContext context) {
    this._map = widget.map;

    // TODO: implement build
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).pushNamed("views/showUserInfo", arguments: _map['bewatchedId'] == null || _map['bewatchedId'] == '' ? _map['id'] : _map['bewatchedId']);
                  },
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(100)),
                      clipBehavior: Clip.antiAlias,
                      child: _map['headpic'] == null || _map['headpic'] == '' ?
                      Image.asset('images/nan.jpg', width: 50, height: 50) :
                      Image.network(_map['headpic'], width: 50, height: 50)
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(_map['nickname']),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                        margin: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            color: _map['sex'] == 0 ? Colors.lightBlueAccent : Colors.pinkAccent,
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: Row(
                          children: <Widget>[
                            _map['sex'] == 0 ? Image.asset('images/male.png', width: 10, height: 10) : Image.asset('images/female.png', width: 10, height: 10),
                            Padding(padding: EdgeInsets.only(right: 5)),
                            Text(_map['age'].toString(), style: TextStyle(color: Colors.white))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                        onTap: _foucesOnSomeone,
                        child: connection ? Icon(Icons.favorite, color: Colors.red, size: 35) : Icon(Icons.favorite, color: Colors.black, size: 35),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
      onTap: (){
        Message message = new Message();
        message.name = _map['nickname'];
        message.head = _map['headpic'];
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                Chat(message: message),
          ),
        );
      },
    );
  }

  getComments() async {
    var response = await netUtils.get(Api.BASE_URL + Api.GETCOMMENTS, {'topicId': _map['id']});
    if(mounted){
      setState(() {
        comments = response['data'];
      });
    }
  }

  getConnection() async {
    int followerId = await Share.getIntValue('userId');
    var response = await netUtils.get(Api.BASE_URL + Api.GETCONNECTION, {
      'followerId': followerId,
      'beWatchedId': _map['bewatchedId'] == null || _map['bewatchedId'] == '' ? _map['id'] : _map['bewatchedId']
    });
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
        'beWatchedId': _map['bewatchedId'] == null || _map['bewatchedId'] == '' ? _map['id'] : _map['bewatchedId']
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
        'beWatchedId': _map['bewatchedId'] == null || _map['bewatchedId'] == '' ? _map['id'] : _map['bewatchedId']
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