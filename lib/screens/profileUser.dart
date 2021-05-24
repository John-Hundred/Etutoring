import 'package:argon_flutter/screens/mycourse.dart';
import 'package:argon_flutter/utils/user_secure_storage.dart';
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

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Creating String Var to Hold sent Email.
  String email;

  @override
  void initState() {
    super.initState();
    // init();
  }

  // Receiving Email using Constructor.
  // ProfileScreen({Key key, @required this.email}) : super(key: key);

  // User Logout Function.
  logout(BuildContext context) {
    Navigator.pop(context);
  }

  Future init() async {
    final email = await UserSecureStorage.getEmail() ?? '';
    final password = await UserSecureStorage.getPassword() ?? '';
    this.email = email;
    print(email);
    print(password);
  }

  Widget build(BuildContext context) {
    this.setState(() {
      init();
    });
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
                    child: Text('Email = ', style: TextStyle(fontSize: 20))),
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
