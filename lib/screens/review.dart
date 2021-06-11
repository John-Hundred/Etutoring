import 'package:e_tutoring/widgets/language_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Review extends StatefulWidget {
  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(205, 205, 205, 1),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).reviews),
        backgroundColor: Color.fromRGBO(213, 21, 36, 1),
        actions: <Widget>[
          LanguagePickerWidget(),
        ],
      ),
      // drawer: ArgonDrawer("reviews"),
      body: SingleChildScrollView(),
    );
  }
}
