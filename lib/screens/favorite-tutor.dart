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
                        child: Card(),
                      ),
                    ]),
                  ])),
        ]))
      ]),
    );
  }
}
