import 'dart:ui';
import 'package:argon_flutter/widgets/button_widget.dart';
import 'package:flutter/material.dart';

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

  final double height = window.physicalSize.height;

  // For CircularProgressIndicator.
  bool visible = false;

  // Initially password is obscure
  bool _obscureText = true;
  bool _obscureTextConfirm = true;

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

  @override
  Widget build(BuildContext context) {
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
                      buildPassword(),
                      const SizedBox(height: 12),
                      buildConfirmPassword(),
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

  Widget buildPassword() => buildTitle(
        title: 'Password',
        child: TextFormField(
          obscureText: _obscureText,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            return null;
          },
          controller: passwordController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(),
            hintText: 'Password',
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

  Widget buildConfirmPassword() => buildTitle(
        title: 'Confirm Password',
        child: TextFormField(
          obscureText: _obscureTextConfirm,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please confirm your password';
            }
            if (value != passwordController.text)
              return 'The passwords you entered do not match.';
            return null;
          },
          controller: confirmPasswordController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(),
            hintText: 'Password',
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
        /*if (formKey.currentState.validate()) {
          userSignin();
        }*/
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
