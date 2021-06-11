import 'package:e_tutoring/constants/Theme.dart';
import 'package:e_tutoring/controller/controllerWS.dart';
import 'package:e_tutoring/model/tutorModel.dart';
import 'package:e_tutoring/screens/tutorDetail.dart';
import 'package:e_tutoring/widgets/drawer.dart';
import 'package:flutter/material.dart';

class Tutor extends StatefulWidget {
  @override
  _TutorState createState() => _TutorState();
}

class _TutorState extends State<Tutor> {
  List<TutorModel> tutorList;

  @override
  void initState() {
    super.initState();
    _IsSearching = false;
    getTutorSearchFromWS().then((value) => {
          setState(() {
            tutorList = value;
            // print(tutorList);
          })
        });
  }

  final searchController = TextEditingController();
  // ignore: non_constant_identifier_names
  bool _IsSearching;
  String _searchText = "";
  Widget appBarTitle = new Text(
    "Tutor",
    style: new TextStyle(color: Colors.white),
  );
  Icon actionIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );
  _TutorState() {
    searchController.addListener(() {
      if (searchController.text.isEmpty) {
        setState(() {
          _IsSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _IsSearching = true;
          _searchText = searchController.text;
        });
      }
    });
  }

  List<ChildItem> _buildList() {
    if (tutorList != null) {
      return tutorList.map((tutor) => new ChildItem(tutor)).toList();
    } else
      return [];
  }

  List<ChildItem> _buildSearchList() {
    if (_searchText.isEmpty) {
      return tutorList.map((tutor) => new ChildItem(tutor)).toList();
    } else {
      List<TutorModel> _searchList = [];
      for (int i = 0; i < tutorList.length; i++) {
        TutorModel tutor = tutorList.elementAt(i);
        // print(tutor);
        if (tutor
            .toString()
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          _searchList.add(tutor);
        }
      }
      // print(_searchList);
      return _searchList.map((tutor) => new ChildItem(tutor)).toList();
    }
  }

  void _handleSearchStart() {
    setState(() {
      _IsSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = new Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = new Text(
        "Tutor",
        style: new TextStyle(color: Colors.white),
      );
      _IsSearching = false;
      searchController.clear();
    });
  }

  Widget buildBar(BuildContext context) {
    return new AppBar(
        backgroundColor: Color.fromRGBO(213, 21, 36, 1),
        centerTitle: true,
        title: appBarTitle,
        actions: <Widget>[
          new IconButton(
            icon: actionIcon,
            onPressed: () {
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  this.actionIcon = new Icon(
                    Icons.close,
                    color: Colors.white,
                  );
                  this.appBarTitle = new TextField(
                    controller: searchController,
                    style: new TextStyle(
                      color: Colors.white,
                    ),
                    decoration: new InputDecoration(
                        prefixIcon: new Icon(Icons.search, color: Colors.white),
                        hintText: "Search...",
                        hintStyle: new TextStyle(color: Colors.white)),
                  );
                  _handleSearchStart();
                } else {
                  _handleSearchEnd();
                }
              });
            },
          ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildBar(context),
      drawer: ArgonDrawer("tutor"),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        // height: 220,
        width: double.maxFinite,
        color: Colors.white,
        child: ListView(
          padding: new EdgeInsets.symmetric(vertical: 8.0),
          children: _IsSearching ? _buildSearchList() : _buildList(),
        ),
      ),
    );
  }
}

class ChildItem extends StatelessWidget {
  final dynamic tutor;
  ChildItem(this.tutor);
  @override
  Widget build(BuildContext context) {
    // return new ListTile(title: new Text(this.name));
    return new Card(
        elevation: 5,
        child: ListTile(
          title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(this.tutor.firstname + " " + this.tutor.lastname,
                    style: new TextStyle(fontSize: 20.0)),
                Row(children: [
                  Icon(Icons.email),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: Text(this.tutor.email,
                          style: TextStyle(fontSize: 13)),
                    ),
                  ),
                ]),
                Row(children: [
                  Icon(Icons.location_on),
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.only(left: 5.0),
                          child: Text(this.tutor.residence_city))),
                ]),
                Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[starWidget(this.tutor)]),
              ]),
          subtitle: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: this.tutor.courses.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Text(
                          this.tutor.courses[index]['course_name'].toString(),
                          style: TextStyle(color: Colors.black));
                    })
              ]),
          leading: Container(
              padding: EdgeInsets.only(right: 12.0),
              decoration: new BoxDecoration(
                  border: new Border(
                      right: new BorderSide(width: 1.0, color: Colors.black))),
              child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://png.pngtree.com/png-vector/20190710/ourmid/pngtree-user-vector-avatar-png-image_1541962.jpg"))),
          trailing: Icon(Icons.star),
          onTap: () {
            // print(this.course.toString());
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TutorDetail(this.tutor)),
            );
          },
        ));
  }
}

Widget starWidget(tutorData) {
  // print(tutorData.avg_reviews);

  final items = <Widget>[];
  if (tutorData.avg_reviews <= 0) {
    // no reviews
    for (var i = 0; i < 5; i += 1) {
      items.add(Icon(
        Icons.star_border_outlined,
        color: ArgonColors.redUnito,
      ));
    }
  } else {
    int count = 0;
    // reviews > 0
    // items.add(Text(" (" + tutorData.avg_reviews.toString() + "/5)"));

    var avgInteger = tutorData.avg_reviews.truncate();
    for (var i = 0; i < avgInteger; i = i + 1) {
      items.add(Icon(
        Icons.star,
        color: ArgonColors.redUnito,
      ));
      count += 1;
    }
    dynamic avgFraction =
        tutorData.avg_reviews - tutorData.avg_reviews.truncate();
    if (avgFraction >= 0.5) {
      items.add(Icon(
        Icons.star_half_outlined,
        color: ArgonColors.redUnito,
      ));
      count += 1;
    }

    if (count < 5) {
      for (var i = 0; i < (5 - count); i = i + 1) {
        items.add(Icon(
          Icons.star_border_outlined,
          color: ArgonColors.redUnito,
        ));
      }
    }
  }

  // items.add(Text(" (" + tutorData.reviews.length.toString() + ")"));
  return Row(children: items);
}
