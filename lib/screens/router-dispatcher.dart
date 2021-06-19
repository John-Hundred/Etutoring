import 'package:e_tutoring/l10n/l10n.dart';
import 'package:e_tutoring/provider/locale_provider.dart';
import 'package:e_tutoring/screens/chat.dart';
import 'package:e_tutoring/screens/favorite-tutor.dart';
import 'package:e_tutoring/screens/my-tutor-course.dart';
import 'package:e_tutoring/screens/my-tutor-reviews.dart';
import 'package:e_tutoring/screens/my-tutor-timeslot.dart';
import 'package:e_tutoring/screens/profile.dart';
import 'package:e_tutoring/screens/calendar.dart';
import 'package:e_tutoring/screens/course.dart';
import 'package:e_tutoring/screens/settings.dart';
import 'package:e_tutoring/screens/tutor.dart';
import 'package:e_tutoring/screens/tutorCourse.dart';
import 'package:e_tutoring/screens/tutoring-course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
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
      print(route.settings);
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
        case '/tutor':
          _body = Tutor();
          break;
        case '/favorite-tutor':
          _body = FavoriteTutor();
          break;
        case '/chat':
          _body = Chat();
          break;
        case '/tutor-course':
          _body = TutorCourse();
          break;
        case '/my-tutor-course':
          _body = MyTutorCourse();
          break;
        case '/my-tutor-timeslot':
          _body = MyTutorTimeslot();
          break;
        case '/my-tutor-reviews':
          _body = MyTutorReviews();
          break;
        default:
          _body = Profile();
          break;
      }
      return true;
    });
    return ChangeNotifierProvider(
      create: (context) => LocaleProvider(),
      builder: (context, child) {
        final provider = Provider.of<LocaleProvider>(context);

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: <String, WidgetBuilder>{
            "/profile": (BuildContext context) => this.widget,
            "/course": (BuildContext context) => this.widget,
            "/tutoring-course": (BuildContext context) => this.widget,
            "/calendar": (BuildContext context) => this.widget,
            "/settings": (BuildContext context) => this.widget,
            "/tutor": (BuildContext context) => this.widget,
            "/favorite-tutor": (BuildContext context) => this.widget,
            "/chat": (BuildContext context) => this.widget,
            "/tutor-course": (BuildContext context) => this.widget,
            "/my-tutor-course": (BuildContext context) => this.widget,
            "/my-tutor-timeslot": (BuildContext context) => this.widget,
            "/my-tutor-reviews": (BuildContext context) => this.widget,
          },
          title: 'Router Dispatcher',
          /*theme: ThemeData(
            scaffoldBackgroundColor: Colors.deepPurple.shade100,
            primaryColor: Colors.deepPurpleAccent,
          ),*/
          locale: provider.locale,
          supportedLocales: L10n.all,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          home: _body,
        );
      },
    );
  }
}
