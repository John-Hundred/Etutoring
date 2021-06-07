import 'dart:convert';
import 'dart:ui';
import 'package:argon_flutter/config/config.dart';
import 'package:argon_flutter/utils/user_secure_storage.dart';
import 'package:argon_flutter/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:argon_flutter/constants/Theme.dart';

class Changepassword extends StatefulWidget {
  @override
  _ChangepasswordState createState() => _ChangepasswordState();
}

class _ChangepasswordState extends State<Changepassword> {
  @override
  void initState() {
    super.initState();
  }

  String email;
  String password;

  final double height = window.physicalSize.height;

  // For CircularProgressIndicator.
  bool visible = false;

  // Initially password is obscure
  bool _obscureTextOld = true;
  bool _obscureText = true;
  bool _obscureTextConfirm = true;

  // Toggles the password show status
  void _toggleOld() {
    setState(() {
      _obscureTextOld = !_obscureTextOld;
    });
  }

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  // Toggles the password show status
  void _toggleConfirm() {
    setState(() {
      _obscureTextConfirm = !_obscureTextConfirm;
    });
  }

  final formKey = GlobalKey<FormState>();

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final passwordOldController = TextEditingController();

  Future init() async {
    final email = await UserSecureStorage.getEmail() ?? '';
    final password = await UserSecureStorage.getPassword() ?? '';
    this.email = email;
    this.password = password;
  }

  // CONTROLLER
  Future userChangePassword() async {
    try {
      setState(() {
        // Showing CircularProgressIndicator.
        visible = true;
      });

      // Getting value from Controller
      String email = await UserSecureStorage.getEmail();
      String password = passwordController.text.trim();

      var data = {
        'email': email,
        'password': password,
      };
      // print(json.encode(data));

      var response = await http
          .post(
              Uri.https(authority, unencodedPath + 'user_change_password.php'),
              body: json.encode(data))
          .timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        var message = jsonDecode(response.body);
        // print(message);
        setState(() {
          visible = false;
        });
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text(message),
              actions: <Widget>[
                TextButton(
                  child: new Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
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
    this.init();
    return Scaffold(
        appBar: AppBar(
            title: const Text('Change Password'),
            backgroundColor: Color.fromRGBO(213, 21, 36, 1)),
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            Container(
                decoration:
                    BoxDecoration(color: Color.fromRGBO(205, 205, 205, 1))),
            SafeArea(
              child: Scaffold(
                body: Form(
                  key: formKey,
                  child: ListView(
                    padding: EdgeInsets.all(8),
                    children: [
                      const SizedBox(height: 12),
                      buildOldPassword(),
                      const SizedBox(height: 12),
                      buildNewPassword(),
                      const SizedBox(height: 12),
                      buildConfirmNewPassword(),
                      const SizedBox(height: 12),
                      buildButton(),
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
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Widget buildOldPassword() => buildTitle(
        title: 'Old Password',
        child: TextFormField(
          obscureText: _obscureTextOld,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your old password';
            }
            if (value != this.password) {
              return 'The old password you entered do not match.';
            }
            return null;
          },
          controller: passwordOldController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(),
            hintText: 'Old Password',
            prefixIcon: Icon(Icons.lock),
            suffixIcon: GestureDetector(
              onTap: () async {
                _toggleOld();
              },
              child: Icon(
                _obscureTextOld ? Icons.visibility : Icons.visibility_off,
                color: Colors.black,
              ),
            ),
          ),
        ),
      );

  Widget buildNewPassword() => buildTitle(
        title: 'New Password',
        child: TextFormField(
          obscureText: _obscureText,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your new password.';
            }
            if (value.length < 4) {
              return 'Enter a password of at least 4 characters.';
            }
            if (value == this.password) {
              return 'The new password is the same as the old one.';
            }
            return null;
          },
          controller: passwordController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(),
            hintText: 'New Password',
            prefixIcon: Icon(Icons.lock),
            suffixIcon: GestureDetector(
              onTap: () async {
                // (this.emailController.text);
                _toggle();
              },
              child: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                color: Colors.black,
              ),
            ),
          ),
        ),
      );

  Widget buildConfirmNewPassword() => buildTitle(
        title: 'Confirm Password',
        child: TextFormField(
          obscureText: _obscureTextConfirm,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please confirm your new password';
            }
            if (value != passwordController.text)
              return 'The new passwords you entered do not match.';
            return null;
          },
          controller: confirmPasswordController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(),
            hintText: 'Confirm New Password',
            prefixIcon: Icon(Icons.lock),
            suffixIcon: GestureDetector(
              onTap: () async {
                _toggleConfirm();
              },
              child: Icon(
                _obscureTextConfirm ? Icons.visibility : Icons.visibility_off,
                color: Colors.black,
              ),
            ),
          ),
        ),
      );

  Widget buildButton() => ButtonWidget(
      pressed: true,
      text: 'Change Password',
      color: ArgonColors.redUnito,
      onClicked: () {
        if (formKey.currentState.validate()) {
          userChangePassword();
        }
      });

  Widget buildTitle({
    String title,
    Widget child,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          child,
        ],
      );
}
