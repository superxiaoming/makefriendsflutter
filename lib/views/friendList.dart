import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:makeriends/components/friendList/friendComponents.dart';
import '../utils/net.dart';
import '../api/api.dart';
import '../utils/share.dart';

class FriendList extends StatefulWidget{

  FriendList();

  @override
  _FriendList createState() => _FriendList();
}

class _FriendList extends State<FriendList>{
  List _data;

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
            title: Text('好友列表'),
            centerTitle: true
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
                    child: _data == null || _data.length == 0 ? Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text('暂无关注好友')
                    ):
                    Column(
                        children: buildWidget(_data)
                    )
                )
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
            Navigator.pushNamed(context, 'views/addFriends').then((data){
              getData();
            });
          },
        ),
    );
  }

  List<Widget> buildWidget(List data){
    return data.map((e) {
      return new FriendComponent(map: e);
    }).toList();
  }

  getData() async {
    int followerId = await Share.getIntValue('userId');
    var response = await netUtils.get(Api.BASE_URL + Api.GETBEWATCHEDUSERINFO, {'followerId': followerId});
    if(mounted){
      setState(() {
        _data = response['data'];
      });
    }
  }
}
