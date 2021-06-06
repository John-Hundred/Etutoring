import 'dart:convert';

import 'package:argon_flutter/config/config.dart';
import 'package:argon_flutter/controller/controllerWS.dart';
import 'package:argon_flutter/model/courseModel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements http.Client {}

//Tests go into main method
main() {
  group('getCourseDetailFromWS', () {
    test('returns a CourseModel if the http call completes successfully',
        () async {
      final client = MockClient();

      // Using Mockito to return a successful response when it calls the
      // provided http.Client.
      //'https://www.e-tutoring-app.it/ws/course_list.php?id=1'
      var queryParameters = {
        'course_id': "1",
      };
      when(client.get(Uri.https(
              authority, unencodedPath + "course_list.php", queryParameters)))
          .thenAnswer((_) async => http.Response(
              json.encode({
                "course_id": "1",
                "course_name": "Analisi Matematica",
                "course_cfu": "9",
                "enrollment_year": "2021/2022",
                "study_year": "1",
                "teaching_type": "Base",
                "dac": "MFN0570",
                "department": "Informatica",
                "curriculum": "percorso generico",
                "ssd": "ANALISI MATEMATICA (MAT/05)",
                "delivery_mode": "Convenzionale",
                "language": "Italiano",
                "didactic_period": "Secondo Semestre",
                "component_type": "Attivit formativa monodisciplinare",
              }),
              200));

      final CourseModel course = CourseModel.fromJson({
        "course_id": "1",
        "course_name": "Analisi Matematica",
        "course_cfu": "9",
        "enrollment_year": "2021/2022",
        "study_year": "1",
        "teaching_type": "Base",
        "dac": "MFN0570",
        "department": "Informatica",
        "curriculum": "percorso generico",
        "ssd": "ANALISI MATEMATICA (MAT/05)",
        "delivery_mode": "Convenzionale",
        "language": "Italiano",
        "didactic_period": "Secondo Semestre",
        "component_type": "Attivit formativa monodisciplinare",
      });
      expect(course.course_id, "1");
    });

    test('returns a CourseModel if the http call completes successfully',
        () async {
      // Using Mockito to return a successful response when it calls the
      // provided http.Client.
      //'https://www.e-tutoring-app.it/ws/course_list.php?id=1'
      final CourseModel course = await getCourseDetailFromWS("1");
      expect(course.course_id, "1");
    });

    test('returns a CourseModel if the http call completes successfully',
        () async {
      // Using Mockito to return a successful response when it calls the
      // provided http.Client.
      //'https://www.e-tutoring-app.it/ws/course_list.php?id=1'

      final CourseModel course = await getCourseDetailFromWS("99999");
      expect(course, null);
    });
  });
}
