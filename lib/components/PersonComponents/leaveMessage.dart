import 'package:flutter/material.dart';
import 'package:makeriends/api/api.dart';
import 'package:makeriends/components/PersonComponents/message.dart';
import 'package:makeriends/utils/net.dart';
import 'package:makeriends/utils/share.dart';

class LeaveMessage extends StatefulWidget{

  LeaveMessage();

  @override
  _LeaveMessage createState() => _LeaveMessage();
}

class _LeaveMessage extends State<LeaveMessage>{
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
        title: Text('留言板'),
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
      return new Message(message: e);
    }).toList();
  }

  getData() async {
    int createFor = await Share.getIntValue('userId');
    var response = await netUtils.get(Api.BASE_URL + Api.GETLEAVEMESSAGE, {
      'createFor': createFor
    });
    if(mounted){
      setState(() {
        _data = response['data'];
      });
    }
  }
}