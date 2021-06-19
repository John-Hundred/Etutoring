import 'package:e_tutoring/constants/Theme.dart';
import 'package:e_tutoring/controller/controllerWS.dart';
import 'package:e_tutoring/l10n/l10n.dart';
import 'package:e_tutoring/model/userModel.dart';
import 'package:e_tutoring/provider/locale_provider.dart';
import 'package:e_tutoring/screens/change-password.dart';
import 'package:e_tutoring/screens/profile-edit.dart';
import 'package:e_tutoring/screens/router-dispatcher.dart';
import 'package:e_tutoring/utils/user_secure_storage.dart';
import 'package:e_tutoring/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:move_to_background/move_to_background.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

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
    //this.init();

    return new WillPopScope(
        onWillPop: () async {
          MoveToBackground.moveTaskToBack();
          return false;
        },
        child: ChangeNotifierProvider(
            create: (context) => LocaleProvider(),
            builder: (context, child) {
              // Locale myLocale = Localizations.localeOf(context);
              // print(myLocale);
              final provider = Provider.of<LocaleProvider>(context);
              // print(provider.locale);

              return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  routes: <String, WidgetBuilder>{
                    "/myapp": (BuildContext context) => new RouterDispatcher(),
                    "/profile": (BuildContext context) =>
                        new RouterDispatcher(),
                    "/course": (BuildContext context) => new RouterDispatcher(),
                    "/tutoring-course": (BuildContext context) =>
                        new RouterDispatcher(),
                    "/calendar": (BuildContext context) =>
                        new RouterDispatcher(),
                    "/settings": (BuildContext context) =>
                        new RouterDispatcher(),
                    "/tutor": (BuildContext context) => new RouterDispatcher(),
                    "/favorite-tutor": (BuildContext context) =>
                        new RouterDispatcher(),
                    "/chat": (BuildContext context) => new RouterDispatcher(),
                    "/tutor-course": (BuildContext context) =>
                        new RouterDispatcher(),
                    "/my-tutor-course": (BuildContext context) =>
                        new RouterDispatcher(),
                    "/my-tutor-timeslot": (BuildContext context) =>
                        new RouterDispatcher(),
                    "/my-tutor-reviews": (BuildContext context) =>
                        new RouterDispatcher(),
                    "/my-review-user": (BuildContext context) =>
                        new RouterDispatcher(),
                  },
                  locale: provider.locale,
                  supportedLocales: L10n.all,
                  localizationsDelegates: [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  home: Scaffold(
                    backgroundColor: Color.fromRGBO(205, 205, 205, 1),
                    appBar: AppBar(
                      title: Text(AppLocalizations.of(context).profile),
                      backgroundColor: Color.fromRGBO(213, 21, 36, 1),
                      actions: <Widget>[],
                    ),

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
                                          color:
                                              Color.fromRGBO(205, 205, 205, 1),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 0.0, bottom: 20.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      FutureBuilder<UserModel>(
                                                        future:
                                                            getUserInfoFromWS(
                                                                http.Client()),
                                                        builder: (BuildContext
                                                                context,
                                                            AsyncSnapshot<
                                                                    UserModel>
                                                                user) {
                                                          List<Widget> children;
                                                          if (user.hasData) {
                                                            // print(user.data);
                                                            children = <Widget>[
                                                              new FutureBuilder<
                                                                      String>(
                                                                  future: UserSecureStorage
                                                                      .getRole(),
                                                                  builder: (BuildContext
                                                                          context,
                                                                      AsyncSnapshot<
                                                                              String>
                                                                          role) {
                                                                    switch (role
                                                                        .connectionState) {
                                                                      case ConnectionState
                                                                          .none:
                                                                        return new Text(
                                                                            'Press button to start');
                                                                      case ConnectionState
                                                                          .waiting:
                                                                        return new Text(
                                                                            'Awaiting result...');
                                                                      default:
                                                                        if (role
                                                                            .hasError)
                                                                          return new Text(
                                                                              'Error: ${role.error}');
                                                                        else {
                                                                          //print(role);                                                                              role);
                                                                          return Column(
                                                                              children: [
                                                                                Container(
                                                                                    constraints: BoxConstraints(minWidth: 600),
                                                                                    color: Color.fromRGBO(205, 205, 205, 1),
                                                                                    child: DataTable(
                                                                                      dataRowHeight: 50,
                                                                                      dataRowColor: MaterialStateColor.resolveWith((states) => Colors.white),
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
                                                                                              AppLocalizations.of(context).lastname,
                                                                                              style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 15),
                                                                                            )),
                                                                                            DataCell(Text("${user.data.lastname}", style: TextStyle(fontSize: 15))),
                                                                                          ],
                                                                                        ),
                                                                                        DataRow(
                                                                                          cells: <DataCell>[
                                                                                            DataCell(Text(AppLocalizations.of(context).name, style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 15))),
                                                                                            DataCell(Text("${user.data.firstname}", style: TextStyle(fontSize: 15))),
                                                                                          ],
                                                                                        ),
                                                                                        DataRow(
                                                                                          cells: <DataCell>[
                                                                                            DataCell(Text('Email', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 15))),
                                                                                            DataCell(
                                                                                              Text(
                                                                                                "${user.data.email}",
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                        DataRow(
                                                                                          cells: <DataCell>[
                                                                                            DataCell(Text('Password', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 15))),
                                                                                            DataCell(Row(children: <Widget>[
                                                                                              Text("********", style: TextStyle(fontSize: 15)),
                                                                                              TextButton(
                                                                                                style: ButtonStyle(
                                                                                                  foregroundColor: MaterialStateProperty.all<Color>(ArgonColors.redUnito),
                                                                                                ),
                                                                                                onPressed: () {
                                                                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Changepassword()));
                                                                                                },
                                                                                                child: Text(AppLocalizations.of(context).change, style: TextStyle(fontSize: 15)),
                                                                                              )
                                                                                            ])),
                                                                                          ],
                                                                                        ),
                                                                                        DataRow(
                                                                                          cells: <DataCell>[
                                                                                            DataCell(Text(
                                                                                              'Numero di telefono',
                                                                                              style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
                                                                                            )),
                                                                                            DataCell(Text("${user.data.phone_number}")),
                                                                                          ],
                                                                                        ),
                                                                                        DataRow(
                                                                                          cells: <DataCell>[
                                                                                            DataCell(Text(
                                                                                              AppLocalizations.of(context).nationality,
                                                                                              style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 15),
                                                                                            )),
                                                                                            DataCell(Text("${user.data.nationality}", style: TextStyle(fontSize: 15))),
                                                                                          ],
                                                                                        ),
                                                                                        DataRow(
                                                                                          cells: <DataCell>[
                                                                                            DataCell(Text(AppLocalizations.of(context).date_of_birth, style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold))),
                                                                                            DataCell(Text("${user.data.birth_date}", style: TextStyle(fontSize: 15))),
                                                                                          ],
                                                                                        ),
                                                                                        DataRow(
                                                                                          cells: <DataCell>[
                                                                                            DataCell(Text(AppLocalizations.of(context).birth_place, style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold))),
                                                                                            DataCell(Text("${user.data.birth_city}", style: TextStyle(fontSize: 15))),
                                                                                          ],
                                                                                        ),
                                                                                        DataRow(
                                                                                          cells: <DataCell>[
                                                                                            DataCell(Text(AppLocalizations.of(context).residence_city, style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold))),
                                                                                            DataCell(Text("${user.data.residence_city}", style: TextStyle(fontSize: 15))),
                                                                                          ],
                                                                                        ),
                                                                                      ],
                                                                                    )),
                                                                                SizedBox(
                                                                                  height: 20,
                                                                                ),
                                                                                Container(
                                                                                    constraints: BoxConstraints(minWidth: 600),
                                                                                    color: Color.fromRGBO(205, 205, 205, 1),
                                                                                    child: DataTable(
                                                                                      dataRowHeight: 60,
                                                                                      dataRowColor: MaterialStateColor.resolveWith((states) => Colors.white),
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
                                                                                            DataCell(Text(AppLocalizations.of(context).role, style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 15))),
                                                                                            DataCell(Text("${user.data.role_name}", style: TextStyle(fontSize: 15))),
                                                                                          ],
                                                                                        ),
                                                                                        if (role.data == "Student")
                                                                                          DataRow(
                                                                                            cells: <DataCell>[
                                                                                              DataCell(Text(AppLocalizations.of(context).number, style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 15))),
                                                                                              DataCell(Text("${user.data.badge_number}", style: TextStyle(fontSize: 15))),
                                                                                            ],
                                                                                          ),
                                                                                        if (role.data == "Student")
                                                                                          DataRow(
                                                                                            cells: <DataCell>[
                                                                                              DataCell(Text(AppLocalizations.of(context).degree_course, style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 15))),
                                                                                              DataCell(Text("${user.data.degree_name} (" + "${user.data.degree_athenaeum})", style: TextStyle(fontSize: 15))),
                                                                                            ],
                                                                                          ),
                                                                                        if (role.data == "Student")
                                                                                          DataRow(
                                                                                            cells: <DataCell>[
                                                                                              DataCell(Text(AppLocalizations.of(context).type, style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 15))),
                                                                                              DataCell(Text("${user.data.degree_type_note} (" + "${user.data.degree_type_name})", style: TextStyle(fontSize: 15))),
                                                                                            ],
                                                                                          ),
                                                                                        if (role.data == "Student")
                                                                                          DataRow(
                                                                                            cells: <DataCell>[
                                                                                              DataCell(Text(AppLocalizations.of(context).headquarters, style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 15))),
                                                                                              DataCell(Text("${user.data.degree_location}", style: TextStyle(fontSize: 15))),
                                                                                            ],
                                                                                          ),
                                                                                        if (role.data == "Student")
                                                                                          DataRow(
                                                                                            cells: <DataCell>[
                                                                                              DataCell(Text(AppLocalizations.of(context).curriculum, style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 15))),
                                                                                              DataCell(Text("${user.data.degree_path_name}", style: TextStyle(fontSize: 15))),
                                                                                            ],
                                                                                          ),
                                                                                        /*if (role.data == "Tutor")
                                                                                          DataRow(
                                                                                            cells: <DataCell>[
                                                                                              DataCell(Text(AppLocalizations.of(context).courses, style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 15))),
                                                                                              DataCell(
                                                                                                Container(
                                                                                                  width: 400,
                                                                                                  child: ListView.builder(
                                                                                                    shrinkWrap: true,
                                                                                                    itemCount: user.data.courses.length,
                                                                                                    itemBuilder: (BuildContext context, int index) {
                                                                                                      return Text(user.data.courses[index]['course_name'].toString());
                                                                                                    },
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),*/
                                                                                        /*if (role.data == "Tutor")
                                                                                          DataRow(
                                                                                            cells: <DataCell>[
                                                                                              DataCell(Text(AppLocalizations.of(context).time_slot, style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 15))),
                                                                                              DataCell(
                                                                                                Container(
                                                                                                  width: 600,
                                                                                                  child: ListView.builder(
                                                                                                    shrinkWrap: true,
                                                                                                    itemCount: user.data.time_slot.length,
                                                                                                    itemBuilder: (BuildContext context, int index) {
                                                                                                      return Text(user.data.time_slot[index]['day'].toString() + " | " + user.data.time_slot[index]['hour_from'].toString() + ' - ' + user.data.time_slot[index]['hour_to'].toString());
                                                                                                    },
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),*/
                                                                                      ],
                                                                                    )),
                                                                              ]);
                                                                        }
                                                                    }
                                                                  })
                                                            ];
                                                          } else if (user
                                                              .hasError) {
                                                            children = <Widget>[
                                                              const Icon(
                                                                Icons
                                                                    .error_outline,
                                                                color:
                                                                    Colors.red,
                                                                size: 60,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            15),
                                                                child: Text(
                                                                    'Error: ${user.error}'),
                                                              )
                                                            ];
                                                          } else {
                                                            children =
                                                                const <Widget>[
                                                              SizedBox(
                                                                child: CircularProgressIndicator(
                                                                    backgroundColor:
                                                                        ArgonColors
                                                                            .redUnito),
                                                                width: 60,
                                                                height: 60,
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            15),
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
                                                              children:
                                                                  children,
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
                    floatingActionButton: new FloatingActionButton(
                      backgroundColor: ArgonColors.redUnito,
                      child: new Icon(Icons.edit),
                      onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileEdit()))
                      },
                    ),
                  ));
            }));
  }
}
