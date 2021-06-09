import 'dart:ui';
import 'package:argon_flutter/config/config.dart';
import 'package:argon_flutter/controller/controllerWS.dart';
import 'package:argon_flutter/screens/privacy-policy.dart';
import 'package:argon_flutter/widgets/button_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:argon_flutter/constants/Theme.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String dropDownValueDegree;
  String dropDownValueCurriculum;
  String dropDownValueRole = 'Student';

  String degreeNameSelected = "Fisica";
  String degreeTypeNoteSelected = "Laurea Triennale";

  @override
  void initState() {
    super.initState();
  }

  bool _checkboxValue = false;

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
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // CONTROLLER
  Future userSignup() async {
    setState(() {
      // Showing CircularProgressIndicator.
      visible = true;
    });

    try {
      // Getting value from Controller
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      // Store all data with Param Name: json format
      var data = {
        'email': email,
        'password': password,
        'degree_name': degreeNameSelected.toString(),
        'degree_type': degreeTypeNoteSelected.toString(),
        'curriculum': dropDownValueCurriculum.toString(),
        'role': dropDownValueRole.toString()
      };
      // print(json.encode(data));
      // Starting Web API Call.
      // http method: POST
      var response = await http
          .post(Uri.https(authority, unencodedPath + 'user_signup.php'),
              headers: <String, String>{'authorization': basicAuth},
              body: json.encode(data))
          .timeout(const Duration(seconds: 8));
      // print(response.body);
      var message = jsonDecode(response.body);
      if (response.statusCode == 200) {
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
                    title: Text("Sign Up"),
                    content: Text(message.toString()),
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
                  content: Text(message.toString()),
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
    } on Exception catch ($e) {
      print('error caught: ' + $e.toString());
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
                    padding: EdgeInsets.all(8),
                    children: [
                      //const SizedBox(height: 10),
                      /*Image.asset('assets/img/logo_size_2.jpg',
                          height: 100, width: 100),*/
                      /*TitleWidget(
                        icon: Icons.login,
                        text: 'Sign Up',
                        color: ArgonColors.redUnito,
                        fontSize: 20,
                      ),*/
                      const SizedBox(height: 20),
                      buildEmail(),
                      const SizedBox(height: 12),
                      buildPassword(),
                      const SizedBox(height: 12),
                      buildConfirmPassword(),
                      const SizedBox(height: 12),
                      buildRole(),
                      const SizedBox(height: 12),
                      buildDegree(),
                      const SizedBox(height: 12),
                      buildCurriculum(),
                      const SizedBox(height: 20),
                      buildAgreePrivacyPolicy(),
                      const SizedBox(height: 30),

                      buildSignupButton(),
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
        title: 'Email',
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
              hintText: 'Email',
              prefixIcon: Icon(Icons.email)),
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
            if (value.length < 4) {
              return 'Enter a password of at least 4 characters.';
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

  Widget buildSignupButton() => ButtonWidget(
      pressed: _checkboxValue,
      text: 'Sign Up',
      color: ArgonColors.redUnito,
      onClicked: () {
        if (formKey.currentState.validate()) {
          userSignup();
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

  Widget buildDegree() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Seleziona il Corso di Laurea',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          FutureBuilder(
            future: getDegreeListFromWS(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return snapshot.hasData
                  ? Center(
                      child: Container(
                      /*decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side:
                              BorderSide(width: 1.0, style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),*/
                      height: 48,
                      // color: Colors.grey,
                      child: DropdownButtonFormField<String>(
                        value: snapshot.data[0].degree_name +
                            " - " +
                            snapshot.data[0].degree_type_note,
                        validator: (value) =>
                            value == null ? 'Degree required' : null,
                        elevation: 4,
                        isExpanded: true,
                        hint: Text(dropDownValueDegree ?? 'Corso di Laurea'),
                        items: snapshot.data
                            .map<DropdownMenuItem<String>>((degree) {
                          return DropdownMenuItem<String>(
                            value: degree.degree_name +
                                " - " +
                                degree.degree_type_note,
                            child: Text(degree.degree_name +
                                " - " +
                                degree.degree_type_note),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            dropDownValueDegree = value;
                            var breakpoint = value.indexOf(RegExp(r'-'));
                            this.degreeNameSelected =
                                value.substring(0, breakpoint).trim();
                            this.degreeTypeNoteSelected = value
                                .substring(breakpoint + 1, value.length)
                                .trim();
                          });
                        },
                      ),
                    ))
                  : Container(
                      child: Center(
                        child: SizedBox(
                          child: CircularProgressIndicator(
                              backgroundColor: ArgonColors.redUnito),
                          width: 60,
                          height: 60,
                        ),
                      ),
                    );
            },
          ),
        ],
      );

  Widget buildCurriculum() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Seleziona il percorso',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          FutureBuilder(
            future: getCurriculumListFromWS(
                this.degreeNameSelected, this.degreeTypeNoteSelected),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return snapshot.hasData
                  ? Center(
                      child: Container(
                      /*decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side:
                              BorderSide(width: 1.0, style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),*/
                      height: 48,
                      // color: Colors.grey,
                      child: DropdownButtonFormField<String>(
                        value: snapshot.data.isEmpty
                            ? '-'
                            : snapshot.data[0].degree_path_name,
                        validator: (value) {
                          if (value == null) {
                            return 'Curriculum required';
                          }
                          return null;
                        },
                        elevation: 4,
                        isExpanded: true,
                        hint: Text(dropDownValueCurriculum ?? 'Curriculum'),
                        items: snapshot.data
                            .map<DropdownMenuItem<String>>((curriculum) {
                          return DropdownMenuItem<String>(
                            value: curriculum.degree_path_name,
                            child: Text(curriculum.degree_path_name,
                                overflow: TextOverflow.visible),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            dropDownValueCurriculum = value;
                            // print(value);
                          });
                        },
                      ),
                    ))
                  : Container(
                      child: Center(
                        child: SizedBox(
                          child: CircularProgressIndicator(
                              backgroundColor: ArgonColors.redUnito),
                          width: 60,
                          height: 60,
                        ),
                      ),
                    );
            },
          ),
        ],
      );

  Widget buildRole() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Seleziona il ruolo',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          FutureBuilder(
            future: getRoleListFromWS(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return snapshot.hasData
                  ? Center(
                      child: Container(
                      height: 48,
                      /*decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side:
                              BorderSide(width: 1.0, style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),*/
                      // color: Colors.grey,
                      child: DropdownButtonFormField<String>(
                        value: snapshot.data[0].role_name,
                        elevation: 4,
                        validator: (value) =>
                            value == null ? 'Role required' : null,
                        isExpanded: true,
                        hint: Text(dropDownValueRole ?? 'Ruolo'),
                        items:
                            snapshot.data.map<DropdownMenuItem<String>>((role) {
                          return DropdownMenuItem<String>(
                            value: role.role_name,
                            child: Text(role.role_name),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            dropDownValueRole = value;
                            // print(value);
                          });
                        },
                      ),
                    ))
                  : Container(
                      child: Center(
                        child: SizedBox(
                          child: CircularProgressIndicator(
                              backgroundColor: ArgonColors.redUnito),
                          width: 60,
                          height: 60,
                        ),
                      ),
                    );
            },
          ),
        ],
      );

  buildAgreePrivacyPolicy() => Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 0, bottom: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(
                activeColor: ArgonColors.primary,
                onChanged: (bool newValue) =>
                    setState(() => _checkboxValue = newValue),
                value: _checkboxValue),
            Text("I agree with the",
                style: TextStyle(color: ArgonColors.black, fontSize: 15)),
            GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PrivacyPolicy()));
                },
                child: Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Text("Privacy Policy",
                      style:
                          TextStyle(color: ArgonColors.redUnito, fontSize: 15)),
                )),
          ],
        ),
      );
}
