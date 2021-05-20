import 'package:argon_flutter/screens/mycourse.dart';
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:flutter/material.dart';

// screens
import 'package:argon_flutter/screens/home.dart';
import 'package:argon_flutter/screens/profile.dart';
import 'package:argon_flutter/screens/register.dart';
import 'package:argon_flutter/screens/articles.dart';
import 'package:argon_flutter/screens/elements.dart';

import 'login.dart';

class ProfileScreen extends StatelessWidget {
  // Creating String Var to Hold sent Email.
  final String email;

  // Receiving Email using Constructor.
  ProfileScreen({Key key, @required this.email}) : super(key: key);

  // User Logout Function.
  logout(BuildContext context) {
    Navigator.pop(context);
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          "/login": (BuildContext context) => new LoginUser(),
          "/home": (BuildContext context) => new Home(),
          "/profile": (BuildContext context) => new Profile(),
          "/articles": (BuildContext context) => new Articles(),
          "/elements": (BuildContext context) => new Elements(),
          "/account": (BuildContext context) => new Register(),
          "/course": (BuildContext context) => new Mycourse(),
        },
        home: Scaffold(
            /*appBar: AppBar(
                title: Text('Profile Screen'),
                automaticallyImplyLeading: false),*/
            appBar: Navbar(
              title: 'Profilo',
            ),
            drawer: ArgonDrawer(currentPage: "Profilo"),
            body: Center(
                child: Column(
              children: <Widget>[
                Container(
                    width: 280,
                    padding: EdgeInsets.all(10.0),
                    child: Text('Email = ' + '\n' + email,
                        style: TextStyle(fontSize: 20))),
                ElevatedButton(
                  onPressed: () {
                    logout(context);
                  },
                  /*color: Colors.red,
                  textColor: Colors.white,*/
                  child: Text('Click Here To Logout'),
                ),
              ],
            ))));
  }
}
