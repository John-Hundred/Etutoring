import 'package:argon_flutter/constants/Theme.dart';
import 'package:argon_flutter/controller/controllerWS.dart';
import 'package:argon_flutter/model/courseModel.dart';
import 'package:flutter/material.dart';
import "string_extension.dart";

// ignore: must_be_immutable
class CourseDetail extends StatefulWidget {
  dynamic courseData;

  CourseDetail(dynamic course) {
    this.courseData = course;
    // print(this.courseData);
  }

  @override
  CourseDetailState createState() => new CourseDetailState(courseData);
}

class CourseDetailState extends State<CourseDetail> {
  dynamic courseData;
  CourseDetailState(dynamic course) {
    this.courseData = course;
    // print(this.courseData);
  }

  /*Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }*/

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
          title: Text(courseData.course_name.toString().capitalize()),
          backgroundColor: Color.fromRGBO(213, 21, 36, 1)),
      // drawer: ArgonDrawer("courseDetail"),
      body: Stack(children: <Widget>[
        SafeArea(
            child: ListView(children: [
          Padding(
              padding:
                  const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Stack(children: <Widget>[
                      Container(
                        child: Card(
                            // color: Color.fromRGBO(205, 205, 205, 1),
                            child: Padding(
                          padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    FutureBuilder<CourseModel>(
                                      future: getCourseDetailFromWS(
                                          this.courseData.course_id),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<CourseModel> course) {
                                        List<Widget> children;
                                        if (course.hasData) {
                                          // print(course.data);
                                          children = <Widget>[
                                            Container(
                                                color: Color.fromRGBO(
                                                    205, 205, 205, 1),
                                                child: DataTable(
                                                  dataRowHeight: 60,
                                                  dataRowColor:
                                                      MaterialStateColor
                                                          .resolveWith(
                                                              (states) =>
                                                                  Colors.white),
                                                  headingRowHeight: 0,
                                                  columns: <DataColumn>[
                                                    DataColumn(
                                                      label: Text(
                                                        '',
                                                      ),
                                                    ),
                                                    DataColumn(
                                                      label: Text(
                                                        '',
                                                      ),
                                                    ),
                                                  ],
                                                  rows: <DataRow>[
                                                    DataRow(
                                                      cells: <DataCell>[
                                                        DataCell(Text(
                                                          'Course',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .redAccent,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15),
                                                        )),
                                                        DataCell(Text(
                                                            "${course.data.course_name}"
                                                                .capitalize(),
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))),
                                                      ],
                                                    ),
                                                    DataRow(
                                                      cells: <DataCell>[
                                                        DataCell(Text('CFU',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .redAccent,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15))),
                                                        DataCell(Text(
                                                            "${course.data.course_cfu}",
                                                            style: TextStyle(
                                                                fontSize: 15))),
                                                      ],
                                                    ),
                                                    DataRow(
                                                      cells: <DataCell>[
                                                        DataCell(Text(
                                                            'Enrollment year',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .redAccent,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15))),
                                                        DataCell(
                                                          Text(
                                                            "${course.data.enrollment_year}",
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    DataRow(
                                                      cells: <DataCell>[
                                                        DataCell(Text(
                                                          'Didactic period',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .redAccent,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                        DataCell(Text(
                                                            "${course.data.study_year} - " +
                                                                "${course.data.didactic_period}")),
                                                      ],
                                                    ),
                                                    DataRow(
                                                      cells: <DataCell>[
                                                        DataCell(Text(
                                                          'Curriculum',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .redAccent,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15),
                                                        )),
                                                        DataCell(Text(
                                                            "${course.data.curriculum}"
                                                                .capitalize(),
                                                            style: TextStyle(
                                                                fontSize: 15))),
                                                      ],
                                                    ),
                                                    DataRow(
                                                      cells: <DataCell>[
                                                        DataCell(Text('Type',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .redAccent,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))),
                                                        DataCell(Text(
                                                            "${course.data.component_type}",
                                                            style: TextStyle(
                                                                fontSize: 15))),
                                                      ],
                                                    ),
                                                    /*DataRow(
                                                          cells: <DataCell>[
                                                            DataCell(Text(
                                                                'Luogo di Nascita',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .redAccent,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold))),
                                                            DataCell(Text(
                                                                "${user.data.birth_city}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15))),
                                                          ],
                                                        ),
                                                        DataRow(
                                                          cells: <DataCell>[
                                                            DataCell(Text(
                                                                'Città di residenza',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .redAccent,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold))),
                                                            DataCell(Text(
                                                                "${user.data.residence_city}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15))),
                                                          ],
                                                        ),*/
                                                  ],
                                                )),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                                color: Color.fromRGBO(
                                                    205, 205, 205, 1),
                                                child: DataTable(
                                                  dataRowHeight: 60,
                                                  dataRowColor:
                                                      MaterialStateColor
                                                          .resolveWith(
                                                              (states) =>
                                                                  Colors.white),
                                                  headingRowHeight: 0,
                                                  columns: <DataColumn>[
                                                    DataColumn(
                                                      label: Text(
                                                        '',
                                                      ),
                                                    ),
                                                    DataColumn(
                                                      label: Text(
                                                        '',
                                                      ),
                                                    ),
                                                  ],
                                                  rows: <DataRow>[
                                                    /*DataRow(
                                                          cells: <DataCell>[
                                                            DataCell(Text(
                                                                'Ruolo',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .redAccent,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        15))),
                                                            DataCell(Text(
                                                                "${user.data.role_name}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15))),
                                                          ],
                                                        ),
                                                        DataRow(
                                                          cells: <DataCell>[
                                                            DataCell(Text(
                                                                'Matricola',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .redAccent,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        15))),
                                                            DataCell(Text(
                                                                "${user.data.badge_number}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15))),
                                                          ],
                                                        ),
                                                        DataRow(
                                                          cells: <DataCell>[
                                                            DataCell(Text(
                                                                'Corso di Laurea',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .redAccent,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        15))),
                                                            DataCell(Text(
                                                                "${user.data.degree_name} (" +
                                                                    "${user.data.degree_athenaeum})",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15))),
                                                          ],
                                                        ),
                                                        DataRow(
                                                          cells: <DataCell>[
                                                            DataCell(Text(
                                                                'Tipologia',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .redAccent,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        15))),
                                                            DataCell(Text(
                                                                "${user.data.degree_type_note} (" +
                                                                    "${user.data.degree_type_name})",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15))),
                                                          ],
                                                        ),
                                                        DataRow(
                                                          cells: <DataCell>[
                                                            DataCell(Text(
                                                                'Sede',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .redAccent,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        15))),
                                                            DataCell(Text(
                                                                "${user.data.degree_location}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15))),
                                                          ],
                                                        ),
                                                        DataRow(
                                                          cells: <DataCell>[
                                                            DataCell(Text(
                                                                'Percorso',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .redAccent,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        15))),
                                                            DataCell(Text(
                                                                "${user.data.degree_path_name}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15))),
                                                          ],
                                                        ),*/
                                                  ],
                                                )),
                                          ];
                                        } else if (course.hasError) {
                                          children = <Widget>[
                                            const Icon(
                                              Icons.error_outline,
                                              color: Colors.red,
                                              size: 60,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15),
                                              child: Text(
                                                  'Error: ${course.error}'),
                                            )
                                          ];
                                        } else {
                                          children = const <Widget>[
                                            SizedBox(
                                              child: CircularProgressIndicator(
                                                  backgroundColor:
                                                      ArgonColors.redUnito),
                                              width: 60,
                                              height: 60,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 15),
                                              child: Text('Awaiting result...',
                                                  style: TextStyle(
                                                      color: ArgonColors
                                                          .redUnito)),
                                            )
                                          ];
                                        }
                                        return Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: children,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                      ),
                    ]),
                  ])),
        ]))
      ]),
    );
    /*return new WillPopScope(
      onWillPop: _onWillPop,
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text("Home Page"),
        ),
        body: new Center(
          child: new Text("Home Page"),
        ),
      ),
    );*/
  }

  /*Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(courseData.course_name.toString().capitalize()),
            backgroundColor: Color.fromRGBO(213, 21, 36, 1)),
        drawer: ArgonDrawer("courseDetail"),
        body: Container());
  }*/
}
