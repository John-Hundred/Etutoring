import 'package:argon_flutter/screens/mycourse.dart';
import 'package:argon_flutter/screens/user_page.dart';
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

import 'package:argon_flutter/config/config.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String email;

  String password;

  List<dynamic> userData;

  // For CircularProgressIndicator.
  bool visible = false;

  @override
  void initState() {
    super.initState();
  }

  // User Logout Function.
  logout(BuildContext context) async {
    setState(() {
      visible = true;
    });
    await Future.delayed(const Duration(seconds: 2), () {});
    this.email = await UserSecureStorage.getEmail();
    this.password = await UserSecureStorage.getPassword();
    // Delete email from secure storage
    UserSecureStorage.delete('email');
    // Delete password from secure storage
    UserSecureStorage.delete('password');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => UserPage()));
  }

  Future<String> getUserData() async {
    var queryParameters = {
      'id': "1",
    };
    var response = await http.get(
        Uri.http(authority, unencodedPath + "users_list.php", queryParameters));

    this.setState(() {
      userData = jsonDecode(response.body);
      print(userData);
    });

    return "Success!";
  }

  Future init() async {
    final email = await UserSecureStorage.getEmail() ?? '';
    final password = await UserSecureStorage.getPassword() ?? '';
    this.email = email;
    this.password = password;
    // print(email);
    // print(password);
  }

  Widget build(BuildContext context) {
    this.setState(() {
      init();
    });

    getUserData();

    final Future<String> _calculation = Future<String>.delayed(
      const Duration(seconds: 0),
      () {
        final email = UserSecureStorage.getEmail() ?? '';
        return email;
        // 'Data Loaded'
      },
    );

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          "/home": (BuildContext context) => new Home(),
          "/profile-screen": (BuildContext context) => new ProfileScreen(),
          "/profile": (BuildContext context) => new Profile(),
          "/articles": (BuildContext context) => new Articles(),
          "/elements": (BuildContext context) => new Elements(),
          "/account": (BuildContext context) => new Register(),
          "/course": (BuildContext context) => new Mycourse(),
        },
        home: Scaffold(
            appBar: Navbar(
              title: 'Profilo',
            ),
            drawer: ArgonDrawer(currentPage: "profile-screen"),
            body: ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                    child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(children: <Widget>[
                          Text("Title " + index.toString(),
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold)),
                          Text("Note Text " + index.toString())
                        ])));
              },
              itemCount: 5,
            )

            /*Center(
              child: FutureBuilder<String>(
                future: _calculation,
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  List<Widget> children;
                  if (snapshot.hasData) {
                    children = <Widget>[
                      const Icon(
                        Icons.check_circle_outline,
                        color: Colors.green,
                        size: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text('Result: ${snapshot.data}'),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            logout(context);
                          },
                          /*color: Colors.red,
                  textColor: Colors.white,*/
                          child: Text('Click Here To Logout')),
                      const SizedBox(height: 20),
                      Visibility(
                        visible: visible,
                        child: Center(
                            child: Container(
                                margin: EdgeInsets.only(bottom: 30),
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                ))),
                      )
                    ];
                  } else if (snapshot.hasError) {
                    children = <Widget>[
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text('Error: ${snapshot.error}'),
                      )
                    ];
                  } else {
                    children = const <Widget>[
                      SizedBox(
                        child: CircularProgressIndicator(),
                        width: 60,
                        height: 60,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text('Awaiting result...'),
                      )
                    ];
                  }
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: children,
                    ),
                  );
                },
              ),
            )
            */
            ));
  }
}
