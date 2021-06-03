import 'package:argon_flutter/controller/controllerWS.dart';
import 'package:argon_flutter/model/courseModel.dart';
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:flutter/material.dart';

class Course extends StatefulWidget {
  @override
  CourseState createState() => new CourseState();
}

class CourseState extends State<Course> {
  /*
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
          title: const Text('Course'),
          backgroundColor: Color.fromRGBO(213, 21, 36, 1)),
      drawer: ArgonDrawer("course"),
      body: Stack(children: <Widget>[
        SafeArea(
            child: ListView(children: [
          Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      child: Card(
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Search ...',
                            suffixIcon: IconButton(
                              onPressed: () => '',
                              icon: Icon(Icons.search),
                            ),
                          ),
                        ),
                      ),
                    ),
                    /*SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Lista dei Corsi',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),*/
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        child: FutureBuilder<List<CourseModel>>(
                      future: getUserCourseListFromWS(),
                      builder: (ctx, snapshot) {
                        // print(snapshot);
                        if (snapshot.connectionState == ConnectionState.none &&
                            snapshot.hasData == null) {
                          return Container();
                        } else {
                          List<CourseModel> courseList = snapshot.data;
                          if (courseList != null) {
                            List<DataRow> _rowList = [];
                            var course;
                            for (course in courseList) {
                              _rowList.add(DataRow(cells: <DataCell>[
                                DataCell(
                                    Text(course.course_name.toUpperCase())),
                                DataCell(Text(course.course_cfu.toUpperCase())),
                                course.private_lesson_id == '-'
                                    ? DataCell(
                                        Icon(
                                          Icons.no_cell_sharp,
                                          color: Colors.red,
                                          size: 30.0,
                                        ),
                                      )
                                    : DataCell(
                                        Icon(
                                          Icons.calendar_today,
                                          color: Colors.green,
                                          size: 30.0,
                                        ),
                                      ),
                              ]));
                            }
                            return DataTable(
                                dataRowColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.white),
                                // headingRowHeight: 0,
                                columns: <DataColumn>[
                                  DataColumn(label: Text('Course')),
                                  DataColumn(label: Text('CFU')),
                                  DataColumn(label: Text('Tutoring')),
                                ],
                                rows: _rowList);
                          }
                          return Container();
                        }
                      },
                    ))
                  ]))
        ]))
      ]),
    );
  }
  */

  var _searchview = new TextEditingController();

  bool _firstSearch = true;
  String _query = "";

  List<String> _nebulae;

  List<String> _filterList;

  @override
  void initState() {
    super.initState();
  }

  CourseState() {
    //Register a closure to be called when the object changes.
    _searchview.addListener(() {
      if (_searchview.text.isEmpty) {
        //Notify the framework that the internal state of this object has changed.
        setState(() {
          _firstSearch = true;
          _query = "";
        });
      } else {
        setState(() {
          _firstSearch = false;
          _query = _searchview.text;
        });
      }
    });
  }

//Build our Home widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Course'),
          backgroundColor: Color.fromRGBO(213, 21, 36, 1)),
      drawer: ArgonDrawer("course"),
      body: new Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: new Column(
          children: <Widget>[
            FutureBuilder<List<CourseModel>>(
                future: getUserCourseListFromWS(),
                builder: (ctx, snapshot) {
                  //print(snapshot);
                  _nebulae = new List<String>();
                  _nebulae = [];
                  var course;
                  List<CourseModel> courseList = snapshot.data;
                  for (course in courseList) {
                    _nebulae.add(course.course_name);
                  }
                  print(_nebulae);
                  _nebulae.sort();
                  _createSearchView();
                  _firstSearch ? _createListView() : _performSearch();

                  if (snapshot.connectionState == ConnectionState.none &&
                      snapshot.hasData == null) {
                    return Container();
                  } else {
                    List<CourseModel> courseList = snapshot.data;
                    if (courseList != null) {
                      List<DataRow> _rowList = [];
                      var course;
                      for (course in courseList) {
                        _rowList.add(DataRow(cells: <DataCell>[
                          DataCell(Text(course.course_name.toUpperCase())),
                          DataCell(Text(course.course_cfu.toUpperCase())),
                          course.private_lesson_id == '-'
                              ? DataCell(
                                  Icon(
                                    Icons.no_cell_sharp,
                                    color: Colors.red,
                                    size: 30.0,
                                  ),
                                )
                              : DataCell(
                                  Icon(
                                    Icons.calendar_today,
                                    color: Colors.green,
                                    size: 30.0,
                                  ),
                                ),
                        ]));
                      }
                      return DataTable(
                          dataRowColor: MaterialStateColor.resolveWith(
                              (states) => Colors.white),
                          // headingRowHeight: 0,
                          columns: <DataColumn>[
                            DataColumn(label: Text('Course')),
                            DataColumn(label: Text('CFU')),
                            DataColumn(label: Text('Tutoring')),
                          ],
                          rows: _rowList);
                    }
                    return Container();
                  }
                }),
          ],
        ),
      ),
    );
  }

  //Create a SearchView
  Widget _createSearchView() {
    return new Container(
      decoration: BoxDecoration(border: Border.all(width: 1.0)),
      child: new TextField(
        controller: _searchview,
        decoration: InputDecoration(
          hintText: "Search",
          hintStyle: new TextStyle(color: Colors.grey[300]),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  //Create a ListView widget
  Widget _createListView() {
    return new Flexible(
      child: new ListView.builder(
          itemCount: _nebulae.length,
          itemBuilder: (BuildContext context, int index) {
            return new Card(
              color: Colors.white,
              elevation: 5.0,
              child: new Container(
                margin: EdgeInsets.all(15.0),
                child: new Text("${_nebulae[index]}"),
              ),
            );
          }),
    );
  }

  //Perform actual search
  Widget _performSearch() {
    _filterList = new List<String>();
    for (int i = 0; i < _nebulae.length; i++) {
      var item = _nebulae[i];

      if (item.toLowerCase().contains(_query.toLowerCase())) {
        _filterList.add(item);
      }
    }
    return _createFilteredListView();
  }

  //Create the Filtered ListView
  Widget _createFilteredListView() {
    return new Flexible(
      child: new ListView.builder(
          itemCount: _filterList.length,
          itemBuilder: (BuildContext context, int index) {
            return new Card(
              color: Colors.white,
              elevation: 5.0,
              child: new Container(
                margin: EdgeInsets.all(15.0),
                child: new Text("${_filterList[index]}"),
              ),
            );
          }),
    );
  }
}
