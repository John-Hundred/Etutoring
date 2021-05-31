import 'package:argon_flutter/screens/login.dart';
import 'package:argon_flutter/screens/profile.dart';
import 'package:argon_flutter/screens/signin.dart';
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
          // print(value);
          if (value != null)
            _body = Profile();
          else
            _body = MaterialApp(
                title: 'E-Tutoring',
                theme: ThemeData(fontFamily: 'OpenSans'),
                initialRoute: "/login",
                debugShowCheckedModeBanner: false,
                routes: <String, WidgetBuilder>{
                  "/login": (BuildContext context) => new Login(),
                  // "/register": (BuildContext context) => new Signin(),
                });
        })));
  }

  @override
  Widget build(BuildContext context) {
    return _body;
  }
}
