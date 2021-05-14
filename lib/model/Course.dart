import 'dart:convert';

import 'package:http/http.dart' as http;

const URL = "e-tutoring-web/ws/ws/course_list.php";

Future<Course> fetchCourse() async {
  final response = await http.get(Uri.http('locahost', URL));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Course.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load course');
  }
}

class Course {
  final String courseId;
  final String courseName;
  final String courseCfu;

  Course({this.courseId, this.courseName, this.courseCfu});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      courseId: json['course_id'],
      courseName: json['couse_name'],
      courseCfu: json['course_cfu'],
    );
  }
}
