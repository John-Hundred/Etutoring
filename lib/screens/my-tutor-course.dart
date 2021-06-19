import 'dart:convert';

import 'package:e_tutoring/config/config.dart';
import 'package:e_tutoring/controller/controllerWS.dart';
import 'package:e_tutoring/model/tutorCourse.dart';
import 'package:e_tutoring/model/tutorModel.dart';
import 'package:e_tutoring/screens/router-dispatcher.dart';
import 'package:e_tutoring/screens/tutorCourse.dart';
import 'package:e_tutoring/utils/user_secure_storage.dart';
import 'package:e_tutoring/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyTutorCourse extends StatefulWidget {
  @override
  MyTutorCourseState createState() => new MyTutorCourseState();
}

class MyTutorCourseState extends State<MyTutorCourse> {
  List<TutorCourseModel> courseListSelected = [];
  TutorModel tutor;
  List<TutorCourseModel> courseList = [];
  @override
  void initState() {
    super.initState();
    getTutorDetailFromWS(http.Client()).then((value) => {
          setState(() {
            tutor = value;
            for (var course in value.courses) {
              courseList.add(TutorCourseModel.fromJson(course));
            }
            // print(courses);
          })
        });
  }

  // CONTROLLER
  Future deleteCourses(List<TutorCourseModel> courseListSelected) async {
    try {
      int totalCoursesSelected = courseListSelected.length;
      String errorMsg = "";
      String email = await UserSecureStorage.getEmail();
      if (courseListSelected.isNotEmpty) {
        for (var courseSelected in courseListSelected) {
          var data = {'email': email, 'course_id': courseSelected.course_id};

          var response = await http
              .post(
                  Uri.https(
                      authority, unencodedPath + 'delete_tutor_course.php'),
                  headers: <String, String>{'authorization': basicAuth},
                  body: json.encode(data))
              .timeout(const Duration(seconds: 8));
          if (response.statusCode == 200) {
            var message = jsonDecode(response.body);
            if (message == 'Course successfully deleted') {
              totalCoursesSelected = totalCoursesSelected - 1;
            } else {
              errorMsg +=
                  "\nError deleting course: " + courseSelected.course_name;
            }
            // response not 200
          } else {
            errorMsg +=
                "\nError deleting course: " + courseSelected.course_name;
          }
        }

        if (totalCoursesSelected == 0) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: new Text("Courses successfully deleted"),
                actions: <Widget>[
                  TextButton(
                    child: new Text("OK"),
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
                title: new Text(errorMsg),
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
      }
    } on Exception {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error adding courses. Verify Your Connection.'),
        backgroundColor: Colors.redAccent,
      ));
    }
  }

  List<ChildItem> _buildList() {
    if (courseList != null) {
      return courseList
          .map((course) => new ChildItem(course, courseListSelected))
          .toList();
    } else
      return [];
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).my_courses),
          backgroundColor: Color.fromRGBO(213, 21, 36, 1),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TutorCourse()));
                }),
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  // print(courseListSelected);
                  deleteCourses(courseListSelected);
                }),
          ],
        ),
        drawer: ArgonDrawer("my-tutor-course"),
        body: Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            width: double.maxFinite,
            color: Colors.white,
            child: ListView(
              padding: new EdgeInsets.symmetric(vertical: 8.0),
              children: _buildList(),
            )));
  }
}

// ignore: must_be_immutable
class ChildItem extends StatefulWidget {
  dynamic course;
  List<TutorCourseModel> courseListSelected = [];

  ChildItem(course, courseListSelected) {
    this.course = course;
    this.courseListSelected = courseListSelected;
  }

  @override
  ChildItemState createState() =>
      new ChildItemState(this.course, this.courseListSelected);
}

class ChildItemState extends State<ChildItem> {
  final TutorCourseModel course;
  List<TutorCourseModel> courseListSelected = [];
  ChildItemState(this.course, this.courseListSelected);
  @override
  Widget build(BuildContext context) {
    return new Card(
        elevation: 5,
        child: ListTile(
          onTap: () {
            setState(() {
              course.selected = !this.course.selected;
            });
            if (course.selected) {
              courseListSelected.add(this.course);
            } else {
              courseListSelected.remove(this.course);
            }
          },
          leading: Container(
              padding: EdgeInsets.only(right: 12.0),
              decoration: new BoxDecoration(
                  border: new Border(
                      right: new BorderSide(width: 1.0, color: Colors.black))),
              child: Icon(
                Icons.school,
                color: Colors.green,
              )),
          title: Text('${course.course_name}',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          subtitle: Text('${course.department}',
              style: TextStyle(color: Colors.black, fontSize: 15)),
          trailing: (course.selected)
              ? Icon(Icons.check_box)
              : Icon(Icons.check_box_outline_blank),
        ));
  }
}