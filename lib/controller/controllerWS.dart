import 'dart:convert';

import 'package:e_tutoring/config/config.dart';
import 'package:e_tutoring/model/RoleModel.dart';
import 'package:e_tutoring/model/courseModel.dart';
import 'package:e_tutoring/model/curriculumModel.dart';
import 'package:e_tutoring/model/degreeModel.dart';
import 'package:e_tutoring/model/tutorModel.dart';
import 'package:e_tutoring/model/userModel.dart';
import 'package:e_tutoring/utils/user_secure_storage.dart';
import 'package:http/http.dart' as http;

Future<UserModel> getUserInfoFromWS() async {
  try {
    var queryParameters = {
      'email': await UserSecureStorage.getEmail(),
    };
    // print(queryParameters);
    var response = await http.get(
        Uri.https(authority, unencodedPath + "users_list.php", queryParameters),
        headers: <String, String>{'authorization': basicAuth});

    var user;
    if (response.statusCode == 200) {
      // print(response.body);
      var userJsonData = json.decode(response.body);
      user = UserModel.fromJson(userJsonData);
      // print(user);
    }
    return user;
  } on Exception catch ($e) {
    print('error caught: ' + $e.toString());
    return null;
  }
}

Future<List<CourseModel>> getUserCourseSearchFromWS(
    {String searchString = ''}) async {
  List<CourseModel> courseList = [];

  try {
    var queryParameters = {
      'email': await UserSecureStorage.getEmail(),
    };

    if (searchString != '') {
      queryParameters = {
        'email': await UserSecureStorage.getEmail(),
        'query': searchString,
      };
    }
    // print(queryParameters);

    var response = await http.get(
        Uri.https(
            authority, unencodedPath + "course_search.php", queryParameters),
        headers: <String, String>{'authorization': basicAuth});
    if (response.statusCode == 200) {
      // print(response.body);
      var courseJsonData = json.decode(response.body);
      // print(courseJsonData);
      for (var courseItem in courseJsonData) {
        var course = CourseModel.fromJson(courseItem);
        // print(course);
        courseList.add(course);
      }
    }
    return courseList;
  } on Exception catch ($e) {
    print('error caught: ' + $e.toString());
    return [];
  }
}

Future<List<CourseModel>> getUserCourseSearchPrivateLessonFromWS(
    {String searchString = ''}) async {
  List<CourseModel> courseList = [];

  try {
    var queryParameters = {
      'email': await UserSecureStorage.getEmail(),
    };

    if (searchString != '') {
      queryParameters = {
        'email': await UserSecureStorage.getEmail(),
        'query': searchString,
      };
    }
    // print(queryParameters);

    var response = await http.get(
        Uri.https(authority, unencodedPath + "course_search_private_lesson.php",
            queryParameters),
        headers: <String, String>{'authorization': basicAuth});
    if (response.statusCode == 200) {
      var courseJsonData = json.decode(response.body);
      // print(courseJsonData);
      for (var courseItem in courseJsonData) {
        var course = CourseModel.fromJson(courseItem);
        // print(course);
        courseList.add(course);
      }
    }
    return courseList;
  } on Exception catch ($e) {
    print('error caught: ' + $e.toString());
    return [];
  }
}

Future<List<DegreeModel>> getDegreeListFromWS() async {
  List<DegreeModel> degreeList = [];

  try {
    var response = await http.get(
      Uri.https(authority, unencodedPath + "degree_list.php"),
      headers: <String, String>{'authorization': basicAuth},
    );
    if (response.statusCode == 200) {
      var degreeJsonData = json.decode(response.body);
      for (var degreeItem in degreeJsonData) {
        var degree = DegreeModel.fromJson(degreeItem);
        degreeList.add(degree);
      }
    }
    return degreeList;
  } on Exception catch ($e) {
    print('error caught: ' + $e.toString());
    return [];
  }
}

Future<List<CurriculumModel>> getCurriculumListFromWS(
    String degreeName, String degreeTypeName) async {
  List<CurriculumModel> curriculumList = [];

  //https://www.e-tutoring-app.it/ws/curriculum_path_by_degree.php?degree_name=informatica&degree_type_note=LaureaTriennale
  var queryParameters = {
    'degree_name': degreeName,
    'degree_type_note': degreeTypeName
  };
  try {
    var response = await http.get(
        Uri.https(authority, unencodedPath + "curriculum_path_by_degree.php",
            queryParameters),
        headers: <String, String>{'authorization': basicAuth});
    if (response.statusCode == 200) {
      var curriculumJsonData = json.decode(response.body);
      for (var curriculumItem in curriculumJsonData) {
        var curriculum = CurriculumModel.fromJson(curriculumItem);
        curriculumList.add(curriculum);
      }
    }
    return curriculumList;
  } on Exception catch ($e) {
    print('error caught: ' + $e.toString());
    return [];
  }
}

Future<List<RoleModel>> getRoleListFromWS() async {
  List<RoleModel> roleList = [];

  try {
    var response = await http.get(
        Uri.https(authority, unencodedPath + "role_list.php"),
        headers: <String, String>{'authorization': basicAuth});
    if (response.statusCode == 200) {
      var roleJsonData = json.decode(response.body);
      for (var roleItem in roleJsonData) {
        var role = RoleModel.fromJson(roleItem);
        roleList.add(role);
      }
    }
    return roleList;
  } on Exception catch ($e) {
    print('error caught: ' + $e.toString());
    return [];
  }
}

Future<CourseModel> getCourseDetailFromWS(String courseId) async {
  try {
    var queryParameters = {
      'course_id': courseId,
    };
    // print(queryParameters);
    var response = await http.get(
        Uri.https(
            authority, unencodedPath + "course_list.php", queryParameters),
        headers: <String, String>{'authorization': basicAuth});

    var course;
    if (response.statusCode == 200) {
      // print(response.body);
      var courseJsonData = json.decode(response.body);
      course = CourseModel.fromJson(courseJsonData);
      // print(user);
    }
    return course;
  } on Exception catch ($e) {
    print('error caught: ' + $e.toString());
    return null;
  }
}

Future<List<TutorModel>> getTutorSearchFromWS() async {
  List<TutorModel> tutorList = [];
  try {
    var response = await http.get(
        Uri.https(authority, unencodedPath + "tutor_list.php"),
        headers: <String, String>{'authorization': basicAuth});

    if (response.statusCode == 200) {
      // print(response.body);
      var tutorJsonData = json.decode(response.body);
      //  print(tutorJsonData);
      for (var item in tutorJsonData) {
        // print(item['id']);
        var tutorItem = TutorModel.fromJson(item);
        tutorList.add(tutorItem);
      }
      // print(tutorList);
    }
    return tutorList;
  } on Exception catch ($e) {
    print('error caught: ' + $e.toString());
    return null;
  }
}

Future<CourseModel> getReviewFromWS(String userTutorId) async {
  try {
    var queryParameters = {
      'user_tutor_id': userTutorId,
    };
    // print(queryParameters);
    var response = await http.get(
        Uri.https(
            authority, unencodedPath + "review_list.php", queryParameters),
        headers: <String, String>{'authorization': basicAuth});

    var review;
    if (response.statusCode == 200) {
      var reviewJsonData = json.decode(response.body);
      review = CourseModel.fromJson(reviewJsonData);
    }
    return review;
  } on Exception catch ($e) {
    print('error caught: ' + $e.toString());
    return null;
  }
}
