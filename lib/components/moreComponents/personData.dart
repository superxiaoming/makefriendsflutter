import 'package:flutter/material.dart';
import 'package:makeriends/api/api.dart';
import 'package:makeriends/utils/net.dart';
import 'package:makeriends/utils/share.dart';

class PersonData extends StatefulWidget {

  PersonData();

  @override
  _PersonData createState() => _PersonData();
}

class _PersonData extends State<PersonData> {
  Map basicInfo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBasicInfo();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.all(20),
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(basicInfo == null ? '0' : basicInfo['publish'].toString(), style: TextStyle(fontWeight: FontWeight.bold)),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                ),
                Text('发布',style: TextStyle(color: Colors.grey))
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(basicInfo == null ? '0' : basicInfo['focus'].toString(), style: TextStyle(fontWeight: FontWeight.bold)),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                ),
                Text('关注',style: TextStyle(color: Colors.grey))
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(basicInfo == null ? '0' : basicInfo['message'].toString(), style: TextStyle(fontWeight: FontWeight.bold)),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                ),
                Text('留言',style: TextStyle(color: Colors.grey))
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(basicInfo == null ? '0' : basicInfo['goal'].toString(), style: TextStyle(fontWeight: FontWeight.bold)),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                ),
                Text('目标',style: TextStyle(color: Colors.grey))
              ],
            ),
          )
        ],
      ),
    );
  }

  getBasicInfo() async {
    int userId = await Share.getIntValue('userId');
    var response = await netUtils.get(Api.BASE_URL + Api.GETBASICINFO, {
      'userId': userId
    });
    if(response['code'] == 10000){
      setState(() {
        basicInfo = response['data'];
      });
    }
  }
}