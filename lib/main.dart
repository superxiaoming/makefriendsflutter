import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import './utils/share.dart';
import 'router/router.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BotToastInit(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
        navigatorObservers: [BotToastNavigatorObserver()],
        routes: Router.routers,
      )
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer _timer;

  startTime() async {
    var _duration = new Duration(seconds: 3);
    _timer = new Timer(_duration, navigationPage);
    return _timer;
  }

  void navigationPage() async {
    _timer.cancel();
    String token = await Share.getStringValue('token');
    print(token);
    if(token == null){
      Navigator.of(context).pushReplacementNamed('views/login');
    } else {
      Navigator.of(context).pushReplacementNamed('main');
    }
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: new Image.asset(
          "images/index.jpg",
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
