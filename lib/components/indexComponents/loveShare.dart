import 'package:flutter/material.dart';
import 'package:makeriends/views/index.dart';
import '../../utils/net.dart';
import '../../api/api.dart';
import 'comments.dart';

class LoveShare extends StatefulWidget{

  LoveShare();

  @override
  _LoveShare createState() => _LoveShare();
}

class _LoveShare extends State<LoveShare> {

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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.of(context).pushNamed("views/addTopic", arguments: Argument(1)).then((data){
            getData();
          });
        },
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
    var response = await netUtils.get(Api.BASE_URL + Api.GETTOPICSBYCONTENTTYPE, {'contentType': contentType});
    if(mounted){
      setState(() {
        _data = response['data'];
      });
    }
  }
}
