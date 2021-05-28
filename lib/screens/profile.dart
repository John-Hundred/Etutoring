import 'package:argon_flutter/constants/Theme.dart';
import 'package:argon_flutter/model/user.dart';
import 'package:argon_flutter/screens/mycourse.dart';
import 'package:argon_flutter/utils/user_secure_storage.dart';
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:argon_flutter/widgets/navbar.dart';
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

    /*getUserData().then((value) {
      this.user = value;
      // print(this.user);
    });*/

    /*final Future<String> _calculation = Future<String>.delayed(
      const Duration(seconds: 0),
      () {
        final email = UserSecureStorage.getEmail() ?? '';
        return email;
        // 'Data Loaded'
      },
    );*/

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
              appBar: Navbar(
                  title: 'Profilo', bgColor: Color.fromRGBO(213, 21, 36, 1)),
              drawer: ArgonDrawer("profile"),
              body: Stack(children: <Widget>[
                /*Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            alignment: Alignment.topCenter,
                            image:
                                AssetImage("assets/img/profile-screen-bg.png"),
                            fit: BoxFit.fitWidth))),*/
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
                                /* decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 1,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),*/
                                child: Card(
                                    // semanticContainer: true,
                                    // clipBehavior: Clip.antiAliasWithSaveLayer,
                                    // elevation: .0,
                                    /*shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0))),*/
                                    child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0.0, bottom: 0.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            /*Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: ArgonColors.info,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(3.0),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.3),
                                                            spreadRadius: 1,
                                                            blurRadius: 7,
                                                            offset: Offset(0,
                                                                3), // changes position of shadow
                                                          ),
                                                        ],
                                                      ),
                                                      child: Text(
                                                        "CONNECT",
                                                        style: TextStyle(
                                                            color: ArgonColors
                                                                .white,
                                                            fontSize: 12.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 8.0,
                                                              vertical: 8.0),
                                                    ),*/
                                            /*SizedBox(
                                                      width: 30.0,
                                                    ),*/
                                            /* Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            ArgonColors.initial,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(3.0),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.3),
                                                            spreadRadius: 1,
                                                            blurRadius: 7,
                                                            offset: Offset(0,
                                                                3), // changes position of shadow
                                                          ),
                                                        ],
                                                      ),
                                                      child: Text(
                                                        "MESSAGE",
                                                        style: TextStyle(
                                                            color: ArgonColors
                                                                .white,
                                                            fontSize: 12.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 8.0,
                                                              vertical: 8.0),
                                                    )
                                                  ],
                                                ),*/
                                            // SizedBox(height: 40.0),
                                            /*Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Text("2K",
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        82,
                                                                        95,
                                                                        127,
                                                                        1),
                                                                fontSize: 20.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        Text("Orders",
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        50,
                                                                        50,
                                                                        93,
                                                                        1),
                                                                fontSize: 12.0))
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text("10",
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        82,
                                                                        95,
                                                                        127,
                                                                        1),
                                                                fontSize: 20.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        Text("Photos",
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        50,
                                                                        50,
                                                                        93,
                                                                        1),
                                                                fontSize: 12.0))
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text("89",
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        82,
                                                                        95,
                                                                        127,
                                                                        1),
                                                                fontSize: 20.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        Text("Comments",
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        50,
                                                                        50,
                                                                        93,
                                                                        1),
                                                                fontSize: 12.0))
                                                      ],
                                                    )
                                                  ],
                                                ),*/
                                            // SizedBox(height: 40.0),
                                            FutureBuilder<User>(
                                              future: getUserInfoFromWS,
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<User> user) {
                                                List<Widget> children;
                                                if (user.hasData) {
                                                  print(user.data);
                                                  children = <Widget>[
                                                    /*const Icon(
                                                          Icons
                                                              .check_circle_outline,
                                                          color: Colors.green,
                                                          size: 60,
                                                        ),*/
                                                    DataTable(
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
                                                      ],
                                                    ),
                                                    // SizedBox(height: 25.0),
                                                    /*Align(
                                                          child: Text(
                                                              "${user.data.firstname} "
                                                              "${user.data.lastname}",
                                                              style: TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          50,
                                                                          50,
                                                                          93,
                                                                          1),
                                                                  fontSize:
                                                                      20.0)),
                                                        ),*/
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
                                            /*SizedBox(height: 10.0),
                                                Align(
                                                  child: Text(
                                                      "San Francisco, USA",
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              50, 50, 93, 1),
                                                          fontSize: 18.0,
                                                          fontWeight:
                                                              FontWeight.w200)),
                                                ),*/
                                            /*Divider(
                                                  height: 10.0,
                                                  thickness: 1.5,
                                                  indent: 32.0,
                                                  endIndent: 32.0,
                                                ),*/
                                            // SizedBox(height: 15.0),
                                            /*Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 32.0,
                                                          right: 32.0),
                                                  child: Align(
                                                    child: Text(
                                                        "An artist of considerable range, Jessica name taken by Melbourne...",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    82,
                                                                    95,
                                                                    127,
                                                                    1),
                                                            fontSize: 17.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w200)),
                                                  ),
                                                ),*/
                                            // SizedBox(height: 15.0),
                                            /*Align(
                                                    child: Text("Show more",
                                                        style: TextStyle(
                                                            color: ArgonColors
                                                                .primary,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16.0))),
                                                SizedBox(height: 25.0),*/
                                            /*Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 25.0,
                                                          left: 25.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Album",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16.0,
                                                            color: ArgonColors
                                                                .text),
                                                      ),
                                                      Text(
                                                        "View All",
                                                        style: TextStyle(
                                                            color: ArgonColors
                                                                .primary,
                                                            fontSize: 13.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ],
                                                  ),
                                                ),*/
                                            /*SizedBox(
                                                  height: 250,
                                                  child: GridView.count(
                                                      primary: false,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 24.0,
                                                              vertical: 15.0),
                                                      crossAxisSpacing: 10,
                                                      mainAxisSpacing: 10,
                                                      crossAxisCount: 3,
                                                      children: <Widget>[
                                                        Container(
                                                            height: 100,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          6.0)),
                                                              image: DecorationImage(
                                                                  image: NetworkImage(
                                                                      "https://images.unsplash.com/photo-1501601983405-7c7cabaa1581?fit=crop&w=240&q=80"),
                                                                  fit: BoxFit
                                                                      .cover),
                                                            )),
                                                        Container(
                                                            decoration:
                                                                BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          6.0)),
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                  "https://images.unsplash.com/photo-1543747579-795b9c2c3ada?fit=crop&w=240&q=80hoto-1501601983405-7c7cabaa1581?fit=crop&w=240&q=80"),
                                                              fit:
                                                                  BoxFit.cover),
                                                        )),
                                                        Container(
                                                            decoration:
                                                                BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          6.0)),
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                  "https://images.unsplash.com/photo-1551798507-629020c81463?fit=crop&w=240&q=80"),
                                                              fit:
                                                                  BoxFit.cover),
                                                        )),
                                                        Container(
                                                            decoration:
                                                                BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          6.0)),
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                  "https://images.unsplash.com/photo-1470225620780-dba8ba36b745?fit=crop&w=240&q=80"),
                                                              fit:
                                                                  BoxFit.cover),
                                                        )),
                                                        Container(
                                                            decoration:
                                                                BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          6.0)),
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                  "https://images.unsplash.com/photo-1503642551022-c011aafb3c88?fit=crop&w=240&q=80"),
                                                              fit:
                                                                  BoxFit.cover),
                                                        )),
                                                        Container(
                                                            decoration:
                                                                BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          6.0)),
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                  "https://images.unsplash.com/photo-1482686115713-0fbcaced6e28?fit=crop&w=240&q=80"),
                                                              fit:
                                                                  BoxFit.cover),
                                                        )),
                                                      ]),
                                                )*/
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                              ),
                              /*FractionalTranslation(
                                  translation: Offset(0.0, -0.5),
                                  child: Align(
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "assets/img/img_avatar.png"),
                                      radius: 65.0,
                                      // maxRadius: 200.0,
                                    ),
                                    alignment: FractionalOffset(0.5, 0.0),
                                  ))*/
                            ]),
                          ])),
                  /*Center(
                    child: FutureBuilder<User>(
                      future: getUserInfoFromWS,
                      builder:
                          (BuildContext context, AsyncSnapshot<User> user) {
                        List<Widget> children;
                        if (user.hasData) {
                          // print(user);
                          children = <Widget>[
                            const Icon(
                              Icons.check_circle_outline,
                              color: Colors.green,
                              size: 60,
                            ),
                            Text("id =  ${user.data.id}"),
                            Text("username =  ${user.data.username}"),
                            Text("email =  ${user.data.email}"),
                            Text("number =  ${user.data.badge_number}"),
                            Text("birth date =  ${user.data.birth_date}"),
                            Text("birth city =  ${user.data.birth_city}"),
                          ];
                        } else if (user.hasError) {
                          children = <Widget>[
                            const Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 60,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Text('Error: ${user.error}'),
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
                  )*/
                ]))
              ]),
            )));
  }
}
