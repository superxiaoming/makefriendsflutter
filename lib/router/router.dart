import 'package:flutter/material.dart';
import 'package:makeriends/components/PersonComponents/addMemoryDay.dart';
import 'package:makeriends/components/PersonComponents/commemorationDay.dart';
import 'package:makeriends/components/PersonComponents/leaveMessage.dart';
import 'package:makeriends/components/PersonComponents/myCoupleActivity.dart';
import 'package:makeriends/components/PersonComponents/myLoveDoubts.dart';
import 'package:makeriends/components/PersonComponents/myLoveShare.dart';
import 'package:makeriends/components/PersonComponents/myStudyGoal.dart';
import 'package:makeriends/components/indexComponents/addComments.dart';
import 'package:makeriends/components/indexComponents/addTopic.dart';
import 'package:makeriends/components/moreComponents/edit.dart';
import 'package:makeriends/components/studyGoalComponents/addGoals.dart';
import 'package:makeriends/views/account.dart';
import 'package:makeriends/views/changePassword.dart';
import 'package:makeriends/views/edit.dart';
import 'package:makeriends/views/login.dart';
import 'package:makeriends/views/personInfo.dart';
import 'package:makeriends/views/personInfoEdit.dart';
import 'package:makeriends/views/register.dart';
import '../views/bottomItems.dart';

class Router {
  static Map<String, WidgetBuilder> routers = {
    'main': (context) {
      return MyHomePageAnother();
    },
    'views/edit': (context) {
      return new Edit();
    },
    'views/account': (context) {
      return new Account();
    },
    'views/changePassword': (context) {
      return new ChangePassword();
    },
    'views/personInfo': (context) {
      return new PersonInfo();
    },
    'views/personInfoEdit': (context) {
      return new PersonInfoEdit();
    },
    'views/person/myLoveDoubts': (context) {
      return new MyLoveDoubts();
    },
    'views/person/myLoveShare': (context) {
      return new MyLoveShare();
    },
    'views/person/myCoupleActivity': (context) {
      return new MyCoupleActivity();
    },
    'views/person/leaveMessage': (context) {
      return new LeaveMessage();
    },
    'views/person/CommemorationDay': (context) {
      return new CommemorationDay();
    },
    'views/person/myStudyGoal': (context) {
      return new MyStudyGoal();
    },
    'views/register': (context) {
      return new Register();
    },
    'views/login': (context) {
      return new Login();
    },
    'views/addComments': (context) {
      return new AddComments();
    },
    'views/addTopic': (context) {
      return new AddTopic();
    },
    'views/addMemoryDay': (context) {
      return new AddMemoryday();
    },
    'views/addGoals': (context) {
      return new AddGoals();
    },
    'views/editInfo': (context) {
      return new EditInfo();
    },
  };
}