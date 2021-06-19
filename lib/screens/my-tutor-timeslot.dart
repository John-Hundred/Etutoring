import 'package:e_tutoring/constants/Theme.dart';
import 'package:e_tutoring/controller/controllerWS.dart';
import 'package:e_tutoring/model/tutorModel.dart';
import 'package:e_tutoring/screens/courseDetail.dart';
import 'package:e_tutoring/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyTutorTimeslot extends StatefulWidget {
  @override
  MyTutorTimeslotState createState() => new MyTutorTimeslotState();
}

class MyTutorTimeslotState extends State<MyTutorTimeslot> {
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
          title: Text(AppLocalizations.of(context).my_timeslot),
          backgroundColor: Color.fromRGBO(213, 21, 36, 1),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.add), onPressed: () {}),
            IconButton(icon: Icon(Icons.delete), onPressed: () {}),
          ],
        ),
        drawer: ArgonDrawer("my-tutor-timeslot"),
        body: Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            // height: 220,
            width: double.maxFinite,
            color: Colors.white,
            child: FutureBuilder<TutorModel>(
                future: getTutorDetailFromWS(http.Client()),
                builder:
                    (BuildContext context, AsyncSnapshot<TutorModel> tutor) {
                  List<Widget> children;
                  if (tutor.hasData) {
                    return ListView.builder(
                      itemCount: tutor.data.time_slot.length,
                      itemBuilder: (context, index) {
                        return Card(
                            elevation: 5,
                            child: ListTile(
                              leading: Container(
                                  padding: EdgeInsets.only(right: 12.0),
                                  decoration: new BoxDecoration(
                                      border: new Border(
                                          right: new BorderSide(
                                              width: 1.0,
                                              color: Colors.black))),
                                  child: Icon(
                                    Icons.timelapse,
                                    color: Colors.green,
                                  )),
                              title: Text(
                                  '${tutor.data.time_slot[index]['day']}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              subtitle: Text(
                                  tutor.data.time_slot[index]['hour_from'] +
                                      ' - ' +
                                      tutor.data.time_slot[index]['hour_to'],
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

class ChildItem extends StatelessWidget {
  final dynamic course;
  ChildItem(this.course);
  @override
  Widget build(BuildContext context) {
    // return new ListTile(title: new Text(this.name));
    return new Card(
        elevation: 5,
        child: ListTile(
          title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(this.course.course_name.toUpperCase(),
                    style: new TextStyle(fontSize: 18.0)),
                Row(children: [
                  Icon(Icons.event_available),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: Text(this.course.enrollment_year),
                    ),
                  ),
                ]),
              ]),
          subtitle: Row(children: <Widget>[
            Text('CFU: ' + this.course.course_cfu.toUpperCase(),
                style: TextStyle(
                  color: ArgonColors.redUnito,
                )),
          ]),
          leading: Container(
              padding: EdgeInsets.only(right: 12.0),
              decoration: new BoxDecoration(
                  border: new Border(
                      right: new BorderSide(width: 1.0, color: Colors.black))),
              child: Icon(Icons.school)),
          trailing: this.course.private_lesson_id != '-'
              ? Icon(
                  Icons.calendar_today,
                  color: Colors.green,
                )
              : Icon(Icons.not_interested, color: Colors.red),
          onTap: () {
            // print(this.course.toString());
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CourseDetail(this.course)),
            );
          },
        ));
  }
}
