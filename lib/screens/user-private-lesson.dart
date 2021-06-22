import 'package:e_tutoring/constants/Theme.dart';
import 'package:e_tutoring/controller/controllerWS.dart';
import 'package:e_tutoring/model/privatelessonModel.dart';
import 'package:e_tutoring/screens/user-review-add.dart';
import 'package:e_tutoring/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class UserPrivateLesson extends StatefulWidget {
  @override
  UserPrivateLessonState createState() => new UserPrivateLessonState();
}

class UserPrivateLessonState extends State<UserPrivateLesson> {
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
        title: Text(AppLocalizations.of(context).private_lesson),
        backgroundColor: Color.fromRGBO(213, 21, 36, 1),
      ),
      drawer: ArgonDrawer("private-lesson"),
      body: Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          // height: 220,
          width: double.maxFinite,
          color: Colors.white,
          child: FutureBuilder<List<PrivatelessonModel>>(
              future: getPrivateLessonFromWS(http.Client()),
              builder: (BuildContext context,
                  AsyncSnapshot<List<PrivatelessonModel>> lessonSnapshot) {
                List<Widget> children;
                if (lessonSnapshot.hasData) {
                  return ListView.builder(
                    itemCount: lessonSnapshot.data.length,
                    itemBuilder: (context, index) {
                      return Card(
                          elevation: 5,
                          child: ListTile(
                            onTap: () {
                              // print(lessonSnapshot.data[index].tutor[0]['user_id']);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      UserReviewAdd(lessonSnapshot.data[index]),
                                ),
                              );
                            },
                            leading: Container(
                                padding: EdgeInsets.only(right: 12.0),
                                decoration: new BoxDecoration(
                                    border: new Border(
                                        right: new BorderSide(
                                            width: 1.0, color: Colors.black))),
                                child: Icon(Icons.calendar_today)),
                            title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    lessonSnapshot.data[index].course_name,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                      lessonSnapshot
                                              .data[index].tutor[0]['firstname']
                                              .toString()
                                              .toUpperCase() +
                                          ' ' +
                                          lessonSnapshot
                                              .data[index].tutor[0]['lastname']
                                              .toString()
                                              .toUpperCase(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text(DateFormat('EEEE').format(DateTime.parse(
                                          lessonSnapshot.data[index].day)) +
                                      " | " +
                                      formatDate(DateTime.parse(
                                          lessonSnapshot.data[index].day))),
                                ]),
                            subtitle: Text(
                                lessonSnapshot.data[index].hour_from +
                                    ' - ' +
                                    lessonSnapshot.data[index].hour_to),
                          ));
                    },
                  );
                } else if (lessonSnapshot.hasError) {
                  children = <Widget>[
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text('Error: ${lessonSnapshot.error}'),
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
      /*floatingActionButton: new FloatingActionButton(
        backgroundColor: ArgonColors.redUnito,
        child: new Icon(Icons.add),
        onPressed: () => {},
      ),*/
    );
  }
}
