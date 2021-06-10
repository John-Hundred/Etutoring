import 'package:e_tutoring/widgets/drawer.dart';
import 'package:e_tutoring/widgets/language_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Tutor extends StatefulWidget {
  @override
  _TutorState createState() => _TutorState();
}

class _TutorState extends State<Tutor> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(205, 205, 205, 1),
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).tutor),
          backgroundColor: Color.fromRGBO(213, 21, 36, 1),
          actions: <Widget>[
            LanguagePickerWidget(),
          ],
        ),
        drawer: ArgonDrawer("tutor"),
        body: Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            // height: 220,
            width: double.maxFinite,
            child: Card(
              elevation: 5,
              child: ListView(
                padding: const EdgeInsets.all(8),
                children: <Widget>[
                  ListTile(
                      title: Text("Luca M. - Torino"),
                      subtitle: Text("Programmazione"),
                      leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://png.pngtree.com/png-vector/20190710/ourmid/pngtree-user-vector-avatar-png-image_1541962.jpg")),
                      trailing: Icon(Icons.star)),
                  ListTile(
                      title: Text("Simone B. - Torino"),
                      subtitle: Text("Agenti Intelligenti"),
                      leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://png.pngtree.com/png-vector/20190710/ourmid/pngtree-user-vector-avatar-png-image_1541962.jpg")),
                      trailing: Icon(Icons.star)),
                  ListTile(
                      title: Text("Davide D. - Milano"),
                      subtitle: Text("Analisi matematica"),
                      leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://png.pngtree.com/png-vector/20190710/ourmid/pngtree-user-vector-avatar-png-image_1541962.jpg")),
                      trailing: Icon(Icons.star)),
                  ListTile(
                      title: Text("Carlo C. - Novara"),
                      subtitle: Text("Database multimediali"),
                      leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://png.pngtree.com/png-vector/20190710/ourmid/pngtree-user-vector-avatar-png-image_1541962.jpg")),
                      trailing: Icon(Icons.star))
                ],
              ),
              /*child: Padding(
                padding: EdgeInsets.all(7),
                child: Stack(children: <Widget>[
                  Align(
                    alignment: Alignment.centerRight,
                    child: Stack(
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(left: 10, top: 5),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Icon(
                                            Icons.ac_unit,
                                            color: Colors.amber,
                                            size: 40,
                                          )),
                                    )
                                  ],
                                )
                              ],
                            ))
                      ],
                    ),
                  )
                ]),
              ),*/
            )));
  }
}
