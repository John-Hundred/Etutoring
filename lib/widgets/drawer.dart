import 'package:argon_flutter/screens/user_page.dart';
import 'package:argon_flutter/utils/user_secure_storage.dart';
import 'package:flutter/material.dart';

import 'package:argon_flutter/constants/Theme.dart';

import 'package:argon_flutter/widgets/drawer-tile.dart';

// ignore: must_be_immutable
class ArgonDrawer extends StatelessWidget {
  final String currentPage;

  // bool visible = false;

  ArgonDrawer({this.currentPage});

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
                  child: Image.asset("assets/img/argon-logo.png"),
                ),
              ),
            )),
        Expanded(
          flex: 2,
          child: ListView(
            padding: EdgeInsets.only(top: 24, left: 16, right: 16),
            children: [
              /*DrawerTile(
                  icon: Icons.login,
                  onTap: () {
                    if (currentPage != "Login")
                      Navigator.pushReplacementNamed(context, '/login');
                  },
                  iconColor: ArgonColors.primary,
                  title: "Login",
                  isSelected: currentPage == "Login" ? true : false),*/
              DrawerTile(
                  icon: Icons.person,
                  onTap: () {
                    if (currentPage != "profile-screen")
                      Navigator.pushReplacementNamed(
                          context, '/profile-screen');
                  },
                  iconColor: ArgonColors.primary,
                  title: "Profilo",
                  isSelected: currentPage == "profile-screen" ? true : false),
              DrawerTile(
                  icon: Icons.cloud_circle_sharp,
                  onTap: () {
                    if (currentPage != "course")
                      Navigator.pushReplacementNamed(context, '/course');
                  },
                  iconColor: ArgonColors.primary,
                  title: "Course",
                  isSelected: currentPage == "course" ? true : false),
              DrawerTile(
                  icon: Icons.home,
                  onTap: () {
                    if (currentPage != "Home")
                      Navigator.pushReplacementNamed(context, '/home');
                  },
                  iconColor: ArgonColors.primary,
                  title: "Home",
                  isSelected: currentPage == "Home" ? true : false),
              DrawerTile(
                  icon: Icons.pie_chart,
                  onTap: () {
                    if (currentPage != "Profile")
                      Navigator.pushReplacementNamed(context, '/profile');
                  },
                  iconColor: ArgonColors.warning,
                  title: "Profile",
                  isSelected: currentPage == "Profile" ? true : false),
              DrawerTile(
                  icon: Icons.account_circle,
                  onTap: () {
                    if (currentPage != "Account")
                      Navigator.pushReplacementNamed(context, '/account');
                  },
                  iconColor: ArgonColors.info,
                  title: "Account",
                  isSelected: currentPage == "Account" ? true : false),
              DrawerTile(
                  icon: Icons.settings_input_component,
                  onTap: () {
                    if (currentPage != "Elements")
                      Navigator.pushReplacementNamed(context, '/elements');
                  },
                  iconColor: ArgonColors.error,
                  title: "Elements",
                  isSelected: currentPage == "Elements" ? true : false),
              DrawerTile(
                  icon: Icons.apps,
                  onTap: () {
                    if (currentPage != "Articles")
                      Navigator.pushReplacementNamed(context, '/articles');
                  },
                  iconColor: ArgonColors.primary,
                  title: "Articles",
                  isSelected: currentPage == "Articles" ? true : false),
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
                      onTap: () {
                        // this.visible = true;
                        // print(this.visible);
                        UserSecureStorage.getEmail();
                        UserSecureStorage.getPassword();
                        // Delete email from secure storage
                        UserSecureStorage.delete('email');
                        // Delete password from secure storage
                        UserSecureStorage.delete('password');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserPage()));
                      },
                      iconColor: ArgonColors.primary,
                      title: "Logout",
                      isSelected: currentPage == "Logout" ? true : false),
                  /*Visibility(
                visible: visible,
                child: Center(
                    child: Container(
                        margin: EdgeInsets.only(bottom: 30),
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.black,
                        ))),
              )*/
                  /* Padding(
                    padding:
                        const EdgeInsets.only(top: 16.0, left: 16, bottom: 8),
                    child: Text("DOCUMENTATION",
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          fontSize: 15,
                        )),
                  ),*/
                ],
              )),
        ),
      ]),
    ));
  }
}
