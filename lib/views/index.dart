import 'package:flutter/material.dart';
import '../components/indexComponents/loveDoubts.dart';
import '../components/indexComponents/loveShare.dart';
import '../components/indexComponents/coupleActivity.dart';
import '../utils/net.dart';
import '../api/api.dart';

class Index extends StatefulWidget {

  Index();

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> with SingleTickerProviderStateMixin{

  TabController tabController;
  List tabs = ['恋爱疑惑', '甜蜜分享', '情侣活动'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('附近动态', style: TextStyle(fontSize: 24)),
        bottom: TabBar(   //生成Tab菜单
            controller: tabController,
            tabs: tabs.map((e) => Tab(text: e)).toList()
        )
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: LoveDoubts(),
          ),
          Container(
            alignment: Alignment.center,
            child: LoveShare(),
          ),
          Container(
            alignment: Alignment.center,
            child: CoupleActivity(),
          )
        ],
      ),
    );
  }

}

class Argument {
  int contentType;

  Argument(int contentType){
    this.contentType = contentType;
  }
}