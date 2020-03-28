import 'package:flutter/material.dart';
import '../components/moreComponents//personInfoHeader.dart';
import '../components/moreComponents//personData.dart';
import '../components/moreComponents//applicationPart.dart';

class More extends StatefulWidget{

  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More>{
  Map userInfo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          expandedHeight: 50.0,
           actions: <Widget>[
            IconButton(
            icon: Icon(Icons.settings),
            tooltip: 'Open settings',
            onPressed: () {
              Navigator.pushNamed(context, 'views/edit');
            },
           ),
          ],
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            <Widget>[
              PersonInfoHeader(),
              PersonData(),
              LineWidget(),
              ApplicationPart()
            ]
          ),
        )
      ]
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