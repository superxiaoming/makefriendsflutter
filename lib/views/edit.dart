import 'package:flutter/material.dart';
import '../utils/share.dart';

const fontStyle = TextStyle(
    fontSize: 20
);

const routerName = [
  '账号与安全',
  '退出当前账号'
];

class Edit extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('设置'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.chevron_left,size: 40,color: Colors.white),
          onPressed: (){
            Navigator.pop(context);
          },
        )
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: ListView.builder(
          itemBuilder: buildItem,
          itemCount: 2
        ),
      )
    );
  }
}

Future<bool> showDeleteConfirmDialog1(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("提示"),
        content: Text("您确定要退出此账号吗?"),
        actions: <Widget>[
          FlatButton(
            child: Text("取消"),
            onPressed: () => Navigator.of(context).pop(), // 关闭对话框
          ),
          FlatButton(
            child: Text("退出"),
            onPressed: () {
              //关闭对话框并返回true
              Share.remove('token');
              Share.remove('userId');
              Navigator.of(context).pop(true);
              Navigator.of(context).pushNamedAndRemoveUntil('views/login', (Route route) =>false);
            },
          ),
        ],
      );
    },
  );
}

Widget buildItem(BuildContext context, int index) {
  if(index == 0){
    return new GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, 'views/account');
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 15),
        child: Flex(
          direction: Axis.horizontal,
          children: <Widget>[
            Text(routerName[index], style: fontStyle),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Icon(Icons.chevron_right, size: 25)
                ],
              ),
            )
          ],
        )
      )
    );
  } else if(index == 1){
    return new GestureDetector(
      onTap: () async {
        bool delete = await showDeleteConfirmDialog1(context);
        if (delete == null) {
          print("取消删除");
        } else {
          print("已确认删除");
          //... 删除文件
        }
      },
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Text(routerName[index], style: fontStyle),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Icon(Icons.chevron_right, size: 25)
              ],
            ),
          )
        ],
      )
    );
  } else {
    return null;
  }
}

