import 'dart:convert';

import 'package:e_tutoring/config/config.dart';
import 'package:e_tutoring/constants/Theme.dart';
import 'package:e_tutoring/screens/router-dispatcher.dart';
import 'package:e_tutoring/utils/user_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class UserReviewAdd extends StatefulWidget {
  var lessonData;

  UserReviewAdd(this.lessonData);
  @override
  UserReviewAddState createState() => new UserReviewAddState(lessonData);
}

class UserReviewAddState extends State<UserReviewAdd> {
  var lessonData;
  UserReviewAddState(this.lessonData);

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // print(this.lessonData);
  }

// CONTROLLER
  Future addTimeslot(courseId, day, houFrom, hourTo) async {
    try {
      String email = await UserSecureStorage.getEmail();

      var data = {
        'email': email,
        'course_id': courseId,
        'day': day,
        'hour_from': houFrom,
        'hour_to': hourTo
      };

      var response = await http
          .post(Uri.https(authority, unencodedPath + 'add_tutor_time_slot.php'),
              headers: <String, String>{'authorization': basicAuth},
              body: json.encode(data))
          .timeout(const Duration(seconds: 8));
      if (response.statusCode == 200) {
        var message = jsonDecode(response.body);
        // print(response.body);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text(message),
              actions: <Widget>[
                TextButton(
                  child: new Text(
                    "OK",
                    style: TextStyle(color: ArgonColors.redUnito),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RouterDispatcher()));
                  },
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("Error adding review"),
              actions: <Widget>[
                TextButton(
                  child: new Text(
                    "OK",
                    style: TextStyle(color: ArgonColors.redUnito),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } on Exception {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error adding courses. Verify Your Connection.'),
        backgroundColor: Colors.redAccent,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).add_review +
              " " +
              this.lessonData.tutor[0]['firstname'] +
              " " +
              this.lessonData.tutor[0]['lastname']),
          backgroundColor: Color.fromRGBO(213, 21, 36, 1),
          actions: <Widget>[],
        ),
        body: Stack(children: [
          Container(
              decoration:
                  BoxDecoration(color: Color.fromRGBO(205, 205, 205, 1))),
          SafeArea(
              child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: Form(
                      key: formKey,
                      child: ListView(padding: EdgeInsets.all(8), children: [
                        const SizedBox(height: 20),
                        Text('Write a review'),
                        TextField(
                          keyboardType: TextInputType.multiline,
                          minLines: 1, //Normal textInputField will be displayed
                          maxLines:
                              5, // when user presses enter it will adapt to it
                        ),
                      ]))))
        ]));
  }
}
