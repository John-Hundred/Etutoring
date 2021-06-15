import 'package:e_tutoring/constants/Theme.dart';
import 'package:e_tutoring/controller/controllerWS.dart';
import 'package:e_tutoring/model/userModel.dart';
import 'package:e_tutoring/widgets/button_widget.dart';
import 'package:e_tutoring/widgets/language_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileEdit extends StatefulWidget {
  @override
  _ProfileStateEdit createState() => _ProfileStateEdit();
}

class _ProfileStateEdit extends State<ProfileEdit> {
  final formKey = GlobalKey<FormState>();

  // For CircularProgressIndicator.
  bool visible = false;

  @override
  void initState() {
    super.initState();
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
                              var controllerFirstname =
                                  new TextEditingController(
                                      text: user.data.firstname);

                              var controllerLastname =
                                  new TextEditingController(
                                      text: user.data.lastname);

                              var controllerNationality =
                                  new TextEditingController(
                                      text: user.data.nationality);

                              var controllerBirthDate =
                                  new TextEditingController(
                                      text: user.data.birth_date);

                              var controllerBirthCity =
                                  new TextEditingController(
                                      text: user.data.birth_city);

                              var controllerResidence =
                                  new TextEditingController(
                                      text: user.data.residence_city);

                              children = <Widget>[
                                Container(
                                    // padding: EdgeInsets.all(10.0),
                                    child: TextField(
                                  enabled: false,
                                  autocorrect: true,
                                  decoration: InputDecoration(
                                    hintText: user.data.email,
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
                                        // hintText: 'Enter Residence Here...',
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
                                SizedBox(
                                  child: CircularProgressIndicator(
                                      backgroundColor: ArgonColors.redUnito),
                                  width: 60,
                                  height: 60,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 15),
                                  child: Text('Awaiting result...',
                                      style: TextStyle(
                                          color: ArgonColors.redUnito)),
                                )
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
        if (formKey.currentState.validate()) {}
      });
}
