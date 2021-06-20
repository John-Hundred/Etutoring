import 'dart:convert';

import 'package:e_tutoring/config/config.dart';
import 'package:e_tutoring/constants/Theme.dart';
import 'package:e_tutoring/screens/router-dispatcher.dart';
import 'package:e_tutoring/utils/user_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

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

// CONTROLLER
  Future addTimeslot(day, houFrom, hourTo) async {
    try {
      String email = await UserSecureStorage.getEmail();

      var data = {
        'email': email,
        'day': day,
        'hour_from': houFrom,
        'hour_to': hourTo
      };

      var response = await http
          .post(Uri.https(authority, unencodedPath + 'add_tutor_time_slot.php'),
              headers: <String, String>{'authorization': basicAuth},
              body: json.encode(data))
          .timeout(const Duration(seconds: 8));
      if (response.statusCode == 200) {
        var message = jsonDecode(response.body);
        // print(response.body);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text(message),
              actions: <Widget>[
                TextButton(
                  child: new Text(
                    "OK",
                    style: TextStyle(color: ArgonColors.redUnito),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RouterDispatcher()));
                  },
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("Error adding availability"),
              actions: <Widget>[
                TextButton(
                  child: new Text(
                    "OK",
                    style: TextStyle(color: ArgonColors.redUnito),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } on Exception {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error adding courses. Verify Your Connection.'),
        backgroundColor: Colors.redAccent,
      ));
    }
  }

  Future<void> _selectTimeFrom(BuildContext context) async {
    final TimeOfDay newTime = await showTimePicker(
        context: context,
        initialTime: _timeFrom,
        //initialEntryMode: TimePickerEntryMode.input,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: Theme(
              data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.fromSwatch(
                  primarySwatch: Colors.red,
                  primaryColorDark: Colors.red,
                  accentColor: Colors.red,
                ),
                dialogBackgroundColor: Colors.white,
              ),
              child: child,
            ),
          );
        });
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
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: Theme(
              data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.fromSwatch(
                  primarySwatch: Colors.red,
                  primaryColorDark: Colors.red,
                  accentColor: Colors.red,
                ),
                dialogBackgroundColor: Colors.white,
              ),
              child: child,
            ),
          );
        });
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
        firstDate: DateTime(2020),
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

  String formatDate(date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String formatted = formatter.format(date);
    return formatted;
  }

  String formatTime(timeHour) {
    timeHour = timeHour.replaceAll(' ', '');
    DateFormat df;
    DateTime dt;
    df = DateFormat("h:mma");
    dt = df.parse(timeHour);
    return DateFormat('HH:mm').format(dt);
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
            child: Text('Select date',
                style: TextStyle(color: ArgonColors.redUnito)),
            style: ElevatedButton.styleFrom(primary: Colors.white70),
          ),
          Text(formatDate(currentDate).toString()),
          ElevatedButton(
              onPressed: () => _selectTimeFrom(context),
              child: Text('Select from hour',
                  style: TextStyle(color: ArgonColors.redUnito)),
              style: ElevatedButton.styleFrom(primary: Colors.white70)),
          SizedBox(height: 8),
          Text(
            formatTime(_timeFrom.format(context)),
          ),
          ElevatedButton(
              onPressed: () => _selectTimeTo(context),
              child: Text('Select to hour',
                  style: TextStyle(color: ArgonColors.redUnito)),
              style: ElevatedButton.styleFrom(primary: Colors.white70)),
          SizedBox(height: 8),
          Text(
            formatTime(_timeTo.format(context)),
          ),
          ElevatedButton(
              onPressed: () => {
                    addTimeslot(
                        formatDate(currentDate).toString(),
                        formatTime(_timeFrom.format(context)),
                        formatTime(_timeTo.format(context)))
                  },
              child: Text(AppLocalizations.of(context).add_time_slot),
              style: ElevatedButton.styleFrom(primary: ArgonColors.redUnito)),
        ],
      )),
    );
  }
}
