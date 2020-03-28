import 'package:flutter/material.dart';

class MemoryDay extends StatefulWidget{

  MemoryDay({Key key, this.memoryDay});

  final Map memoryDay;

  @override
  _MemoryDay createState() => _MemoryDay();
}

class _MemoryDay extends State<MemoryDay>{
  Map _memoryDay;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _memoryDay = widget.memoryDay;
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
        alignment: Alignment.center, //卡片内文字居中
        child: Column(
          children: <Widget>[
            Text(_memoryDay['memoryDay'], style: TextStyle(fontSize: 28, color: Colors.white)),
            Text(_memoryDay['content'], style: TextStyle(fontSize: 24, color: Colors.white))
          ],
        ),
      ),
    );
  }
}