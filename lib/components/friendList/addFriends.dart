import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../utils/net.dart';
import '../../api/api.dart';
import 'friendComponents.dart';

class AddFriends extends StatefulWidget{

  AddFriends();

  @override
  _AddFriends createState() => _AddFriends();
}

class _AddFriends extends State<AddFriends> {
  TextEditingController contents = new TextEditingController();
  int userId;
  List _data;

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Container(
            child: Icon(Icons.chevron_left,size: 40,color: Colors.white),
            alignment: Alignment.center,
          ),
          onTap: (){
            Navigator.pop(context, true);
          },
        ),
        title: Container(
          decoration: new BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1.0), //灰色的一层边框
            color: Colors.white,
            borderRadius: new BorderRadius.all(new Radius.circular(15.0)),
          ),
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: 20),
          height: 36,
          padding: EdgeInsets.only(left: 20),
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person),
              hintText: "please input nickname",
              border: InputBorder.none
            ),
            controller: contents,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          new Center(
            child: IconButton(
              icon: Icon(Icons.search, size: 36, color: Colors.white),
              onPressed: _getUsersByNickname,
            )
          )
        ],
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
              child: Padding(
                  padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
                  child: _data == null || _data.length == 0 ? Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text('暂无搜索好友')
                  ):
                  Column(
                      children: buildWidget(_data)
                  )
              )
          )
        ],
      ),
    );
  }

  List<Widget> buildWidget(List data){
    return data.map((e) {
      return new FriendComponent(map: e);
    }).toList();
  }

  _getUsersByNickname () async {
    FormData formData = FormData.from({
      'nickname': contents.text,
    });
    var response = await netUtils.post(Api.BASE_URL + Api.GETUSERSBYNICKNAME, formData);
    if(response['code'] == 10000){
      setState(() {
        _data = response['data'];
      });
    }
  }
}
