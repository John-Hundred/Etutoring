import 'dart:convert';

import 'package:argon_flutter/config/config.dart';
import 'package:argon_flutter/model/RoleModel.dart';
import 'package:argon_flutter/model/courseModel.dart';
import 'package:argon_flutter/model/curriculumModel.dart';
import 'package:argon_flutter/model/degreeModel.dart';
import 'package:argon_flutter/model/userModel.dart';
import 'package:argon_flutter/utils/user_secure_storage.dart';
import 'package:http/http.dart' as http;

Future<UserModel> getUserInfoFromWS() async {
  try {
    var queryParameters = {
      'email': await UserSecureStorage.getEmail(),
    };
    // print(queryParameters);
    var response = await http.get(Uri.https(
        authority, unencodedPath + "users_list.php", queryParameters));

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

    var response = await http.get(Uri.https(
        authority, unencodedPath + "course_search.php", queryParameters));
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

    var response = await http.get(Uri.https(authority,
        unencodedPath + "course_search_private_lesson.php", queryParameters));
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
    var response =
        await http.get(Uri.https(authority, unencodedPath + "degree_list.php"));
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
    var response = await http.get(Uri.https(authority,
        unencodedPath + "curriculum_path_by_degree.php", queryParameters));
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
    var response =
        await http.get(Uri.https(authority, unencodedPath + "role_list.php"));
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
