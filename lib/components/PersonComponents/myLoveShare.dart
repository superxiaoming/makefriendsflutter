import 'package:flutter/material.dart';
import 'package:makeriends/api/api.dart';
import 'package:makeriends/components/indexComponents/comments.dart';
import 'package:makeriends/utils/net.dart';
import 'package:makeriends/utils/share.dart';
import 'package:makeriends/views/index.dart';

class MyLoveShare extends StatefulWidget{

  MyLoveShare();

  @override
  _MyLoveShare createState() => _MyLoveShare();
}

class _MyLoveShare extends State<MyLoveShare> {

  List _data = new List();

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
            title: Text('我的甜蜜分享'),
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
              child: Padding(
                padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
                child: _data == null || _data.length == 0 ? Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text('暂无动态')
                ):Column(
                    children: buildWidget(_data)
                )
              )
          ),
        ],
      ),
    );
  }

  List<Widget> buildWidget(List data){
    return data.map((e) {
      return new Comments(map: e);
    }).toList();
  }

  getData() async {
    int contentType = 1;
    int creatorId = await Share.getIntValue('userId');
    var response = await netUtils.get(Api.BASE_URL + Api.GETTOPICSBYCONTENTTYPEANDCREATORID, {
      'contentType': contentType,
      'creatorId': creatorId
    });
    if(mounted){
      setState(() {
        _data = response['data'];
      });
    }
  }
}