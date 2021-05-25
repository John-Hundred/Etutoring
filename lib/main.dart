import 'package:argon_flutter/screens/login.dart';
import 'package:argon_flutter/screens/profileUser.dart';
import 'package:argon_flutter/screens/testhttp.dart';
import 'package:argon_flutter/screens/user_page.dart';
import 'package:flutter/material.dart';

// screens
import 'package:argon_flutter/screens/home.dart';
import 'package:argon_flutter/screens/profile.dart';
import 'package:argon_flutter/screens/register.dart';
import 'package:argon_flutter/screens/articles.dart';
import 'package:argon_flutter/screens/elements.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<ListItem> items = List<ListItem>.generate(
      10,
      (i) => i % 6 == 0
          ? HeadingItem('Heading $i')
          : MessageItem('Sender $i', 'Message body $i'),
    );

    return MaterialApp(
        title: 'E-Tutoring',
        theme: ThemeData(fontFamily: 'OpenSans'),
        initialRoute: "/login2",
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          "/login": (BuildContext context) => new UserPage(),
          "/home": (BuildContext context) => new Home(),
          "/profile-screen": (BuildContext context) => new ProfileScreen(),
          "/profile": (BuildContext context) => new Profile(),
          "/articles": (BuildContext context) => new Articles(),
          "/elements": (BuildContext context) => new Elements(),
          "/account": (BuildContext context) => new Register(),
          "/testhttp": (BuildContext context) => new Testhttp(items: items),
        });
  }
}
