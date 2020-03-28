import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:makeriends/api/api.dart';
import 'package:makeriends/components/studyGoalComponents/goalComponent.dart';
import 'package:makeriends/utils/net.dart';
import 'package:makeriends/utils/share.dart';

class MyStudyGoal extends StatefulWidget{

  MyStudyGoal();

  @override
  _MyStudyGoal createState() => _MyStudyGoal();
}

class _MyStudyGoal extends State<MyStudyGoal> {
  List _data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
            title: Text('我的学习目标'),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.chevron_left,size: 40,color: Colors.white),
              onPressed: (){
                Navigator.pop(context);
              },
            )
        ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: _data == null || _data.length == 0 ? Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text('暂无消息')
            ):Column(
                children: buildWidget(_data)
            )
          )
        ],
      )
    );
  }

  List<Widget> buildWidget(List data){
    return data.map((e) {
      return new Goal(goal: e);
    }).toList();
  }

  getData() async {
    int creatorId = await Share.getIntValue('userId');
    var response = await netUtils.get(Api.BASE_URL + Api.GETSTUDYGOALSBYCREATORID, {
      'creatorId': creatorId
    });
    if(mounted){
      setState(() {
        _data = response['data'];
      });
    }
  }
}