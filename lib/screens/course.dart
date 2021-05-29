import 'package:argon_flutter/controller/controllerWS.dart';
import 'package:argon_flutter/model/courseModel.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
          title: const Text('Course'),
          backgroundColor: Color.fromRGBO(213, 21, 36, 1)),
      drawer: ArgonDrawer("course"),
      body: Stack(children: <Widget>[
        SafeArea(
            child: ListView(children: [
          Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      child: Card(
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
                    ),
                    /*SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Lista dei Corsi',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),*/
                    Container(
                        child: Card(
                      // color: Color.fromRGBO(205, 205, 205, 1),
                      child: Padding(
                          padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
                          child: Row(children: [
                            Expanded(child: Column(children: []))
                          ])),
                    )),
                  ]))
        ]))
      ]),

      /* FutureBuilder<List<CourseModel>>(
                    future: getUserCourseListFromWS,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<CourseModel>> courseList) {
                      // List<Widget> children;
                      if (courseList.hasData) {
                        print(courseList.data);
                        // children = <Widget>[];
                      }
                    }),*/
    );
  }
}
