import 'package:e_tutoring/widgets/drawer.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChatDetail extends StatefulWidget {
  @override
  _ChatDetailState createState() => _ChatDetailState();
}

class _ChatDetailState extends State<ChatDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromRGBO(205, 205, 205, 1),
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).chat),
          backgroundColor: Color.fromRGBO(213, 21, 36, 1),
          actions: <Widget>[
            // LanguagePickerWidget(),
          ],
        ),
        drawer: ArgonDrawer("chat-detail"),
        body: Container());
  }
}
