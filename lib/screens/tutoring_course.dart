import 'package:argon_flutter/controller/controllerWS.dart';
import 'package:argon_flutter/model/courseModel.dart';
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:flutter/material.dart';

class TutoringCourse extends StatefulWidget {
  @override
  TutoringCourseState createState() => new TutoringCourseState();
}

class TutoringCourseState extends State<TutoringCourse> {
  // final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
  // var items = [];

  // ignore: deprecated_member_use
  List<CourseModel> courseList = List<CourseModel>();
  // ignore: deprecated_member_use
  List<CourseModel> courseListForDisplay = List<CourseModel>();

  String searchString = "";
  final searchController = TextEditingController();

  @override
  void initState() {
    getUserCourseSearchPrivateLessonFromWS().then((value) => {
          setState(() {
            // print(value);
            courseList.addAll(value);
            courseListForDisplay = courseList;
          })
        });
    super.initState();
  }

  void filterSearchResults(String query) {
    setState(() {
      if (query.isNotEmpty && query.length > 3) {
        courseListForDisplay = courseListForDisplay.where((element) {
          var courseName = element.course_name.toLowerCase();
          return courseName.contains(query);
        }).toList();
      } else {
        getUserCourseSearchFromWS().then((value) {
          // print(value);
          courseListForDisplay.clear();
          courseListForDisplay.addAll(value);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
          title: const Text('My Tutoring Course'),
          backgroundColor: Color.fromRGBO(213, 21, 36, 1)),
      drawer: ArgonDrawer("Tutoring Course"),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: searchController,
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider();
                },
                shrinkWrap: true,
                itemCount: courseListForDisplay.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${courseListForDisplay[index].course_name}'
                        .toUpperCase()),
                    subtitle: Text('CFU: ' +
                        '${courseListForDisplay[index].course_cfu}'
                            .toUpperCase()),
                    leading: Icon(Icons.library_books),
                    trailing:
                        courseListForDisplay[index].private_lesson_id != '-'
                            ? Icon(
                                Icons.calendar_today,
                                color: Colors.green,
                              )
                            : Icon(Icons.not_interested, color: Colors.red),
                    onTap: () => print(courseListForDisplay[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
