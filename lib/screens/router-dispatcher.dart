import 'package:e_tutoring/screens/profile.dart';
import 'package:e_tutoring/screens/calendar.dart';
import 'package:e_tutoring/screens/course.dart';
import 'package:e_tutoring/screens/settings.dart';
import 'package:e_tutoring/screens/tutoring-course.dart';
import 'package:flutter/material.dart';

import 'package:move_to_background/move_to_background.dart';

class RouterDispatcher extends StatefulWidget {
  @override
  _RouterDispatcherState createState() => _RouterDispatcherState();
}

class _RouterDispatcherState extends State<RouterDispatcher> {
  Widget _body = CircularProgressIndicator();

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    Navigator.popUntil(context, (route) {
      // print(route.settings.name);
      switch (route.settings.name) {
        case '/profile':
          _body = Profile();
          break;
        case '/course':
          _body = Course();
          break;
        case '/tutoring-course':
          _body = TutoringCourse();
          break;
        case '/calendar':
          _body = Calendar();
          break;
        case '/settings':
          _body = Settings();
          break;
        default:
          _body = Profile();
          break;
      }
      return true;
    });

    return new WillPopScope(
        onWillPop: () async {
          MoveToBackground.moveTaskToBack();
          return false;
        },
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: <String, WidgetBuilder>{
              "/myapp": (BuildContext context) => this.widget,
              "/profile": (BuildContext context) => this.widget,
              "/course": (BuildContext context) => this.widget,
              "/tutoring-course": (BuildContext context) => this.widget,
              "/calendar": (BuildContext context) => this.widget,
              "/settings": (BuildContext context) => this.widget,
            },
            home: _body));
  }
}
