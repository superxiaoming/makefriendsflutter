import 'package:flutter/material.dart';

class ApplicationPart extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
//                    border: Border.all(width: 1, color: Colors.black)
                  ),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, 'views/person/myLoveDoubts');
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'images/lianai.png',
                          width: 40,
                          height: 40,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                        ),
                        Text('恋爱疑惑')
                      ],
                    ),
                  )
                ),
              ),

              Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
//                    border: Border.all(width: 1, color: Colors.black)
                    ),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, 'views/person/myLoveShare');
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'images/fenxiang.png',
                            width: 40,
                            height: 40,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                          ),
                          Text('甜蜜分享')
                        ],
                      ),
                    ),
                  )
              ),

              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
//                    border: Border.all(width: 1, color: Colors.black)
                  ),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, 'views/person/myCoupleActivity');
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'images/qinglv.png',
                          width: 40,
                          height: 40,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                        ),
                        Text('情侣活动')
                      ],
                    ),
                  )
                ),
              ),

            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 30),
          ),
          Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
//                    border: Border.all(width: 1, color: Colors.black)
                  ),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, 'views/person/myStudyGoal');
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'images/mubiao.png',
                          width: 40,
                          height: 40,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                        ),
                        Text('学习目标')
                      ],
                    ),
                  )
                ),
              ),

              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
//                    border: Border.all(width: 1, color: Colors.black)
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'views/person/CommemorationDay');
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'images/jinianri.png',
                          width: 40,
                          height: 40,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                        ),
                        Text('纪念日')
                      ],
                    ),
                  )
                ),
              ),

              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
//                    border: Border.all(width: 1, color: Colors.black)
                  ),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, 'views/person/leaveMessage');
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'images/TIFFANYSROOM_huaban.png',
                          width: 40,
                          height: 40,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                        ),
                        Text('留言板')
                      ],
                    ),
                  )
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}