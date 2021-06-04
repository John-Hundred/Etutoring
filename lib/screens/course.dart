import 'package:argon_flutter/controller/controllerWS.dart';
import 'package:argon_flutter/model/courseModel.dart';
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:flutter/material.dart';

class Course extends StatefulWidget {
  @override
  CourseState createState() => new CourseState();
}

class CourseState extends State<Course> {
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
    getUserCourseSearchFromWS().then((value) => {
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
      if (query.isNotEmpty && query.length > 2) {
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
          title: const Text('Course'),
          backgroundColor: Color.fromRGBO(213, 21, 36, 1)),
      drawer: ArgonDrawer("course"),
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
            // projectWidget(),
          ],
        ),
      ),
    );
  }

  /*Widget projectWidget() {
    return FutureBuilder(
      builder: (context, courseSnap) {
        if (courseSnap.hasData) {
          return Expanded(
              child: ListView.builder(
            shrinkWrap: true,
            itemCount: courseSnap.data.length ?? 0,
            itemBuilder: (context, index) {
              CourseModel course = courseSnap.data[index];
              return ListTile(
                title: Text(course.course_name.toUpperCase()),
              );
            },
          ));
        }

        if (courseSnap.hasData == null) {
          // print('project snapshot data is: ${courseSnap.data}');
          return SizedBox(
            child: CircularProgressIndicator(
                backgroundColor: ArgonColors.redUnito),
            width: 60,
            height: 60,
          );
        } else if (courseSnap.hasError) {
          List<Widget> children;
          children = <Widget>[
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text('Error: ${courseSnap.error}'),
            )
          ];
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
          );
        } else {
          List<Widget> children;
          children = const <Widget>[
            SizedBox(
              child: CircularProgressIndicator(
                  backgroundColor: ArgonColors.redUnito),
              width: 60,
              height: 60,
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Text('Awaiting result...',
                  style: TextStyle(color: ArgonColors.redUnito)),
            )
          ];
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
          );
        }
      },
      future: getUserCourseSearchFromWS(),
    );
  }*/
}
