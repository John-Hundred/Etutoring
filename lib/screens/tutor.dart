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
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            ListTile(
                title: Text("Tutor 1"),
                subtitle: Text("Tutor 1"),
                leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1547721064-da6cfb341d50")),
                trailing: Icon(Icons.star)),
            ListTile(
                title: Text("Tutor 2"),
                subtitle: Text("Tutor 2"),
                leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1547721064-da6cfb341d50")),
                trailing: Icon(Icons.star)),
            ListTile(
                title: Text("Tutor 3"),
                subtitle: Text("Tutor 3"),
                leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1547721064-da6cfb341d50")),
                trailing: Icon(Icons.star))
          ],
        ));
  }
}
