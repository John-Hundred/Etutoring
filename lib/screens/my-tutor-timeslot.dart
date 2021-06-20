import 'package:e_tutoring/constants/Theme.dart';
import 'package:e_tutoring/controller/controllerWS.dart';
import 'package:e_tutoring/model/tutorModel.dart';
import 'package:e_tutoring/screens/my-tutor-timeslot-add.dart';
import 'package:e_tutoring/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class MyTutorTimeslot extends StatefulWidget {
  @override
  MyTutorTimeslotState createState() => new MyTutorTimeslotState();
}

class MyTutorTimeslotState extends State<MyTutorTimeslot> {
  @override
  void initState() {
    super.initState();
  }

  String formatDate(date) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    String formatted = formatter.format(date);
    return formatted;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).my_timeslot),
        backgroundColor: Color.fromRGBO(213, 21, 36, 1),
        actions: <Widget>[
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
              builder: (BuildContext context, AsyncSnapshot<TutorModel> tutor) {
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
                                            width: 1.0, color: Colors.black))),
                                child: Icon(
                                  Icons.timelapse,
                                  color: Colors.green,
                                )),
                            title: Text(
                                DateFormat('EEEE').format(DateTime.parse(
                                        tutor.data.time_slot[index]['day'])) +
                                    " | " +
                                    formatDate(DateTime.parse(
                                        tutor.data.time_slot[index]['day'])),
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
              })),
      floatingActionButton: new FloatingActionButton(
        backgroundColor: ArgonColors.redUnito,
        child: new Icon(Icons.add),
        onPressed: () => {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MyTutorTimeslotAdd()))
        },
      ),
    );
  }
}
