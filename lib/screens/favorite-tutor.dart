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
        body: Card(
            child: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            ListTile(
                title: Text("Luca M. - Torino"),
                subtitle: Text("Programmazione"),
                selected: true,
                leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://png.pngtree.com/png-vector/20190710/ourmid/pngtree-user-vector-avatar-png-image_1541962.jpg")),
                trailing: Icon(Icons.star)),
          ],
        )));
  }
}
