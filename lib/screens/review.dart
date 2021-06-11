import 'package:e_tutoring/controller/controllerWS.dart';
import 'package:e_tutoring/model/reviewModel.dart';
import 'package:e_tutoring/widgets/language_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class Review extends StatefulWidget {
  dynamic tutorData;

  Review(dynamic tutorData) {
    this.tutorData = tutorData;
  }

  @override
  _ReviewState createState() => new _ReviewState(tutorData);
}

class _ReviewState extends State<Review> {
  dynamic tutorData;

  List<ReviewModel> reviewList;

  _ReviewState(dynamic tutorData) {
    this.tutorData = tutorData;
  }

  @override
  void initState() {
    super.initState();
    getReviewFromWS(tutorData.id).then((value) => {
          setState(() {
            reviewList = value;
          })
        });
  }

  Icon actionIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );

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
      body: ListView.builder(
        itemCount: reviewList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${reviewList[index]}'),
          );
        },
      ),
    );
  }
}
