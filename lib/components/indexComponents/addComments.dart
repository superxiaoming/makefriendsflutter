import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:makeriends/components/indexComponents/comments.dart';
import '../../utils/net.dart';
import '../../api/api.dart';
import '../../utils/share.dart';

class AddComments extends StatefulWidget{

  AddComments();

  @override
  _AddComments createState() => _AddComments();
}

class _AddComments extends State<AddComments> {

  Map _topic = new Map();
  List _comments = [];
  int count = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    init();

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: <Widget>[
            Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.circular(100)),
                clipBehavior: Clip.antiAlias,
                child: Image.network(_topic['headpic'], width: 40, height: 40)
            )
          ],
        ),
        leading: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.chevron_left,size: 40,color: Colors.white),
              onPressed: (){
                Navigator.pop(context, 1);
              },
            )
          ]
        ),
        actions: <Widget>[
          Container(
              padding: EdgeInsets.only(right: 10),
              alignment: Alignment.center,
              child: FlatButton(
                color: Colors.white,
                highlightColor: Colors.white70,
                colorBrightness: Brightness.dark,
                splashColor: Colors.blue,
                child: Text("评论", style: TextStyle(fontSize: 14, color: Colors.blue)),
                shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                onPressed: () async {
                  int type = await _showModalBottomSheet(_topic['id']);
                  if(type == 1){
                    this.count += 1;
                    await getComments();
                  }
                },
              )
          ),
        ],
      ),
      body: Material(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Flex(
                          direction: Axis.horizontal,
                          children: <Widget>[
                            Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadiusDirectional.circular(100)),
                                clipBehavior: Clip.antiAlias,
                                child: Image.network(_topic['headpic'], width: 50, height: 50)
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(_topic['nickname']),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    decoration: BoxDecoration(
                                        color: _topic['sex'] == 0 ? Colors.lightBlueAccent : Colors.pinkAccent,
                                        borderRadius: BorderRadius.all(Radius.circular(10))),
                                    child: Row(
                                      children: <Widget>[
                                        _topic['sex'] == 0 ? Image.asset('images/male.png', width: 10, height: 10) : Image.asset('images/female.png', width: 10, height: 10),
                                        Padding(padding: EdgeInsets.only(right: 5)),
                                        Text(_topic['age'].toString(), style: TextStyle(color: Colors.white))
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
                          child: Text(_topic['contents']),
                        ),
                        _topic['picAddress'] == null || _topic['picAddress'] == '' ? Text('') : Image.network(_topic['picAddress'], width: 240, height: 200),
                      ],
                    ),
                  ),
                  LineWidget(),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text("最新评论", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Column(
                    children: buildWidget(_comments),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildWidget(List comments) {
    return comments.map((e) {
      return Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Flex(
          direction: Axis.horizontal,
          children: <Widget>[
            Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.circular(100)),
                clipBehavior: Clip.antiAlias,
                child: Image.network(e['headpic'], width: 35, height: 35)
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(e['nickname']),
                  Text(e['comment'])
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
      );
    }).toList();
  }

  // 弹出底部菜单列表模态对话框
  Future<int> _showModalBottomSheet(int topicId) {
    return showModalBottomSheet<int>(
      context: context,
      builder: (BuildContext context) {
        return CommitComment(topicId: topicId);
      },
    );
  }

  getComments() async {
    var response = await netUtils.get(Api.BASE_URL + Api.GETCOMMENTS, {'topicId': _topic['id']});
    setState(() {
      _comments = response['data'];
    });
  }

  init() {
    Arguments args=ModalRoute.of(context).settings.arguments;
    this._topic = args.topic;
    if(this.count == 0) {
      this._comments = args.comments;
    }
  }
}

class CommitComment extends StatelessWidget{

  CommitComment({ Key key, this.topicId});

  final int topicId;

  TextEditingController comment = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Text('发表评论', style: TextStyle(fontWeight: FontWeight.bold)),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(right: 10),
                        alignment: Alignment.center,
                        child: FlatButton(
                          color: Colors.white,
                          highlightColor: Colors.white70,
                          colorBrightness: Brightness.dark,
                          splashColor: Colors.blue,
                          child: Text("发布", style: TextStyle(fontSize: 14, color: Colors.blue)),
                          shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                          onPressed: () async {
                            int commentatorId = await Share.getIntValue('userId');
                            var response = await netUtils.get(Api.BASE_URL + Api.ADDCOMMENTS, {
                              'commentatorId': commentatorId,
                              'topicId': topicId,
                              'comment': comment.text
                            });
                            if(response['code'] == 10000){
                              BotToast.showText(text:"评论成功");
                              Navigator.of(context).pop(1);
                            }
                          },
                        )
                    ),
                  ],
                ),
              )
            ],
          ),
          Padding(padding: EdgeInsets.only(bottom: 15)),
          TextField(
            controller: comment,
          )
        ],
      ),
    );
  }
}

class LineWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        decoration: BoxDecoration(
            border: Border.all(width: 0.5, color: Colors.black12)
        )
    );
  }
}
