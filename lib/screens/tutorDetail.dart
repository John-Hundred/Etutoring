import 'package:e_tutoring/constants/Theme.dart';
import 'package:e_tutoring/widgets/language_picker_widget.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class TutorDetail extends StatefulWidget {
  dynamic tutorData;

  TutorDetail(dynamic tutor) {
    this.tutorData = tutor;
    // print(this.tutorData);
  }

  @override
  _TutorDetailState createState() => new _TutorDetailState(tutorData);
}

class _TutorDetailState extends State<TutorDetail> {
  dynamic tutorData;
  _TutorDetailState(dynamic tutor) {
    this.tutorData = tutor;
  }

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(205, 205, 205, 1),
      appBar: AppBar(
        title: Text(this.tutorData.firstname + " " + this.tutorData.lastname),
        backgroundColor: Color.fromRGBO(213, 21, 36, 1),
        actions: <Widget>[
          LanguagePickerWidget(),
        ],
      ),
      body: Stack(children: <Widget>[
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                // leading: Icon(Icons.person),
                title: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 150.0,
                        height: 150.0,
                        decoration: new BoxDecoration(
                          border: new Border.all(
                            color: Colors.white,
                            width: 10.0,
                          ),
                          image: new DecorationImage(
                              //fit: BoxFit.fill,
                              image: new NetworkImage(
                                  "https://png.pngtree.com/png-vector/20190710/ourmid/pngtree-user-vector-avatar-png-image_1541962.jpg")),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ]),
                subtitle: Column(
                  children: <Widget>[
                    Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.person),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 5.0, right: 15.0, top: 0.0),
                              child: Text(
                                  this.tutorData.firstname +
                                      " " +
                                      this.tutorData.lastname,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15))),
                        ]),
                    Row(
                        // mainAxisAlignment: MainAxisAlignment.left,
                        children: <Widget>[
                          Icon(Icons.email),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 5.0, right: 15.0, top: 0.0),
                              child: Text(this.tutorData.email,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15))),
                        ]),
                    Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.location_on),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 5.0, right: 15.0, top: 0.0),
                              child: Text(this.tutorData.residence_city,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15))),
                        ]),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 5.0, right: 15.0, top: 15.0),
                        child: Text(AppLocalizations.of(context).description,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold))),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 5.0, right: 15.0, top: 2.0),
                              child: Text(this.tutorData.description,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16)))
                        ]),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: const Text('CONTACT',
                        style: TextStyle(color: ArgonColors.redUnito)),
                    onPressed: () {/* ... */},
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
