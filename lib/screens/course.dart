import 'package:argon_flutter/constants/Theme.dart';
import 'package:argon_flutter/controller/controllerWS.dart';
import 'package:argon_flutter/model/courseModel.dart';
import 'package:argon_flutter/screens/courseDetail.dart';
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:flutter/material.dart';

class Course extends StatefulWidget {
  @override
  CourseState createState() => new CourseState();
}

class CourseState extends State<Course> {
  List<CourseModel> courseList;

  String searchString = "";

  final searchController = TextEditingController();
  // ignore: non_constant_identifier_names
  bool _IsSearching;
  String _searchText = "";
  Widget appBarTitle = new Text(
    "Course",
    style: new TextStyle(color: Colors.white),
  );
  Icon actionIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );
  final key = new GlobalKey<ScaffoldState>();

  CourseState() {
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

  @override
  void initState() {
    super.initState();
    _IsSearching = false;
    getUserCourseSearchFromWS().then((value) => {
          setState(() {
            courseList = value;
            // print(courseList);
          })
        });
  }

  List<ChildItem> _buildList() {
    if (courseList != null) {
      return courseList.map((course) => new ChildItem(course)).toList();
    } else
      return [];
  }

  List<ChildItem> _buildSearchList() {
    if (_searchText.isEmpty) {
      return courseList.map((course) => new ChildItem(course)).toList();
    } else {
      List<CourseModel> _searchList = [];
      for (int i = 0; i < courseList.length; i++) {
        CourseModel course = courseList.elementAt(i);
        if (course
            .toString()
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          _searchList.add(course);
        }
      }
      // print(_searchList);
      return _searchList.map((course) => new ChildItem(course)).toList();
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
        "Search Sample",
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
      appBar: buildBar(context),
      drawer: ArgonDrawer("course"),
      body: Container(
        child: ListView(
          padding: new EdgeInsets.symmetric(vertical: 8.0),
          children: _IsSearching ? _buildSearchList() : _buildList(),
        ),
      ),
    );
  }

  Widget projectWidget() {
    return FutureBuilder(
      builder: (context, courseSnap) {
        if (courseSnap.hasData) {
          return Expanded(
              child: ListView.builder(
            shrinkWrap: true,
            itemCount: courseSnap.data.length ?? 0,
            itemBuilder: (context, index) {
              CourseModel course = courseSnap.data[index];
              return ListTile(
                title: Text(course.course_name.toUpperCase()),
              );
            },
          ));
        }

        if (courseSnap.hasData == null) {
          // print('project snapshot data is: ${courseSnap.data}');
          return SizedBox(
            child: CircularProgressIndicator(
                backgroundColor: ArgonColors.redUnito),
            width: 60,
            height: 60,
          );
        } else if (courseSnap.hasError) {
          List<Widget> children;
          children = <Widget>[
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text('Error: ${courseSnap.error}'),
            )
          ];
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
          );
        } else {
          List<Widget> children;
          children = const <Widget>[
            SizedBox(
              child: CircularProgressIndicator(
                  backgroundColor: ArgonColors.redUnito),
              width: 60,
              height: 60,
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Text('Awaiting result...',
                  style: TextStyle(color: ArgonColors.redUnito)),
            )
          ];
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
          );
        }
      },
      future: getUserCourseSearchFromWS(),
    );
  }
}

class ChildItem extends StatelessWidget {
  final dynamic course;
  ChildItem(this.course);
  @override
  Widget build(BuildContext context) {
    // return new ListTile(title: new Text(this.name));
    return new ListTile(
      title: Text(this.course.course_name.toUpperCase()),
      subtitle: Text('CFU: ' + this.course.course_cfu.toUpperCase()),
      leading: Icon(Icons.library_books),
      trailing: this.course.private_lesson_id != '-'
          ? Icon(
              Icons.calendar_today,
              color: Colors.green,
            )
          : Icon(Icons.not_interested, color: Colors.red),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CourseDetail(this.course)),
        );
      },
    );
  }
}
