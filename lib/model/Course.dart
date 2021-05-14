import 'dart:convert';

import 'package:http/http.dart' as http;

const IP = "192.168.56.1";
const URL = "e-tutoring-web/ws/ws/course_list.php";

Future<List<Course>> fetchCourse() async {
  final response = await http.get(Uri.http(IP, URL));
  // print(response);

  List<Course> courses = [];
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var responseJson = jsonDecode(response.body);
    // print(responseJson);
    for (var element in responseJson) {
      Course course = new Course(
          element['course_id'], element['course_name'], element['course_cfu']);
      courses.add(course);
      // print(course);
    }
    return courses;
    // return Course.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load course');
  }
}

class Course {
  String courseId;
  String courseName;
  String courseCfu;

  /*Course({
    this.courseId,
    this.courseName,
    this.courseCfu,
  });*/

  Course(String courseId, String courseName, String courseCfu) {
    this.courseId = courseId;
    this.courseName = courseName;
    this.courseCfu = courseCfu;
  }

  toString() {
    return 'id: ' +
        this.courseId +
        ', name: ' +
        this.courseName +
        ', cfu: ' +
        this.courseCfu +
        "\n";
  }

  /*factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      courseId: json['course_id'],
      courseName: json['couse_name'],
      courseCfu: json['course_cfu'],
    );
  }*/
}
