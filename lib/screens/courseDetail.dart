import 'package:argon_flutter/widgets/drawer.dart';
import 'package:flutter/material.dart';
import "string_extension.dart";

// ignore: must_be_immutable
class CourseDetail extends StatefulWidget {
  dynamic courseData;

  CourseDetail(dynamic course) {
    this.courseData = course;
    // print(this.courseData);
  }

  @override
  CourseDetailState createState() => new CourseDetailState(courseData);
}

class CourseDetailState extends State<CourseDetail> {
  dynamic courseData;
  CourseDetailState(dynamic course) {
    this.courseData = course;
    // print(this.courseData);
  }

  /*Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }*/

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
            title: Text(courseData.course_name.toString().capitalize()),
            backgroundColor: Color.fromRGBO(213, 21, 36, 1)),
        // drawer: ArgonDrawer("courseDetail"),
        body: Container());
    /*return new WillPopScope(
      onWillPop: _onWillPop,
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text("Home Page"),
        ),
        body: new Center(
          child: new Text("Home Page"),
        ),
      ),
    );*/
  }

  /*Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(courseData.course_name.toString().capitalize()),
            backgroundColor: Color.fromRGBO(213, 21, 36, 1)),
        drawer: ArgonDrawer("courseDetail"),
        body: Container());
  }*/
}
