import 'package:e_tutoring/utils/user_secure_storage.dart';
import 'package:flutter/material.dart';

import 'package:e_tutoring/constants/Theme.dart';

import 'package:e_tutoring/widgets/drawer-tile.dart';

import '../main.dart';

// ignore: must_be_immutable
class ArgonDrawer extends StatefulWidget {
  final String currentPage;
  const ArgonDrawer(this.currentPage);
  @override
  _ArgonDrawerState createState() => _ArgonDrawerState();
}

class _ArgonDrawerState extends State<ArgonDrawer> {
  // For CircularProgressIndicator.
  bool visible = false;

  @override
  void initState() {
    super.initState();
  }

  Future wait() async {
    await new Future.delayed(const Duration(seconds: 5), () {});
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: ArgonColors.white,
      child: Column(children: [
        Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.85,
            child: SafeArea(
              bottom: false,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: new Row(children: <Widget>[
                    Image.asset("assets/img/logo_size_1.jpg"),
                    Text("E-Tutoring")
                  ]),
                ),
              ),
            )),
        Expanded(
          flex: 2,
          child: ListView(
            padding: EdgeInsets.only(top: 24, left: 16, right: 16),
            children: [
              DrawerTile(
                  icon: Icons.person,
                  onTap: () {
                    if (widget.currentPage != "profile")
                      Navigator.pushReplacementNamed(context, '/profile');
                  },
                  iconColor: ArgonColors.black,
                  title: "Profilo",
                  isSelected: widget.currentPage == "profile" ? true : false),
              DrawerTile(
                  icon: Icons.my_library_books,
                  onTap: () {
                    if (widget.currentPage != "Tutoring Course")
                      Navigator.pushReplacementNamed(
                          context, '/tutoring-course');
                  },
                  iconColor: ArgonColors.black,
                  title: "My Tutoring Course",
                  isSelected:
                      widget.currentPage == "Tutoring Course" ? true : false),
              DrawerTile(
                  icon: Icons.menu_book_rounded,
                  onTap: () {
                    if (widget.currentPage != "course")
                      Navigator.pushReplacementNamed(context, '/course');
                  },
                  iconColor: ArgonColors.black,
                  title: "Course",
                  isSelected: widget.currentPage == "course" ? true : false),
              DrawerTile(
                  icon: Icons.help_center_outlined,
                  onTap: () {
                    /*if (widget.currentPage != "course")
                      Navigator.pushReplacementNamed(context, '/course');*/
                  },
                  iconColor: ArgonColors.black,
                  title: "Tutor",
                  isSelected: widget.currentPage == "Tutor" ? true : false),
              DrawerTile(
                  icon: Icons.calendar_today,
                  onTap: () {
                    if (widget.currentPage != "calendar")
                      Navigator.pushReplacementNamed(context, '/calendar');
                  },
                  iconColor: ArgonColors.black,
                  title: "Calendar",
                  isSelected: widget.currentPage == "calendar" ? true : false),
              DrawerTile(
                  icon: Icons.settings,
                  onTap: () {
                    if (widget.currentPage != "settings")
                      Navigator.pushReplacementNamed(context, '/settings');
                  },
                  iconColor: ArgonColors.black,
                  title: "Settings",
                  isSelected: widget.currentPage == "settings" ? true : false),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
              padding: EdgeInsets.only(left: 8, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(height: 4, thickness: 0, color: ArgonColors.muted),
                  DrawerTile(
                      icon: Icons.logout,
                      onTap: () async {
                        setState(() {
                          visible = true;
                        });
                        await Future.delayed(const Duration(seconds: 1), () {});

                        // Delete email from secure storage
                        UserSecureStorage.delete('email');
                        // Delete password from secure storage
                        UserSecureStorage.delete('password');

                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MyApp()));
                      },
                      iconColor: ArgonColors.black,
                      title: "Logout",
                      isSelected:
                          widget.currentPage == "Logout" ? true : false),
                  FutureBuilder(
                      future: wait(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(snapshot.data);
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        // By default, show a loading spinner
                        return Visibility(
                            visible: visible,
                            child: Center(
                                child: CircularProgressIndicator(
                              backgroundColor: ArgonColors.redUnito,
                            )));
                      }),
                ],
              )),
        ),
      ]),
    ));
  }
}
