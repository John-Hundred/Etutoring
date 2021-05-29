import 'dart:convert';

import 'package:argon_flutter/config/config.dart';
import 'package:argon_flutter/model/courseModel.dart';
import 'package:argon_flutter/model/userModel.dart';
import 'package:argon_flutter/utils/user_secure_storage.dart';
import 'package:http/http.dart' as http;

Future<UserModel> getUserInfoFromWS = Future<UserModel>.delayed(
  const Duration(seconds: 0),
  () async {
    try {
      var queryParameters = {
        'email': await UserSecureStorage.getEmail(),
      };
      // print(queryParameters);
      var response = await http.get(Uri.http(
          authority, unencodedPath + "users_list.php", queryParameters));

      var user;
      if (response.statusCode == 200) {
        var userJsonData = json.decode(response.body);
        user = UserModel.fromJson(userJsonData);
      }
      // print(user);
      return user;
    } on Exception catch ($e) {
      print('error caught: ' + $e.toString());
      return null;
    }
  },
);
Future<List<CourseModel>> getUserCourseListFromWS() async {
  List<CourseModel> courseList;

  try {
    var queryParameters = {
      'email': await UserSecureStorage.getEmail(),
    };

    var response = await http.get(Uri.http(
        authority, unencodedPath + "course_user_list.php", queryParameters));
    if (response.statusCode == 200) {
      print(response.body);

      return null;
    }
  } on Exception catch ($e) {
    print('error caught: ' + $e.toString());
    return null;
  }
}
