import 'dart:convert';

import 'package:argon_flutter/config/config.dart';
import 'package:argon_flutter/constants/Theme.dart';
import 'package:argon_flutter/screens/login.dart';
import 'package:argon_flutter/utils/user_secure_storage.dart';
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String email;

  // For CircularProgressIndicator.
  bool visible = false;

  @override
  void initState() {
    super.initState();
  }

  Future init() async {
    final email = await UserSecureStorage.getEmail() ?? '';
    this.email = email;
  }

  Future userDelete() async {
    setState(() {
      // Showing CircularProgressIndicator.
      visible = true;
    });

    try {
      // Getting value from Controller
      String email = await UserSecureStorage.getEmail();
      // Store all data with Param Name: json format
      var data = {
        'email': email,
      };
      // print(json.encode(data));
      // Starting Web API Call.
      // http method: POST
      var response = await http
          .post(Uri.https(authority, unencodedPath + 'user_delete.php'),
              body: json.encode(data))
          .timeout(const Duration(seconds: 8));
      // print(response.body);
      var message = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (message == 'User deleted successfully') {
          // Delete email from secure storage
          UserSecureStorage.delete('email');
          // Delete password from secure storage
          UserSecureStorage.delete('password');
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Login()));
        } else {}
      } else {}
      setState(() {
        // Showing CircularProgressIndicator.
        visible = false;
      });
    } on Exception catch ($e) {
      print('error caught: ' + $e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error. Verify Your Connection.'),
        backgroundColor: Colors.redAccent,
      ));
      setState(() {
        visible = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Settings'),
          backgroundColor: Color.fromRGBO(213, 21, 36, 1)),
      // Nav Bar (title: 'Profilo', bgColor: Color.fromRGBO(213, 21, 36, 1)),
      drawer: ArgonDrawer("settings"),
      body: Stack(children: <Widget>[
        SafeArea(
            child: ListView(children: [
          Padding(
              padding:
                  const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("Change Language TODO"),
                    Text("Other settings"),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 34.0, right: 34.0, top: 8),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(52),
                            primary: ArgonColors.redUnito,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => new AlertDialog(
                                      title: new Text('Are you sure?'),
                                      content: new Text(
                                          'Do you want to delete your account?\n'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(false),
                                          child: new Text('No'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(true);
                                            userDelete();
                                          },
                                          child: new Text('Yes'),
                                        ),
                                      ],
                                    ));
                          },
                          child: Padding(
                              padding: EdgeInsets.only(
                                  left: 16.0, right: 16.0, top: 12, bottom: 12),
                              child: Text("Delete User",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0))),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Visibility(
                      visible: visible,
                      child: Center(
                          child: Container(
                              margin: EdgeInsets.only(bottom: 30),
                              child: CircularProgressIndicator(
                                backgroundColor: ArgonColors.redUnito,
                              ))),
                    ),
                  ]))
        ]))
      ]),
    );
  }
}
