import 'package:flutter/material.dart';

class Message extends StatefulWidget{

  Message({Key key, this.message});

  final Map message;

  @override
  _Message createState() => _Message();
}

class _Message extends State<Message>{
  Map _message;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _message = widget.message;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.all(15),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(//背景装饰
            gradient: RadialGradient( //背景径向渐变
                colors: [Colors.blue, Colors.lightBlueAccent],
                center: Alignment.topLeft,
                radius: .98
            ),
            boxShadow: [ //卡片阴影
              BoxShadow(
                  color: Colors.black54,
                  offset: Offset(2.0, 2.0),
                  blurRadius: 4.0
              )
            ]
        ),
        alignment: Alignment.centerLeft, //卡片内文字居中
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.person_outline, size: 28, color: Colors.white),
                Text('匿名用户', style: TextStyle(fontSize: 22, color: Colors.white))
              ],
            ),
            Text(_message['content'], style: TextStyle(fontSize: 20, color: Colors.white)),
            Text(_message['createTime'], style: TextStyle(fontSize: 20, color: Colors.white))
          ],
        ),
      ),
    );
  }
}