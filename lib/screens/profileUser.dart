import 'package:argon_flutter/widgets/drawer.dart';
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:flutter/material.dart';

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
        home: Scaffold(
            appBar: AppBar(
                title: Text('Profile Screen'),
                automaticallyImplyLeading: false),
            /*appBar: Navbar(
              title: 'Profile',
            ),*/
            // drawer: ArgonDrawer(currentPage: "Profile"),
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
