import 'package:e_tutoring/constants/Theme.dart';
import 'package:e_tutoring/widgets/drawer.dart';
import 'package:e_tutoring/widgets/language_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavoriteTutor extends StatefulWidget {
  @override
  _FavoriteTutorState createState() => _FavoriteTutorState();
}

class _FavoriteTutorState extends State<FavoriteTutor> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(205, 205, 205, 1),
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).favorite_tutor),
          backgroundColor: Color.fromRGBO(213, 21, 36, 1),
          actions: <Widget>[
            LanguagePickerWidget(),
          ],
        ),
        drawer: ArgonDrawer("favorite-tutor"),
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          // height: 220,
          width: double.maxFinite,
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              Card(
                  elevation: 5,
                  child: ListTile(
                    title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Davide D.",
                              style: new TextStyle(fontSize: 20.0)),
                          Row(children: <Widget>[
                            Icon(Icons.map),
                            Text("Milano"),
                          ]),
                          Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: const <Widget>[
                                Icon(
                                  Icons.star,
                                  color: ArgonColors.redUnito,
                                  //size: 24.0,
                                  semanticLabel:
                                      'Text to announce in accessibility modes',
                                ),
                                Icon(
                                  Icons.star,
                                  color: ArgonColors.redUnito,
                                  //size: 30.0,
                                ),
                                Icon(
                                  Icons.star,
                                  color: ArgonColors.redUnito,
                                  //size: 36.0,
                                ),
                                Icon(
                                  Icons.star_border,
                                  color: ArgonColors.redUnito,
                                  //size: 36.0,
                                ),
                                Icon(
                                  Icons.star_border,
                                  color: ArgonColors.redUnito,
                                  //size: 36.0,
                                ),
                              ]),
                        ]),
                    subtitle: Text("Analisi matematica"),
                    leading: Container(
                        padding: EdgeInsets.only(right: 12.0),
                        decoration: new BoxDecoration(
                            border: new Border(
                                right: new BorderSide(
                                    width: 1.0, color: Colors.black))),
                        child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://png.pngtree.com/png-vector/20190710/ourmid/pngtree-user-vector-avatar-png-image_1541962.jpg"))),
                    trailing: Icon(Icons.star, color: ArgonColors.redUnito),
                    // selected: true,
                  )),
            ],
          ),
        ));
  }
}
