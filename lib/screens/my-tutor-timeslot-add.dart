import 'package:e_tutoring/constants/Theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyTutorTimeslotAdd extends StatefulWidget {
  @override
  MyTutorTimeslotAddState createState() => new MyTutorTimeslotAddState();
}

class MyTutorTimeslotAddState extends State<MyTutorTimeslotAdd> {
  DateTime currentDate = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.red,
                primaryColorDark: Colors.red,
                accentColor: Colors.red,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child,
          );
        });
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).add_time_slot),
        backgroundColor: Color.fromRGBO(213, 21, 36, 1),
        actions: <Widget>[],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(currentDate.toString()),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text('Select date'),
              style: ElevatedButton.styleFrom(primary: ArgonColors.redUnito),
            ),
          ],
        ),
      ),
    );
  }
}
