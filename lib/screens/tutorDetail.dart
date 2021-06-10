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
        SafeArea(
            child: ListView(children: [
          /* Padding(
              padding:
                  const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Stack(children: <Widget>[
                      Container(
                        child: new Card(
                          child: new Stack(
                            alignment: AlignmentDirectional.center,
                            children: <Widget>[
                              new Container(
                                width: 150.0,
                                height: 150.0,
                              ),
                              new Container(
                                alignment: new FractionalOffset(0.0, 0.0),
                                decoration: new BoxDecoration(
                                  border: new Border.all(
                                    color: ArgonColors.redUnito,
                                    width: 50.0,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Text(this.tutorData.firstname,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ])),*/
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
            child: Card(
                child: DataTable(
                    dataRowHeight: 50,
                    dataRowColor: MaterialStateColor.resolveWith(
                        (states) => Colors.white),
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
                        "Email",
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      )),
                      DataCell(Text(this.tutorData.email,
                          style: TextStyle(fontSize: 15))),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text(
                        AppLocalizations.of(context).residence_city,
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      )),
                      DataCell(Text(this.tutorData.residence_city,
                          style: TextStyle(fontSize: 15))),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text(
                        AppLocalizations.of(context).description,
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      )),
                      DataCell(Text(this.tutorData.description,
                          style: TextStyle(fontSize: 15))),
                    ],
                  ),
                ])),
          )
        ]))
      ]),
    );
  }
}
