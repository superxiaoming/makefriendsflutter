import 'package:flutter/material.dart';
import 'package:makeriends/api/api.dart';
import 'package:makeriends/components/studyGoalComponents/goalComponent.dart';
import 'package:makeriends/utils/net.dart';

class StudyGoal extends StatefulWidget {

  StudyGoal();

  @override
  _StudyGoal createState() => _StudyGoal();
}

class _StudyGoal extends State<StudyGoal>{
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
        title: Text('学习目标', style: TextStyle(fontSize: 24)),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: _data == null || _data.length == 0 ? Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text('暂无信息')
            ):Column(
                children: buildWidget(_data)
            )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed("views/addGoals").then((data){
            getData();
            print(_data);
          });
        },
      ),
    );
  }

  List<Widget> buildWidget(List data){
    return data.map((e) {
      return new Goal(goal: e);
    }).toList();
  }

  getData() async {
    var response = await netUtils.get(Api.BASE_URL + Api.GETALLSTUDYGOALS);
    if(mounted){
      setState(() {
        _data = response['data'];
      });
    }
  }
}