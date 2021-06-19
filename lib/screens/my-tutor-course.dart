import 'package:e_tutoring/constants/Theme.dart';
import 'package:e_tutoring/controller/controllerWS.dart';
import 'package:e_tutoring/model/tutorModel.dart';
import 'package:e_tutoring/screens/tutorCourse.dart';
import 'package:e_tutoring/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyTutorCourse extends StatefulWidget {
  @override
  MyTutorCourseState createState() => new MyTutorCourseState();
}

class MyTutorCourseState extends State<MyTutorCourse> {
  TutorModel tutor;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).my_courses),
          backgroundColor: Color.fromRGBO(213, 21, 36, 1),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TutorCourse()));
                }),
            IconButton(icon: Icon(Icons.remove), onPressed: () {}),
          ],
        ),
        drawer: ArgonDrawer("my-tutor-course"),
        body: Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            width: double.maxFinite,
            color: Colors.white,
            child: FutureBuilder<TutorModel>(
                future: getTutorDetailFromWS(http.Client()),
                builder:
                    (BuildContext context, AsyncSnapshot<TutorModel> tutor) {
                  List<Widget> children;
                  if (tutor.hasData) {
                    return ListView.builder(
                      itemCount: tutor.data.courses.length,
                      itemBuilder: (context, index) {
                        return Card(
                            elevation: 5,
                            child: ListTile(
                              onTap: () {},
                              leading: Container(
                                  padding: EdgeInsets.only(right: 12.0),
                                  decoration: new BoxDecoration(
                                      border: new Border(
                                          right: new BorderSide(
                                              width: 1.0,
                                              color: Colors.black))),
                                  child: Icon(
                                    Icons.school,
                                    color: Colors.green,
                                  )),
                              title: Text(
                                  '${tutor.data.courses[index]['course_name']}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              subtitle: Text(
                                  '${tutor.data.courses[index]['department']}',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15)),
                            ));
                      },
                    );
                  } else if (tutor.hasError) {
                    children = <Widget>[
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Text('Error: ${tutor.error}'),
                      )
                    ];
                  } else {
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
                  }
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: children,
                    ),
                  );
                })));
  }
}
