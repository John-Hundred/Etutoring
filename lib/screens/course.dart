import 'package:argon_flutter/controller/controllerWS.dart';
import 'package:argon_flutter/model/courseModel.dart';
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:flutter/material.dart';

class Course extends StatefulWidget {
  ScrollController _controller;

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
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        child: FutureBuilder<List<CourseModel>>(
                      future: getUserCourseListFromWS,
                      builder: (ctx, snapshot) {
                        if (snapshot.connectionState == ConnectionState.none &&
                            snapshot.hasData == null) {
                          /*print('project snapshot data is: ${projectSnap.data}');*/
                          return Container();
                        } else {
                          List<CourseModel> courseList = snapshot.data;
                          // print(courseList);
                          return Text(courseList.toString());
                          /*return ListView.builder(
                              itemCount: litems.length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                return new Text(litems[index]);
                              });*/
                        }

                        /*switch (snapshot.connectionState) {
                          case ConnectionState.done:
                            return _buildListView(contacts);
                          default:
                            return _buildLoadingScreen();
                        }*/
                      },
                    ))
                  ]))
        ]))
      ]),
    );
  }
}
