import 'package:e_tutoring/constants/Theme.dart';
import 'package:e_tutoring/model/TutorTimeslotModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class UserTutorTimeslot extends StatefulWidget {
  dynamic tutorData;

  UserTutorTimeslot(dynamic tutorData) {
    this.tutorData = tutorData;
  }

  @override
  UserTutorTimeslotState createState() => new UserTutorTimeslotState(tutorData);
}

class UserTutorTimeslotState extends State<UserTutorTimeslot> {
  dynamic tutorData;
  UserTutorTimeslotState(dynamic tutorData) {
    this.tutorData = tutorData;
    // print(this.tutorData.time_slot);
  }
  List<TutorTimeslotModel> timeslotListSelected = [];
  List<TutorTimeslotModel> timeslotList = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      for (var timeslot in this.tutorData.time_slot) {
        timeslotList.add(TutorTimeslotModel.fromJson(timeslot));
      }
    });
  }

  List<ChildItem> _buildList() {
    if (timeslotList != null) {
      return timeslotList
          .map((timeslot) => new ChildItem(timeslot, timeslotListSelected))
          .toList();
    } else
      return [];
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(this.tutorData.firstname +
            " " +
            this.tutorData.lastname +
            " " +
            AppLocalizations.of(context).time_slot),
        backgroundColor: Color.fromRGBO(213, 21, 36, 1),
      ),
      body: Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          // height: 220,
          width: double.maxFinite,
          color: Colors.white,
          child: ListView(
            padding: new EdgeInsets.symmetric(vertical: 8.0),
            children: (this.timeslotList.length == 0
                ? [
                    const SizedBox(height: 30),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.image_search),
                          Text(
                              AppLocalizations.of(context)
                                  .result_tutor_not_found_time_slot,
                              style: TextStyle(fontSize: 18)),
                        ])
                  ]
                : _buildList()),
          )),
      floatingActionButton: new FloatingActionButton(
        backgroundColor: ArgonColors.redUnito,
        child: new Icon(Icons.add),
        onPressed: () => {},
      ),
    );
  }
}

// ignore: must_be_immutable
class ChildItem extends StatefulWidget {
  dynamic course;
  List<TutorTimeslotModel> courseListSelected = [];

  ChildItem(course, courseListSelected) {
    this.course = course;
    this.courseListSelected = courseListSelected;
  }

  @override
  ChildItemState createState() =>
      new ChildItemState(this.course, this.courseListSelected);
}

class ChildItemState extends State<ChildItem> {
  final TutorTimeslotModel timeslot;
  List<TutorTimeslotModel> timeslotListSelected = [];
  ChildItemState(this.timeslot, this.timeslotListSelected);

  String formatDate(date) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    String formatted = formatter.format(date);
    return formatted;
  }

  @override
  Widget build(BuildContext context) {
    return new Card(
        elevation: 5,
        child: ListTile(
            onTap: () {
              setState(() {
                timeslot.selected = !this.timeslot.selected;
              });
              if (timeslot.selected) {
                timeslotListSelected.add(this.timeslot);
              } else {
                timeslotListSelected.remove(this.timeslot);
              }
            },
            leading: Container(
                padding: EdgeInsets.only(right: 12.0),
                decoration: new BoxDecoration(
                    border: new Border(
                        right:
                            new BorderSide(width: 1.0, color: Colors.black))),
                child: Icon(
                  Icons.timelapse,
                  color: Colors.green,
                )),
            title: Text(
                DateFormat('EEEE').format(DateTime.parse(timeslot.day)) +
                    " | " +
                    formatDate(DateTime.parse(timeslot.day)),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            subtitle: Text(timeslot.hour_from + ' - ' + timeslot.hour_to,
                style: TextStyle(color: Colors.black, fontSize: 15)),
            trailing: (timeslot.selected)
                ? Icon(Icons.check_box)
                : Icon(Icons.check_box_outline_blank)));
  }
}
