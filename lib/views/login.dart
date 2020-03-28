import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import '../utils/net.dart';
import '../api/api.dart';
import '../utils/share.dart';

class Login extends StatefulWidget{

  Login();

  @override
  _Login createState() => _Login();
}

class _Login extends State<Login>{

  @override
  Widget build(BuildContext context) {
    TextEditingController userName = TextEditingController();
    TextEditingController password = TextEditingController();
    GlobalKey _formKey= new GlobalKey<FormState>();

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          title: Text('账号登陆'),
          centerTitle: true
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Form(
                  key: _formKey, //设置globalKey，用于后面获取FormState
                  autovalidate: true, //开启自动校验
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TextFormField(
                                decoration: InputDecoration(
                                    labelText: "用户名",
                                    hintText: "用户名",
                                    prefixIcon: Icon(Icons.person)
                                ),
                                controller: userName,
                                // 校验用户名
                                validator: (v) {
                                  return v.trim().length > 0 ? null : "用户名不能为空";
                                }
                            ),
                            TextFormField(
                                decoration: InputDecoration(
                                    labelText: "密码",
                                    hintText: "您的登录密码",
                                    prefixIcon: Icon(Icons.lock)
                                ),
                                controller: password,
                                obscureText: true,
                                validator: (v) {
                                  return v
                                      .trim()
                                      .length > 5 ? null : "密码不能少于6位";
                                }
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: RaisedButton(
                                      padding: EdgeInsets.all(15.0),
                                      child: Text("登录"),
                                      color: Theme.of(context).primaryColor,
                                      textColor: Colors.white,
                                      onPressed: () async {
                                        if((_formKey.currentState as FormState).validate()){
                                          //验证通过提交数据
                                          var response = await netUtils.get(Api.BASE_URL + Api.LOGIN, {'username': userName.text, 'password': password.text});
                                          if(response['code'] == 10000){
                                            print(response['data']);
                                            await Share.setStringValue('token', response['data']['token']);
                                            await Share.setIntValue('userId', response['data']['userId']);
                                            BotToast.showText(text:"登陆成功");
                                            Navigator.pushReplacementNamed(context, 'main');
                                          } else {
                                            BotToast.showText(text:"登陆失败，请确认账户密码");  //弹出一个文本框;
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: RaisedButton(
                                      padding: EdgeInsets.all(15.0),
                                      child: Text("没有账号？立即注册"),
                                      color: Theme.of(context).primaryColor,
                                      textColor: Colors.white,
                                      onPressed: () {
                                        Navigator.pushNamed(context, 'views/register');
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
            )
          )
        ],
      )
    );
  }
}
