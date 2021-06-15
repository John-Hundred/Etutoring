import 'package:e_tutoring/widgets/language_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileEdit extends StatefulWidget {
  @override
  _ProfileStateEdit createState() => _ProfileStateEdit();
}

class _ProfileStateEdit extends State<ProfileEdit> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text(AppLocalizations.of(context).edit_profile),
      backgroundColor: Color.fromRGBO(213, 21, 36, 1),
      actions: [LanguagePickerWidget()],
    ));
  }
}
