import 'package:flutter/material.dart';
import 'package:makeriends/api/api.dart';
import 'package:makeriends/params/Person.dart';
import 'package:makeriends/utils/net.dart';
import 'package:makeriends/utils/share.dart';

class PersonInfoHeader extends StatefulWidget{

  PersonInfoHeader();

  @override
  _PersonInfoHeaderState createState() => _PersonInfoHeaderState();
}

class _PersonInfoHeaderState extends State<PersonInfoHeader>{
  Map _userInfo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPersonInfo();
  }

  @override
  Widget build(BuildContext context){

    const fontStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18
    );

    return GestureDetector(
      onTap: () async {
        Navigator.of(context).pushNamed("views/personInfo", arguments: Person(
          _userInfo['age'],
          _userInfo['college'],
          _userInfo['headpic'],
          _userInfo['major'],
          _userInfo['nickname'],
          _userInfo['school'],
          _userInfo['sex'],
          _userInfo['sign'],
          _userInfo['tags'],
        )).then((data) {
          getPersonInfo();
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(100)),
              clipBehavior: Clip.antiAlias,
              child: _userInfo == null || _userInfo['headpic'] == '' ?
              Image.asset('images/nan.jpg', width: 110, height: 110) :
              Image.network(_userInfo['headpic'], width: 110, height: 110)
            ),
            Padding(
              padding: EdgeInsets.only(left: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(_userInfo == null ? '' : _userInfo['nickname'], style: fontStyle),
                  Text('查看个人信息', style: TextStyle(color: Colors.grey))
                ],
              ),
            ),
          ],
        ),
      )
    );
  }

  getPersonInfo() async {
    int userId = await Share.getIntValue('userId');
    var response = await netUtils.get(Api.BASE_URL + Api.GETUSERINFOBYID, {
      'userId': userId
    });
    if(response['code'] == 10000){
      setState(() {
        _userInfo = response['data'];
      });
    }
  }
}
