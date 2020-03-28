import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import '../utils/net.dart';
import '../api/api.dart';

class Register extends StatefulWidget{

  Register();

  @override
  _Register createState() => _Register();
}

class _Register extends State<Register>{

  @override
  Widget build(BuildContext context) {

    TextEditingController userName = new TextEditingController();
    TextEditingController password = new TextEditingController();
    GlobalKey _formKey= new GlobalKey<FormState>();

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          title: Text('账号注册'),
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
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                            autofocus: true,
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
                            obscureText: true,
                            controller: password,
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
                                    child: Text("注册"),
                                    color: Theme.of(context).primaryColor,
                                    textColor: Colors.white,
                                    onPressed: () async {
                                      //验证通过提交数据
                                      var response = await netUtils.get(Api.BASE_URL + Api.REGISTER, {'userName': userName.text, 'password': password.text});
                                      if(response['code'] == 10000){
                                        BotToast.showText(text:"注册成功");  //弹出一个文本框;
                                        Navigator.pushReplacementNamed(context, 'views/login');
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
                                    child: Text("已有账号？立即登陆"),
                                    color: Theme.of(context).primaryColor,
                                    textColor: Colors.white,
                                    onPressed: () {
                                      Navigator.pushNamed(context, 'views/login');
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
              ),
            ),
          )
        ],
      )
    );
  }
}
