import 'package:argon_flutter/widgets/drawer.dart';
import 'package:flutter/material.dart';

class Course extends StatefulWidget {
  @override
  CourseState createState() => new CourseState();
}

class CourseState extends State<Course> {
  List<Course> data;

  @override
  void initState() {
    super.initState();
    this.getUserCourseListFromWS();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
            title: const Text('Course'),
            backgroundColor: Color.fromRGBO(213, 21, 36, 1)),
        drawer: ArgonDrawer("course"),
        body: new Padding(
          padding: const EdgeInsets.only(
              top: 0, left: 24.0, right: 24.0, bottom: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Search ...',
                    suffixIcon: IconButton(
                      onPressed: () => '',
                      icon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
              /*ListView.builder(
                    itemCount: data == null ? 0 : data.length,
                    itemBuilder: (BuildContext context, int index) {
                      print(data);
                      return new Card(
                        child: new Text(data[index]["course_name"] +
                            '\ncfu = ' +
                            data[index]["course_cfu"] +
                            '\ndepartiment = ' +
                            data[index]["department"]),
                      );
                    },
                  )*/
            ],
          ),
        ));
  }

  void getUserCourseListFromWS() {}
}
