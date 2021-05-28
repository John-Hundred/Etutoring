import 'package:argon_flutter/model/user.dart';
import 'package:argon_flutter/screens/mycourse.dart';
import 'package:argon_flutter/utils/user_secure_storage.dart';
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:flutter/material.dart';

// screens
import 'package:argon_flutter/screens/home.dart';
import 'package:argon_flutter/screens/register.dart';
import 'package:argon_flutter/screens/articles.dart';
import 'package:argon_flutter/screens/elements.dart';

import 'package:argon_flutter/config/config.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:move_to_background/move_to_background.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User user;
  String email;

  String password;

  // For CircularProgressIndicator.
  bool visible = false;

  @override
  void initState() {
    super.initState();
  }

  Future<User> getUserInfoFromWS = Future<User>.delayed(
    const Duration(seconds: 0),
    () async {
      try {
        var queryParameters = {
          'email': await UserSecureStorage.getEmail(),
        };
        // print(queryParameters);
        var response = await http.get(Uri.http(
            authority, unencodedPath + "users_list.php", queryParameters));

        var user;
        if (response.statusCode == 200) {
          var userJsonData = json.decode(response.body);
          user = User.fromJson(userJsonData);
        }
        // print(user);
        return user;
      } on Exception catch ($e) {
        print('error caught: ' + $e.toString());
        return null;
      }
    },
  );

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

    return new WillPopScope(
        onWillPop: () async {
          MoveToBackground.moveTaskToBack();
          return false;
        },
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: <String, WidgetBuilder>{
              "/home": (BuildContext context) => new Home(),
              "/profile": (BuildContext context) => new Profile(),
              "/articles": (BuildContext context) => new Articles(),
              "/elements": (BuildContext context) => new Elements(),
              "/account": (BuildContext context) => new Register(),
              "/course": (BuildContext context) => new Mycourse(),
            },
            home: Scaffold(
              backgroundColor: Color.fromRGBO(205, 205, 205, 1),
              appBar: AppBar(
                  title: const Text('Profilo'),
                  backgroundColor: Color.fromRGBO(213, 21, 36, 1)),
              // Nav Bar (title: 'Profilo', bgColor: Color.fromRGBO(213, 21, 36, 1)),
              drawer: ArgonDrawer("profile"),
              body: Stack(children: <Widget>[
                SafeArea(
                    child: ListView(children: [
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 10.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Stack(children: <Widget>[
                              Container(
                                child: Card(
                                    child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0.0, bottom: 0.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            FutureBuilder<User>(
                                              future: getUserInfoFromWS,
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<User> user) {
                                                List<Widget> children;
                                                if (user.hasData) {
                                                  print(user.data);
                                                  children = <Widget>[
                                                    Container(
                                                        /*color: Color.fromRGBO(
                                                            205, 205, 205, 1),*/
                                                        child: DataTable(
                                                      headingRowHeight: 0,
                                                      columns: <DataColumn>[
                                                        DataColumn(
                                                          label: Text(
                                                            '',
                                                          ),
                                                        ),
                                                        DataColumn(
                                                          label: Text(
                                                            '',
                                                          ),
                                                        ),
                                                      ],
                                                      rows: <DataRow>[
                                                        DataRow(
                                                          cells: <DataCell>[
                                                            DataCell(Text(
                                                              'Cognome',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .redAccent,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )),
                                                            DataCell(Text(
                                                                "${user.data.lastname}")),
                                                          ],
                                                        ),
                                                        DataRow(
                                                          cells: <DataCell>[
                                                            DataCell(Text(
                                                                'Nome',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .redAccent,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold))),
                                                            DataCell(Text(
                                                                "${user.data.firstname}")),
                                                          ],
                                                        ),
                                                        DataRow(
                                                          cells: <DataCell>[
                                                            DataCell(Text(
                                                                'Role',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .redAccent,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold))),
                                                            DataCell(Text(
                                                                "${user.data.role_name}")),
                                                          ],
                                                        ),
                                                        DataRow(
                                                          cells: <DataCell>[
                                                            DataCell(Text(
                                                                'Matricola',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .redAccent,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold))),
                                                            DataCell(Text(
                                                                "${user.data.badge_number}")),
                                                          ],
                                                        ),
                                                        DataRow(
                                                          cells: <DataCell>[
                                                            DataCell(Text(
                                                                'Email',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .redAccent,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold))),
                                                            DataCell(Text(
                                                                "${user.data.email}")),
                                                          ],
                                                        ),
                                                        DataRow(
                                                          cells: <DataCell>[
                                                            DataCell(Text(
                                                                'Corso di Laurea',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .redAccent,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold))),
                                                            DataCell(Text(
                                                                "${user.data.degree_name} (" +
                                                                    "${user.data.degree_athenaeum})")),
                                                          ],
                                                        ),
                                                        DataRow(
                                                          cells: <DataCell>[
                                                            DataCell(Text(
                                                                'Sede',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .redAccent,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold))),
                                                            DataCell(Text(
                                                                "${user.data.degree_location}")),
                                                          ],
                                                        ),
                                                        DataRow(
                                                          cells: <DataCell>[
                                                            DataCell(Text(
                                                                'Percorso',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .redAccent,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold))),
                                                            DataCell(Text(
                                                                "${user.data.degree_path_name}")),
                                                          ],
                                                        ),
                                                      ],
                                                    )),
                                                  ];
                                                } else if (user.hasError) {
                                                  children = <Widget>[
                                                    const Icon(
                                                      Icons.error_outline,
                                                      color: Colors.red,
                                                      size: 60,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 16),
                                                      child: Text(
                                                          'Error: ${user.error}'),
                                                    )
                                                  ];
                                                } else {
                                                  children = const <Widget>[
                                                    SizedBox(
                                                      child:
                                                          CircularProgressIndicator(),
                                                      width: 60,
                                                      height: 60,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 16),
                                                      child: Text(
                                                          'Awaiting result...'),
                                                    )
                                                  ];
                                                }
                                                return Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: children,
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                              ),
                            ]),
                          ])),
                ]))
              ]),
            )));
  }
}
