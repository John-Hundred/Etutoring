import 'package:e_tutoring/config/config.dart';
import 'package:e_tutoring/controller/controllerWS.dart';
import 'package:e_tutoring/model/courseModel.dart';
import 'package:e_tutoring/model/degreeModel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements http.Client {}

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  group('getAllCourseFromWS', () {
    test(
        'returns a List of CourseModel if the http call completes successfully',
        () async {
      final client = MockClient();

      when(client.get(Uri.https(authority, unencodedPath + "course_list.php"),
          headers: <String, String>{
            'authorization': basicAuth
          })).thenAnswer((_) async => http.Response(
          '[{"course_id": "3","course_name": "Agenti Intelligenti","course_cfu": "6","enrollment_year": "2021/2022","study_year": "1"}]',
          200));

      expect(await getAllCourseFromWS(), isA<List<CourseModel>>());
    });
  });

  group('getDegreeListFromWS', () {
    test(
        'returns a List of DegreeModel if the http call completes successfully',
        () async {
      final client = MockClient();

      when(client.get(Uri.https(authority, unencodedPath + "course_list.php"),
          headers: <String, String>{
            'authorization': basicAuth
          })).thenAnswer((_) async => http.Response(
          '[{"degree_id": "5","degree_name": "Fisica","degree_cfu": "180","degree_description": "","degree_type_id": "1","degree_location": "Torino","degree_athenaeum": "Unito","degree_type_name": "LT","degree_type_note": "Laurea Triennale"},]',
          200));

      expect(await getDegreeListFromWS(), isA<List<DegreeModel>>());
    });

    test('test toString() of first element of List DegreeModel', () async {
      final client = MockClient();

      when(client.get(Uri.https(authority, unencodedPath + "course_list.php"),
          headers: <String, String>{
            'authorization': basicAuth
          })).thenAnswer((_) async => http.Response(
          '[{"degree_id": "5","degree_name": "Fisica","degree_cfu": "180","degree_description": "","degree_type_id": "1","degree_location": "Torino","degree_athenaeum": "Unito","degree_type_name": "LT","degree_type_note": "Laurea Triennale"},]',
          200));

      List<DegreeModel> degreeList = await getDegreeListFromWS();
      expect(degreeList[0].toString(), "degree_id = 5, degree_name = Fisica");
    });
  });
}
