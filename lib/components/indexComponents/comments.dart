import 'package:flutter/material.dart';
import '../../utils/net.dart';
import '../../api/api.dart';

class Comments extends StatefulWidget{

  Comments({ Key key, this.map: null}): super(key: key);

  final Map map;

  @override
  _Comments createState() => _Comments();
}

class _Comments extends State<Comments> {

  Map _map = new Map();
  List comments = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getComments();
  }

  @override
  Widget build(BuildContext context) {
    this._map = widget.map;

    // TODO: implement build
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  Navigator.of(context).pushNamed("views/showUserInfo", arguments: _map['creatorId']);
                },
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.circular(100)),
                    clipBehavior: Clip.antiAlias,
                    child: _map['headpic'] == null || _map['headpic'] == '' ?
                    Image.asset('images/nan.jpg', width: 50, height: 50) :
                    Image.network(_map['headpic'], width: 50, height: 50)
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(_map['nickname']),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                      margin: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          color: _map['sex'] == 0 ? Colors.lightBlueAccent : Colors.pinkAccent,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Row(
                        children: <Widget>[
                          _map['sex'] == 0 ? Image.asset('images/male.png', width: 10, height: 10) : Image.asset('images/female.png', width: 10, height: 10),
                          Padding(padding: EdgeInsets.only(right: 5)),
                          Text(_map['age'].toString(), style: TextStyle(color: Colors.white))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.list, size: 35)
                    )
                  ],
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Text(_map['contents']),
          ),
          _map['picAddress'] == null || _map['picAddress'] == '' ? Text('') : Image.network(_map['picAddress'], width: 240, height: 200),
          Padding(padding: EdgeInsets.only(top: 10)),
          Row(
            children: <Widget>[
              GestureDetector(
                child: Image.asset('images/z-like.png', width: 25),
                onTap: () async {
                  var response = await netUtils.get(Api.BASE_URL + Api.ADDLIKES, {'topicId': _map['id']});
                  if(mounted){
                    setState(() {
                      _map['likes'] = response['data'];
                    });
                  }
                },
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(_map['likes'].toString()),
              ),
              GestureDetector(
                onTap: () async{
                  Navigator.of(context).pushNamed("views/addComments", arguments: Arguments(_map, comments)).then((data) {
                    if(data == 1){
                      getComments();
                    }
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Image.asset('images/pinglun.png', width: 25),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(comments.length.toString()),
              ),
            ],
          )
        ],
      ),
    );
  }

  getComments() async {
    var response = await netUtils.get(Api.BASE_URL + Api.GETCOMMENTS, {'topicId': _map['id']});
    if(mounted){
      setState(() {
        comments = response['data'];
      });
    }
  }
}

class Arguments {

  Map topic;
  List comments;

  Arguments(Map topic, List comments){
    this.topic = topic;
    this.comments = comments;
  }

}