import 'dart:ui';
import 'package:argon_flutter/config/config.dart';
import 'package:argon_flutter/screens/privacy-policy.dart';
import 'package:argon_flutter/widgets/button_widget.dart';
import 'package:argon_flutter/widgets/title_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:argon_flutter/constants/Theme.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:select_form_field/select_form_field.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _checkboxValue = false;

  final double height = window.physicalSize.height;

  // For CircularProgressIndicator.
  bool visible = false;

  // Initially password is obscure
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();

  final List<Map<String, dynamic>> _items = [
    {
      'value': 'Fisica Triennale',
      'label': 'Fisica Triennale',
      //'enable': false,
      //'icon': Icon(Icons.grade),
    },
    {
      'value': 'Fisica Magistrale',
      'label': 'Fisica Magistrale',
      //'enable': false,
      //'icon': Icon(Icons.grade),
    },
    {
      'value': 'Informatica Triennale',
      'label': 'Informatica Triennale',
      //'icon': Icon(Icons.stop),
    },
    {
      'value': 'Informatica Magistrale',
      'label': 'Informatica Magistrale',
      //'icon': Icon(Icons.fiber_manual_record),
      // 'textStyle': TextStyle(color: Colors.red),
    },
    {
      'value': 'Matematica Triennale',
      'label': 'Matematica Triennale',
      //'enable': false,
      //'icon': Icon(Icons.grade),
    },
    {
      'value': 'Matematica Magistrale',
      'label': 'Matematica Magistrale',
      //'enable': false,
      //'icon': Icon(Icons.grade),
    },
  ];

  final List<Map<String, dynamic>> _roleItems = [
    {
      'value': 'Studente',
      'label': 'Studente',
      //'enable': false,
      //'icon': Icon(Icons.grade),
    },
    {
      'value': 'Tutor',
      'label': 'Tutor',
      //'enable': false,
      //'icon': Icon(Icons.grade),
    },
    /*{
      'value': 'Tutor Studente',
      'label': 'Tutor Studente',
      //'enable': false,
      //'icon': Icon(Icons.grade),
    },*/
  ];

  // CONTROLLER
  Future userSignin() async {
    setState(() {
      // Showing CircularProgressIndicator.
      visible = true;
    });

    try {
      // Getting value from Controller
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String firstname = firstnameController.text.trim();
      String lastname = lastnameController.text.trim();
      // Store all data with Param Name: json format
      var data = {
        'email': email,
        'password': password,
        'firstname': firstname,
        'lastname': lastname
      };

      // Starting Web API Call.
      // http method: POST
      var response = await http
          .post(Uri.https(authority, unencodedPath + 'user_signup.php'),
              body: json.encode(data))
          .timeout(const Duration(seconds: 8));
      // print(response.body);
      if (response.statusCode == 200) {
        var message = jsonDecode(response.body);
        if (message == 'New record created successfully') {
          showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    title: const Text('Sign Up'),
                    content: const Text('User sign up with success'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, 'OK');
                          Navigator.pushNamed(context, '/login');
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ));
        } else {
          showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    title: const Text('Sign Up'),
                    content: const Text('Error. Try Again'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, 'OK');
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ));
        }
      } else {
        showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: const Text('Sign Up'),
                  content: const Text('Error. Try Again'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, 'OK');
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ));
      }
      setState(() {
        // Showing CircularProgressIndicator.
        visible = false;
      });
    } on Exception {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Sign up Error. Verify Your Connection.'),
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
            title: const Text('Sign Up'),
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
                    padding: EdgeInsets.all(16),
                    children: [
                      const SizedBox(height: 10),
                      Image.asset('assets/img/logo_size_2.jpg',
                          height: 100, width: 100),
                      TitleWidget(
                        icon: Icons.login,
                        text: 'Sign Up',
                        color: ArgonColors.redUnito,
                        fontSize: 36,
                      ),
                      const SizedBox(height: 32),
                      buildEmail(),
                      const SizedBox(height: 12),
                      buildPassword(),
                      const SizedBox(height: 12),
                      SelectFormField(
                        // initialValue: 'circle',
                        // icon: Icon(Icons.format_shapes),
                        labelText: 'Seleziona il tuo Corso di Laurea',
                        items: _items,
                        onChanged: (val) => print(val),
                        onSaved: (val) => print(val),
                      ),
                      SelectFormField(
                        // initialValue: 'circle',
                        // icon: Icon(Icons.format_shapes),
                        labelText: 'Seleziona il ruolo',
                        items: _roleItems,
                        onChanged: (val) => print(val),
                        onSaved: (val) => print(val),
                      ),
                      const SizedBox(height: 12),
                      buildFistname(),
                      const SizedBox(height: 12),
                      buildLastname(),
                      const SizedBox(height: 12),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8.0, top: 0, bottom: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                                activeColor: ArgonColors.primary,
                                onChanged: (bool newValue) =>
                                    setState(() => _checkboxValue = newValue),
                                value: _checkboxValue),
                            Text("I agree with the",
                                style: TextStyle(
                                    color: ArgonColors.black, fontSize: 15)),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PrivacyPolicy()));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Text("Privacy Policy",
                                      style: TextStyle(
                                          color: ArgonColors.redUnito,
                                          fontSize: 15)),
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      buildSignInButton(),
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

  Widget buildEmail() => buildTitle(
        title: 'E-mail',
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            if (!EmailValidator.validate(value)) {
              return 'Please enter a valid email';
            }
            return null;
          },
          controller: emailController,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(),
              hintText: 'Your Email',
              prefixIcon: Icon(Icons.email)),
        ),
      );

  Widget buildFistname() => buildTitle(
        title: 'Firstname',
        child: TextFormField(
          validator: (value) {
            return null;
          },
          controller: firstnameController,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(),
              hintText: 'Your Firstname',
              prefixIcon: Icon(Icons.person)),
        ),
      );

  Widget buildLastname() => buildTitle(
        title: 'Lastname',
        child: TextFormField(
          validator: (value) {
            return null;
          },
          controller: lastnameController,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(),
              hintText: 'Your Lastname',
              prefixIcon: Icon(Icons.person)),
        ),
      );

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
            hintText: 'Your Password',
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

  Widget buildSignInButton() => ButtonWidget(
      pressed: _checkboxValue,
      text: 'Sign Up',
      color: ArgonColors.redUnito,
      onClicked: () {
        if (formKey.currentState.validate()) {
          userSignin();
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
