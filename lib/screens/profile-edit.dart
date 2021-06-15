import 'package:e_tutoring/constants/Theme.dart';
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
                      child: (ListView(padding: EdgeInsets.all(8), children: [
                        Container(
                            // width: 320,
                            padding: EdgeInsets.all(10.0),
                            child: TextField(
                              autocorrect: true,
                              decoration: InputDecoration(
                                hintText: 'Enter Surname Here...',
                                prefixIcon: Icon(Icons.person),
                                hintStyle: TextStyle(color: Colors.black),
                                filled: true,
                                fillColor: Colors.white70,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.0)),
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2),
                                ),
                              ),
                            )),
                        Container(
                            width: 320,
                            padding: EdgeInsets.all(10.0),
                            child: TextField(
                              autocorrect: true,
                              decoration: InputDecoration(
                                hintText: 'Enter Name Here...',
                                prefixIcon: Icon(Icons.person),
                                hintStyle: TextStyle(color: Colors.black),
                                filled: true,
                                fillColor: Colors.white70,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.0)),
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2),
                                ),
                              ),
                            )),
                        Container(
                            width: 320,
                            padding: EdgeInsets.all(10.0),
                            child: TextField(
                              autocorrect: true,
                              decoration: InputDecoration(
                                hintText: 'Enter Nationality Here...',
                                prefixIcon: Icon(Icons.flag),
                                hintStyle: TextStyle(color: Colors.black),
                                filled: true,
                                fillColor: Colors.white70,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.0)),
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2),
                                ),
                              ),
                            )),
                        Container(
                            width: 320,
                            padding: EdgeInsets.all(10.0),
                            child: TextField(
                              autocorrect: true,
                              decoration: InputDecoration(
                                hintText: 'Enter Birth Place Here...',
                                prefixIcon: Icon(Icons.place),
                                hintStyle: TextStyle(color: Colors.black),
                                filled: true,
                                fillColor: Colors.white70,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.0)),
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2),
                                ),
                              ),
                            )),
                        Container(
                            width: 320,
                            padding: EdgeInsets.all(10.0),
                            child: TextField(
                              autocorrect: true,
                              decoration: InputDecoration(
                                hintText: 'Enter Residence Here...',
                                prefixIcon: Icon(Icons.place),
                                hintStyle: TextStyle(color: Colors.black),
                                filled: true,
                                fillColor: Colors.white70,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.0)),
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2),
                                ),
                              ),
                            )),
                        Container(
                            width: 320,
                            padding: EdgeInsets.all(10.0),
                            child: TextField(
                              autocorrect: true,
                              decoration: InputDecoration(
                                hintText: 'Enter Your Email Here...',
                                prefixIcon: Icon(Icons.email),
                                hintStyle: TextStyle(color: Colors.black),
                                filled: true,
                                fillColor: Colors.white70,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.0)),
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2),
                                ),
                              ),
                            )),
                        const SizedBox(height: 20),
                        buildButton(),
                        Visibility(
                          visible: visible,
                          child: Center(
                              child: Container(
                                  margin: EdgeInsets.only(bottom: 30),
                                  child: CircularProgressIndicator(
                                    backgroundColor: ArgonColors.redUnito,
                                  ))),
                        ),
                      ])))))
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
