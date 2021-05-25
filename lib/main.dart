import 'package:argon_flutter/screens/profileUser.dart';
import 'package:argon_flutter/screens/user_page.dart';
import 'package:argon_flutter/utils/user_secure_storage.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget _body = CircularProgressIndicator();

  @override
  void initState() {
    super.initState();
    UserSecureStorage.getEmail().then((value) => (setState(() {
          print(value);
          if (value != null)
            _body = ProfileScreen();
          else
            _body = MaterialApp(
                title: 'E-Tutoring',
                theme: ThemeData(fontFamily: 'OpenSans'),
                initialRoute: "/login",
                debugShowCheckedModeBanner: false,
                routes: <String, WidgetBuilder>{
                  "/login": (BuildContext context) => new UserPage(),
                });
        })));
  }

  @override
  Widget build(BuildContext context) {
    return _body;
  }

  /*
  @override
  Widget build(BuildContext context) {
    this.init();
    print(this.route);
    return MaterialApp(
        title: 'E-Tutoring',
        theme: ThemeData(fontFamily: 'OpenSans'),
        initialRoute: this.route,
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          "/login": (BuildContext context) => new UserPage(),
          "/home": (BuildContext context) => new Home(),
          "/profile-screen": (BuildContext context) => new ProfileScreen(),
          "/profile": (BuildContext context) => new Profile(),
          "/articles": (BuildContext context) => new Articles(),
          "/elements": (BuildContext context) => new Elements(),
          "/account": (BuildContext context) => new Register()
        });
  }*/
}
