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

  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
            title: Text(courseData.course_name.toString().capitalize()),
            backgroundColor: Color.fromRGBO(213, 21, 36, 1)),
        drawer: ArgonDrawer("courseDetail"),
        body: Container());
  }
}
