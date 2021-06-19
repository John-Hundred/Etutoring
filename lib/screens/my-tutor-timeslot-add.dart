import 'package:e_tutoring/constants/Theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyTutorTimeslotAdd extends StatefulWidget {
  @override
  MyTutorTimeslotAddState createState() => new MyTutorTimeslotAddState();
}

class MyTutorTimeslotAddState extends State<MyTutorTimeslotAdd> {
  DateTime currentDate = DateTime.now();
  TimeOfDay _timeFrom = TimeOfDay(hour: 16, minute: 00);
  TimeOfDay _timeTo = TimeOfDay(hour: 18, minute: 00);

  @override
  void initState() {
    super.initState();
  }

  Future<void> _selectTimeFrom(BuildContext context) async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: _timeFrom,
      //initialEntryMode: TimePickerEntryMode.input,
    );
    if (newTime != null) {
      setState(() {
        _timeFrom = newTime;
      });
    }
  }

  Future<void> _selectTimeTo(BuildContext context) async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: _timeTo,
      //initialEntryMode: TimePickerEntryMode.input,
    );
    if (newTime != null) {
      setState(() {
        _timeTo = newTime;
      });
    }
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
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text('Select date'),
              style: ElevatedButton.styleFrom(primary: ArgonColors.redUnito),
            ),
            Text(currentDate.toString()),
            ElevatedButton(
                onPressed: () => _selectTimeFrom(context),
                child: Text('Select from hour'),
                style: ElevatedButton.styleFrom(primary: ArgonColors.redUnito)),
            SizedBox(height: 8),
            Text(
              'Selected time: ${_timeFrom.format(context)}',
            ),
            ElevatedButton(
                onPressed: () => _selectTimeTo(context),
                child: Text('Select to hour'),
                style: ElevatedButton.styleFrom(primary: ArgonColors.redUnito)),
            SizedBox(height: 8),
            Text(
              'Selected time: ${_timeTo.format(context)}',
            ),
          ],
        ),
      ),
    );
  }
}
