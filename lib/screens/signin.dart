import 'dart:ui';
import 'package:argon_flutter/config/config.dart';
import 'package:argon_flutter/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:argon_flutter/constants/Theme.dart';

//widgets
import 'package:argon_flutter/widgets/input.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  bool _checkboxValue = false;

  final double height = window.physicalSize.height;

  // For CircularProgressIndicator.
  bool visible = false;

  // Initially password is obscure
  bool _obscureText = true;

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();

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
          .post(Uri.http(authority, unencodedPath + 'user_signin.php'),
              body: json.encode(data))
          .timeout(const Duration(seconds: 8));
      print(response.body);
      /*switch (response.statusCode) {
        case 200:
          // Getting Server response into variable.
          var message = jsonDecode(response.body);

          // If the Response Message is Matched.
          if (message == 'Login Matched') {
            await UserSecureStorage.setEmail(emailController.text);
            await UserSecureStorage.setPassword(passwordController.text);
            // Hiding the CircularProgressIndicator.
            //print(emailController.text);
            //print(passwordController.text);
            setState(() {
              visible = false;
            });

            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Profile()));
          } else {
            // UserSecureStorage.delete('email');
            //  UserSecureStorage.delete('password');

            // If Email or Password did not Matched.
            // Hiding the CircularProgressIndicator.
            setState(() {
              visible = false;
            });

            // Showing Alert Dialog with Response JSON Message.
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
                        this.emailController.text = email;
                        this.passwordController.text = password;
                      },
                    ),
                  ],
                );
              },
            );
          }
          break;
      }*/
    } on Exception {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Login Error. Verify Your Connection.'),
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
            title: const Text('Sign In'),
            backgroundColor: Color.fromRGBO(213, 21, 36, 1)),
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            /*Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/img/register-bg.png"),
                      fit: BoxFit.cover)),
            ),*/
            SafeArea(
              child: ListView(children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 16, left: 24.0, right: 24.0, bottom: 32),
                  child: Card(
                      elevation: 5,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Column(
                        children: [
                          /*Container(
                              height: MediaQuery.of(context).size.height * 0.15,
                              decoration: BoxDecoration(
                                  color: ArgonColors.white,
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 0.5,
                                          color: ArgonColors.muted))),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  /*Center(
                                      child: Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text("Sign up with",
                                        style: TextStyle(
                                            color: ArgonColors.text,
                                            fontSize: 16.0)),
                                  )),*/
                                  /*Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          // width: 0,
                                          height: 36,
                                          child: ElevatedButton(
                                              /*textColor: ArgonColors.primary,
                                              color: ArgonColors.secondary,*/
                                              onPressed: () {},
                                              /*shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(4)),*/
                                              child: Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 10,
                                                      top: 10,
                                                      left: 14,
                                                      right: 14),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Icon(
                                                          FontAwesomeIcons
                                                              .github,
                                                          size: 13),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text("GITHUB",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 13))
                                                    ],
                                                  ))),
                                        ),
                                        Container(
                                          // width: 0,
                                          height: 36,
                                          child: ElevatedButton(
                                              /*textColor: ArgonColors.primary,
                                              color: ArgonColors.secondary,*/
                                              onPressed: () {},
                                              /*shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(4)),*/
                                              child: Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 10,
                                                      top: 10,
                                                      left: 8,
                                                      right: 8),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Icon(
                                                          FontAwesomeIcons
                                                              .facebook,
                                                          size: 13),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text("FACEBOOK",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 13))
                                                    ],
                                                  ))),
                                        ),
                                      ],
                                    ),
                                  ),*/
                                  // Divider()
                                ],
                              )),*/
                          Container(
                              height: MediaQuery.of(context).size.height * 0.63,
                              // color: Color.fromRGBO(244, 245, 247, 1),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 24.0, bottom: 24.0),
                                        child: Center(
                                          child: Text(
                                              "Or sign up with the classic way",
                                              style: TextStyle(
                                                  color: ArgonColors.text,
                                                  fontWeight: FontWeight.w200,
                                                  fontSize: 16)),
                                          /*child: ListView(
                                              padding: EdgeInsets.all(16),
                                              children: [
                                                const SizedBox(height: 50),
                                                Image.asset(
                                                    'assets/img/logo_size_2.jpg',
                                                    height: 100,
                                                    width: 100),
                                                TitleWidget(
                                                    icon: Icons.login,
                                                    text:
                                                        'Welcome to\nE-tutoring',
                                                    color: ArgonColors.redUnito)
                                              ]),*/
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Input(
                                              placeholder: "Email",
                                              prefixIcon: Icon(Icons.email),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Input(
                                                placeholder: "Password",
                                                prefixIcon: Icon(Icons.lock)),
                                          ),
                                          /*Padding(
                                            padding: const EdgeInsets.only(
                                                left: 24.0),
                                            child: RichText(
                                                text: TextSpan(
                                                    text: "password strength: ",
                                                    style: TextStyle(
                                                        color:
                                                            ArgonColors.muted),
                                                    children: [
                                                  TextSpan(
                                                      text: "strong",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: ArgonColors
                                                              .success))
                                                ])),
                                          ),*/
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Input(
                                                placeholder: "Firstname",
                                                prefixIcon: Icon(Icons.person)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Input(
                                                placeholder: "Lastname",
                                                prefixIcon: Icon(Icons.person)),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, top: 0, bottom: 16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Checkbox(
                                                activeColor:
                                                    ArgonColors.primary,
                                                onChanged: (bool newValue) =>
                                                    setState(() =>
                                                        _checkboxValue =
                                                            newValue),
                                                value: _checkboxValue),
                                            Text("I agree with the",
                                                style: TextStyle(
                                                    color: ArgonColors.muted,
                                                    fontWeight:
                                                        FontWeight.w200)),
                                            GestureDetector(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                      context, '/pro');
                                                },
                                                child: Container(
                                                  margin:
                                                      EdgeInsets.only(left: 5),
                                                  child: Text("Privacy Policy",
                                                      style: TextStyle(
                                                          color: ArgonColors
                                                              .primary)),
                                                )),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 16),
                                        child: Center(
                                          child: TextButton(
                                            /*textColor: ArgonColors.white,
                                            color: ArgonColors.primary,*/
                                            onPressed: () {
                                              // Respond to button press
                                              Navigator.pushNamed(
                                                  context, '/home');
                                            },
                                            /*shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                            ),*/
                                            child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 16.0,
                                                    right: 16.0,
                                                    top: 12,
                                                    bottom: 12),
                                                child: Text("REGISTER",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16.0))),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ))
                        ],
                      )),
                ),
              ]),
            )
          ],
        ));
  }
}
