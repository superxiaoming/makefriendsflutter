import 'package:flutter/material.dart';
import 'more.dart';
import 'index.dart';
import 'studyGoal.dart';
import 'login.dart';


class MyHomePageAnother extends StatefulWidget{
  MyHomePageAnother({Key key, this.title}): super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePageAnother>{

  int _selectIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  List<Widget> _widgetOPtions = <Widget>[
    Index(),
    StudyGoal(),
    More()
//    Login()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: _widgetOPtions.elementAt(_selectIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
          BottomNavigationBarItem(icon: Icon(Icons.message), title: Text('学习')),
          BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('更多'))
        ],
        currentIndex: _selectIndex,
        selectedItemColor: Colors.amber[600],
        onTap: _onItemTapped,
      ),
    );
  }
}


