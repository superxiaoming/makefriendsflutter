import 'package:flutter/material.dart';

const fontStyle = TextStyle(
    fontSize: 20
);

class Account extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('账号与安全'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.chevron_left,size: 40,color: Colors.white),
          onPressed: (){
            Navigator.pop(context);
          },
        )
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 60),
            alignment: Alignment.center,
            child: Image.asset(
              'images/anquan.png',
              width: 100,
              height: 100,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, 'views/changePassword');
              },
              child: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Image.asset('images/mima.png', width: 30, height: 30),
                  Padding(padding: EdgeInsets.only(right: 20)),
                  Text('密码修改', style: fontStyle),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text('设置密码', style: TextStyle(color: Colors.black26, fontSize: 16)),
                        Icon(Icons.chevron_right, size: 25)
                      ],
                    ),
                  )
                ],
              )
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: GestureDetector(
                onTap: () async {
                  bool delete = await showDeleteConfirmDialog1(context);
                  if (delete == null) {
                    print("取消删除");
                  } else {
                    print("已确认删除");
                  }
                },
                child: Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Image.asset('images/guanji.png', width: 30, height: 30),
                    Padding(padding: EdgeInsets.only(right: 20)),
                    Text('账号注销', style: fontStyle),
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
            ),
          ),
        ],
      ),
    );
  }
}

Future<bool> showDeleteConfirmDialog1(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("提示"),
        content: Text("您确定要注销此账号吗?"),
        actions: <Widget>[
          FlatButton(
            child: Text("取消"),
            onPressed: () => Navigator.of(context).pop(), // 关闭对话框
          ),
          FlatButton(
            child: Text("注销"),
            onPressed: () {
              //关闭对话框并返回true
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  );
}