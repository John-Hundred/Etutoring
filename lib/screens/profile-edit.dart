import 'dart:convert';

import 'package:e_tutoring/config/config.dart';
import 'package:e_tutoring/constants/Theme.dart';
import 'package:e_tutoring/controller/controllerWS.dart';
import 'package:e_tutoring/model/userModel.dart';
import 'package:e_tutoring/screens/profile.dart';
import 'package:e_tutoring/widgets/button_widget.dart';
import 'package:e_tutoring/widgets/language_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;

class ProfileEdit extends StatefulWidget {
  @override
  _ProfileStateEdit createState() => _ProfileStateEdit();
}

class _ProfileStateEdit extends State<ProfileEdit> {
  final controllerEmail = new TextEditingController();
  final controllerFirstname = new TextEditingController();
  final controllerLastname = new TextEditingController();
  final controllerNationality = new TextEditingController();
  final controllerBirthDate = new TextEditingController();
  final controllerBirthCity = new TextEditingController();
  final controllerResidence = new TextEditingController();
  final controllerPhoneNumber = new TextEditingController();
  final controllerDescription = new TextEditingController();

  final formKey = GlobalKey<FormState>();

  // For CircularProgressIndicator.
  bool visible = false;

  @override
  void initState() {
    super.initState();
  }

  // CONTROLLER
  Future userEdit() async {
    try {
      // print(controllerLastname.text);
      setState(() {
        // Showing CircularProgressIndicator.
        visible = true;
        this.controllerFirstname.text = controllerFirstname.text;
        this.controllerLastname.text = controllerLastname.text;
        this.controllerDescription.text = controllerDescription.text;
        this.controllerBirthDate.text = controllerBirthDate.text;
        this.controllerBirthCity.text = controllerBirthCity.text;
        this.controllerResidence.text = controllerResidence.text;
        this.controllerNationality.text = controllerNationality.text;
        this.controllerPhoneNumber.value = controllerPhoneNumber.value;
      });

      var data = {
        'email': controllerEmail.text.trim(),
        'firstname': controllerFirstname.text,
        'lastname': controllerLastname.text,
        'description': controllerDescription.text,
        'birth_date': controllerBirthDate.text,
        'birth_city': controllerBirthCity.text,
        'residence_city': controllerResidence.text,
        'nationality': controllerNationality.text,
        'phone_number': controllerPhoneNumber.text,
      };

      // print(data);

      var response = await http
          .post(
            Uri.https(authority, unencodedPath + 'user_edit.php'),
            headers: <String, String>{'authorization': basicAuth},
            body: json.encode(data),
          )
          .timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        // print(response.body);
        var message = jsonDecode(response.body);
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Profile()));
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
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).edit_profile),
          backgroundColor: Color.fromRGBO(213, 21, 36, 1),
          actions: [LanguagePickerWidget()],
        ),
        resizeToAvoidBottomInset: false,
        body: Stack(children: [
          SafeArea(
              child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: Form(
                      key: formKey,
                      child: (FutureBuilder<UserModel>(
                          future: getUserInfoFromWS(),
                          builder: (BuildContext context,
                              AsyncSnapshot<UserModel> user) {
                            List<Widget> children;
                            if (user.hasData) {
                              this.controllerEmail.text = user.data.email;
                              this.controllerFirstname.text =
                                  user.data.firstname;
                              this.controllerLastname.text = user.data.lastname;
                              this.controllerNationality.text =
                                  user.data.nationality;
                              this.controllerBirthDate.text =
                                  user.data.birth_date;
                              this.controllerBirthCity.text =
                                  user.data.birth_city;
                              this.controllerResidence.text =
                                  user.data.residence_city;
                              this.controllerPhoneNumber.text =
                                  user.data.phone_number;
                              this.controllerDescription.text =
                                  user.data.description;

                              children = <Widget>[
                                Container(
                                    child: TextField(
                                  controller: controllerEmail,
                                  enabled: false,
                                  autocorrect: true,
                                  decoration: InputDecoration(
                                    // hintText: user.data.email,
                                    prefixIcon: Icon(Icons.email),
                                    hintStyle: TextStyle(color: Colors.black),
                                    filled: true,
                                    fillColor: Colors.white70,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.0)),
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 2),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 2),
                                    ),
                                  ),
                                )),
                                Container(
                                    // padding: EdgeInsets.all(10.0),
                                    child: TextField(
                                  enabled: false,
                                  autocorrect: true,
                                  decoration: InputDecoration(
                                    hintText: user.data.role_name,
                                    prefixIcon: Icon(Icons.work),
                                    hintStyle: TextStyle(color: Colors.black),
                                    filled: true,
                                    fillColor: Colors.white70,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.0)),
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 2),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 2),
                                    ),
                                  ),
                                )),
                                Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: TextField(
                                      controller: controllerFirstname,
                                      autocorrect: true,
                                      decoration: InputDecoration(
                                        //hintText: user.data.firstname ?? 'Enter Surname Here...',
                                        prefixIcon: Icon(Icons.person),
                                        hintStyle:
                                            TextStyle(color: Colors.black),
                                        filled: true,
                                        fillColor: Colors.white70,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.0)),
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 2),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 2),
                                        ),
                                      ),
                                    )),
                                Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: TextField(
                                      controller: controllerLastname,
                                      autocorrect: true,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.person),
                                        hintStyle:
                                            TextStyle(color: Colors.black),
                                        filled: true,
                                        fillColor: Colors.white70,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.0)),
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 2),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 2),
                                        ),
                                      ),
                                    )),
                                Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: TextField(
                                      controller: controllerNationality,
                                      autocorrect: true,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.flag),
                                        hintStyle:
                                            TextStyle(color: Colors.black),
                                        filled: true,
                                        fillColor: Colors.white70,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.0)),
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 2),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 2),
                                        ),
                                      ),
                                    )),
                                Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: TextField(
                                      controller: controllerBirthDate,
                                      autocorrect: true,
                                      decoration: InputDecoration(
                                        // hintText: 'Enter Residence Here...',
                                        prefixIcon: Icon(Icons.calendar_today),
                                        hintStyle:
                                            TextStyle(color: Colors.black),
                                        filled: true,
                                        fillColor: Colors.white70,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.0)),
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 2),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 2),
                                        ),
                                      ),
                                    )),
                                Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: TextField(
                                      controller: controllerBirthCity,
                                      autocorrect: true,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.place),
                                        hintStyle:
                                            TextStyle(color: Colors.black),
                                        filled: true,
                                        fillColor: Colors.white70,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.0)),
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 2),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 2),
                                        ),
                                      ),
                                    )),
                                Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: TextField(
                                      controller: controllerResidence,
                                      autocorrect: true,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.place),
                                        hintStyle:
                                            TextStyle(color: Colors.black),
                                        filled: true,
                                        fillColor: Colors.white70,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.0)),
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 2),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 2),
                                        ),
                                      ),
                                    )),
                                Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: TextField(
                                      controller: controllerPhoneNumber,
                                      autocorrect: true,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.smartphone),
                                        hintStyle:
                                            TextStyle(color: Colors.black),
                                        filled: true,
                                        fillColor: Colors.white70,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.0)),
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 2),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 2),
                                        ),
                                      ),
                                    )),
                                Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: TextField(
                                      controller: controllerDescription,
                                      autocorrect: true,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.description),
                                        hintStyle:
                                            TextStyle(color: Colors.black),
                                        filled: true,
                                        fillColor: Colors.white70,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.0)),
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 2),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 2),
                                        ),
                                      ),
                                    )),
                                const SizedBox(height: 20),
                                buildButton(),
                                const SizedBox(height: 20),
                                Visibility(
                                  visible: visible,
                                  child: Center(
                                      child: Container(
                                          margin: EdgeInsets.only(bottom: 30),
                                          child: CircularProgressIndicator(
                                            backgroundColor:
                                                ArgonColors.redUnito,
                                          ))),
                                ),
                              ];
                            } else if (user.hasError) {
                              children = <Widget>[
                                const Icon(
                                  Icons.error_outline,
                                  color: Colors.red,
                                  size: 60,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Text('Error: ${user.error}'),
                                )
                              ];
                            } else {
                              children = const <Widget>[
                                /*SizedBox(
                                  child: CircularProgressIndicator(
                                      backgroundColor: ArgonColors.redUnito),
                                  width: 60,
                                  height: 60,
                                ),*/
                                /*Padding(
                                  padding: EdgeInsets.only(top: 15),
                                  child: Text('Awaiting result...',
                                      style: TextStyle(
                                          color: ArgonColors.redUnito)),
                                )*/
                              ];
                            }
                            return Center(
                              child: ListView(
                                shrinkWrap: true,
                                children: children,
                              ),
                            );
                          })))))
        ]));
  }

  Widget buildButton() => ButtonWidget(
      pressed: true,
      text: AppLocalizations.of(context).save,
      color: ArgonColors.redUnito,
      onClicked: () {
        if (formKey.currentState.validate()) {
          userEdit();
        }
      });
}
