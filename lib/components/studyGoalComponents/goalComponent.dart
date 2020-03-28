import 'package:flutter/material.dart';
import '../../utils/net.dart';
import '../../api/api.dart';

class Goal extends StatefulWidget{

  Goal({ Key key, this.goal}): super(key: key);

  final Map goal;

  @override
  _Goal createState() => _Goal();
}

class _Goal extends State<Goal> {
  Map _goal;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this._goal = widget.goal;

    // TODO: implement build
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.circular(100)),
                    clipBehavior: Clip.antiAlias,
                    child: Image.network(_goal['headpic'], width: 50, height: 50),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(_goal['nickname']),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                          margin: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                              color: _goal['sex'] == 0 ? Colors.lightBlueAccent : Colors.pinkAccent,
                              borderRadius: BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            children: <Widget>[
                              _goal['sex'] == 0 ? Image.asset('images/male.png', width: 10, height: 10) : Image.asset('images/female.png', width: 10, height: 10),
                              Padding(padding: EdgeInsets.only(right: 5)),
                              Text(_goal['age'].toString(), style: TextStyle(color: Colors.white))
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
                        IconButton(
                            icon: Icon(Icons.list, size: 35)
                        )
                      ],
                    ),
                  )
                ],
              ),
              Container(
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
                    Text(_repeat(_goal), style: TextStyle(fontSize: 28, color: Colors.white)),
                    Text(_goal['content'], style: TextStyle(fontSize: 24, color: Colors.white))
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  String _repeat(goal) {
    String result;
    switch(goal['repeatType']){
      case 0:
        result = '每天';
        break;
      case 1:
        result = '每周';
        break;
      case 2:
        result = '每月';
        break;
    }
    result += goal['repeatTime'];
    return result;
  }
}