import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import '../utils/net.dart';
import '../api/api.dart';
import '../utils/share.dart';

class ChangePassword extends StatefulWidget {

  ChangePassword();

  @override
  _ChangePassword createState() => _ChangePassword();
}

class _ChangePassword extends State<ChangePassword> {
  TextEditingController password = new TextEditingController();
  TextEditingController newPassword = new TextEditingController();
  GlobalKey _formKey= new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
            title: Text('密码修改'),
            centerTitle: true,
            leading: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                  alignment: Alignment.center,
                  child: Text('取消', style: TextStyle(fontSize: 18, color: Colors.white))
              ),
            ),
            actions: <Widget>[
              GestureDetector(
                child: Container(
                    padding: EdgeInsets.only(right: 10),
                    alignment: Alignment.center,
                    child: Text('保存', style: TextStyle(fontSize: 18, color: Colors.white))
                ),
                onTap: changePassword,
              )
            ]
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey, //设置globalKey，用于后面获取FormState
            autovalidate: true, //开启自动校验
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "旧密码",
                    hintText: "请输入旧密码",
                    prefixIcon: Icon(Icons.lock)
                  ),
                  controller: password,
                  validator: (v) {
                    return v
                        .trim()
                        .length > 5 ? null : "密码不能少于6位";
                  }
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "新密码",
                    hintText: "请输入新密码",
                    prefixIcon: Icon(Icons.lock)
                  ),
                  controller: newPassword,
                  validator: (v) {
                    return v
                        .trim()
                        .length > 5 ? null : "密码不能少于6位";
                  }
                )
              ],
            ),
          )
        )
    );
  }

  changePassword() async {
    int userId = await Share.getIntValue('userId');
    var response = await netUtils.get(Api.BASE_URL + Api.CHANGEPASSWORD, {
      'userId': userId,
      'password': password.text,
      'newPassword': newPassword.text
    });
    if(response['code'] == 10000){
      BotToast.showText(text:"修改成功");
      Navigator.pop(context);
    }
  }

  Future<bool> showDeleteConfirmDialog1(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text("您确定要注销此账号吗?"),
        );
      },
    );
  }
}
