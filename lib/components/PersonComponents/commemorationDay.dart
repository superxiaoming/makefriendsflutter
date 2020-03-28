import 'package:flutter/material.dart';
import 'package:makeriends/api/api.dart';
import 'package:makeriends/components/PersonComponents/memoryDay.dart';
import 'package:makeriends/utils/net.dart';
import 'package:makeriends/utils/share.dart';

class CommemorationDay extends StatefulWidget{

  CommemorationDay();

  @override
  _CommemorationDay createState() => _CommemorationDay();
}

class _CommemorationDay extends State<CommemorationDay>{
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
        title: Text('纪念日'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.chevron_left,size: 40,color: Colors.white),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          GestureDetector(
            child: Container(
                padding: EdgeInsets.only(right: 10),
                alignment: Alignment.center,
                child: Text('添加', style: TextStyle(fontSize: 18, color: Colors.white))
            ),
            onTap: () async {
              Navigator.pushNamed(context, 'views/addMemoryDay').then((returnValue) {
                if(returnValue){
                  getDataWithoutMounted();
                }
              });
            },
          )
        ],
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
                child: Column(
                    children: buildWidget(_data)
                ),
              )
          )
        ],
      )
    );
  }

  List<Widget> buildWidget(List data){
    return data.map((e) {
      return new MemoryDay(memoryDay: e);
    }).toList();
  }

  getData() async {
    int creatorId = await Share.getIntValue('userId');
    var response = await netUtils.get(Api.BASE_URL + Api.GETMEMORYDAY, {
      'creatorId': creatorId
    });
    if(mounted){
      setState(() {
        _data = response['data'];
      });
    }
  }

  getDataWithoutMounted() async {
    int creatorId = await Share.getIntValue('userId');
    var response = await netUtils.get(Api.BASE_URL + Api.GETMEMORYDAY, {
      'creatorId': creatorId
    });
    setState(() {
      _data = response['data'];
    });
  }
}