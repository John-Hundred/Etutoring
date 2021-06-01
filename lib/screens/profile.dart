import 'package:argon_flutter/constants/Theme.dart';
import 'package:argon_flutter/controller/controllerWS.dart';
import 'package:argon_flutter/model/userModel.dart';
import 'package:argon_flutter/screens/course.dart';
import 'package:argon_flutter/utils/user_secure_storage.dart';
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:flutter/material.dart';

// screens
import 'package:argon_flutter/screens/home.dart';
import 'package:argon_flutter/screens/articles.dart';
import 'package:argon_flutter/screens/elements.dart';

import 'package:move_to_background/move_to_background.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String email;
  String password;

  // For CircularProgressIndicator.
  bool visible = false;

  @override
  void initState() {
    super.initState();
  }

  Future init() async {
    final email = await UserSecureStorage.getEmail() ?? '';
    final password = await UserSecureStorage.getPassword() ?? '';
    this.email = email;
    this.password = password;
  }

  Widget build(BuildContext context) {
    this.init();
    /*this.setState(() {
      init();
    });*/

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
              "/course": (BuildContext context) => new Course(),
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
                          left: 15.0, right: 15.0, top: 10.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Stack(children: <Widget>[
                              Container(
                                child: Card(
                                    color: Color.fromRGBO(205, 205, 205, 1),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0.0, bottom: 20.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              children: [
                                                FutureBuilder<UserModel>(
                                                  future: getUserInfoFromWS(),
                                                  builder: (BuildContext
                                                          context,
                                                      AsyncSnapshot<UserModel>
                                                          user) {
                                                    List<Widget> children;
                                                    if (user.hasData) {
                                                      // print(user.data);
                                                      children = <Widget>[
                                                        Container(
                                                            color:
                                                                Color.fromRGBO(
                                                                    205,
                                                                    205,
                                                                    205,
                                                                    1),
                                                            child: DataTable(
                                                              dataRowHeight: 50,
                                                              dataRowColor: MaterialStateColor
                                                                  .resolveWith(
                                                                      (states) =>
                                                                          Colors
                                                                              .white),
                                                              headingRowHeight:
                                                                  0,
                                                              columns: <
                                                                  DataColumn>[
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
                                                                  cells: <
                                                                      DataCell>[
                                                                    DataCell(
                                                                        Text(
                                                                      'Cognome',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .redAccent,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15),
                                                                    )),
                                                                    DataCell(Text(
                                                                        "${user.data.lastname}",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                15))),
                                                                  ],
                                                                ),
                                                                DataRow(
                                                                  cells: <
                                                                      DataCell>[
                                                                    DataCell(Text(
                                                                        'Nome',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.redAccent,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 15))),
                                                                    DataCell(Text(
                                                                        "${user.data.firstname}",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                15))),
                                                                  ],
                                                                ),
                                                                DataRow(
                                                                  cells: <
                                                                      DataCell>[
                                                                    DataCell(Text(
                                                                        'Email',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.redAccent,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 15))),
                                                                    DataCell(
                                                                      Text(
                                                                        "${user.data.email}",
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                DataRow(
                                                                  cells: <
                                                                      DataCell>[
                                                                    DataCell(Text(
                                                                        'Password',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.redAccent,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 15))),
                                                                    DataCell(Row(
                                                                        children: <
                                                                            Widget>[
                                                                          Text(
                                                                              "********",
                                                                              style: TextStyle(fontSize: 15)),
                                                                          TextButton(
                                                                            style:
                                                                                ButtonStyle(
                                                                              foregroundColor: MaterialStateProperty.all<Color>(ArgonColors.redUnito),
                                                                            ),
                                                                            onPressed:
                                                                                () {},
                                                                            child:
                                                                                Text('Change', style: TextStyle(fontSize: 15)),
                                                                          )
                                                                        ])),
                                                                  ],
                                                                ),
                                                                /*DataRow(
                                                                  cells: <
                                                                      DataCell>[
                                                                    DataCell(
                                                                        Text(
                                                                      'Numero di telefono',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .redAccent,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )),
                                                                    DataCell(Text(
                                                                        "${user.data.phone_number}")),
                                                                  ],
                                                                ),*/
                                                                DataRow(
                                                                  cells: <
                                                                      DataCell>[
                                                                    DataCell(
                                                                        Text(
                                                                      'Nazionalità',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .redAccent,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15),
                                                                    )),
                                                                    DataCell(Text(
                                                                        "${user.data.nationality}",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                15))),
                                                                  ],
                                                                ),
                                                                DataRow(
                                                                  cells: <
                                                                      DataCell>[
                                                                    DataCell(Text(
                                                                        'Data di Nascita',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.redAccent,
                                                                            fontWeight: FontWeight.bold))),
                                                                    DataCell(Text(
                                                                        "${user.data.birth_date}",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                15))),
                                                                  ],
                                                                ),
                                                                DataRow(
                                                                  cells: <
                                                                      DataCell>[
                                                                    DataCell(Text(
                                                                        'Luogo di Nascita',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.redAccent,
                                                                            fontWeight: FontWeight.bold))),
                                                                    DataCell(Text(
                                                                        "${user.data.birth_city}",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                15))),
                                                                  ],
                                                                ),
                                                                DataRow(
                                                                  cells: <
                                                                      DataCell>[
                                                                    DataCell(Text(
                                                                        'Città di residenza',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.redAccent,
                                                                            fontWeight: FontWeight.bold))),
                                                                    DataCell(Text(
                                                                        "${user.data.residence_city}",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                15))),
                                                                  ],
                                                                ),
                                                              ],
                                                            )),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Container(
                                                            color:
                                                                Color.fromRGBO(
                                                                    205,
                                                                    205,
                                                                    205,
                                                                    1),
                                                            child: DataTable(
                                                              dataRowHeight: 60,
                                                              dataRowColor: MaterialStateColor
                                                                  .resolveWith(
                                                                      (states) =>
                                                                          Colors
                                                                              .white),
                                                              headingRowHeight:
                                                                  0,
                                                              columns: <
                                                                  DataColumn>[
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
                                                                  cells: <
                                                                      DataCell>[
                                                                    DataCell(Text(
                                                                        'Ruolo',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.redAccent,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 15))),
                                                                    DataCell(Text(
                                                                        "${user.data.role_name}",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                15))),
                                                                  ],
                                                                ),
                                                                DataRow(
                                                                  cells: <
                                                                      DataCell>[
                                                                    DataCell(Text(
                                                                        'Matricola',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.redAccent,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 15))),
                                                                    DataCell(Text(
                                                                        "${user.data.badge_number}",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                15))),
                                                                  ],
                                                                ),
                                                                DataRow(
                                                                  cells: <
                                                                      DataCell>[
                                                                    DataCell(Text(
                                                                        'Corso di Laurea',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.redAccent,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 15))),
                                                                    DataCell(Text(
                                                                        "${user.data.degree_name} (" +
                                                                            "${user.data.degree_athenaeum})",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                15))),
                                                                  ],
                                                                ),
                                                                DataRow(
                                                                  cells: <
                                                                      DataCell>[
                                                                    DataCell(Text(
                                                                        'Tipologia',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.redAccent,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 15))),
                                                                    DataCell(Text(
                                                                        "${user.data.degree_type_note} (" +
                                                                            "${user.data.degree_type_name})",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                15))),
                                                                  ],
                                                                ),
                                                                DataRow(
                                                                  cells: <
                                                                      DataCell>[
                                                                    DataCell(Text(
                                                                        'Sede',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.redAccent,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 15))),
                                                                    DataCell(Text(
                                                                        "${user.data.degree_location}",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                15))),
                                                                  ],
                                                                ),
                                                                DataRow(
                                                                  cells: <
                                                                      DataCell>[
                                                                    DataCell(Text(
                                                                        'Percorso',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.redAccent,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 15))),
                                                                    DataCell(Text(
                                                                        "${user.data.degree_path_name}",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                15))),
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
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 15),
                                                          child: Text(
                                                              'Error: ${user.error}'),
                                                        )
                                                      ];
                                                    } else {
                                                      children = const <Widget>[
                                                        SizedBox(
                                                          child: CircularProgressIndicator(
                                                              backgroundColor:
                                                                  ArgonColors
                                                                      .redUnito),
                                                          width: 60,
                                                          height: 60,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 15),
                                                          child: Text(
                                                              'Awaiting result...',
                                                              style: TextStyle(
                                                                  color: ArgonColors
                                                                      .redUnito)),
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
