import 'package:argon_flutter/constants/Theme.dart';
import 'package:argon_flutter/controller/controllerWS.dart';
import 'package:argon_flutter/model/courseModel.dart';
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:flutter/material.dart';

class Course extends StatefulWidget {
  @override
  CourseState createState() => new CourseState();
}

class CourseState extends State<Course> {
  final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
  var items = [];

  String searchString = "";
  final searchController = TextEditingController();

  @override
  void initState() {
    items.addAll(duplicateItems);
    super.initState();
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = [];
    dummySearchList.addAll(duplicateItems);
    if (query.isNotEmpty) {
      List<String> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
          title: const Text('Course'),
          backgroundColor: Color.fromRGBO(213, 21, 36, 1)),
      drawer: ArgonDrawer("course"),
      body:
          /*Stack(children: <Widget>[
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
                          controller: searchController,
                          onChanged: (value) {
                            setState(() {
                              searchString = value;
                              // print(searchString);
                              this.futureCourseList = getUserCourseListFromWS(
                                  searchString: searchString);
                              // print(this.futureCourseList);
                            });
                          },
                          decoration: InputDecoration(
                            labelText: "Search",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0))),
                            hintText: 'Search ...',
                            prefixIcon: Icon(Icons.search),
                            /*suffixIcon: IconButton(
                              onPressed: () => '',
                              icon: Icon(Icons.search),
                            ),*/
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
                      future: this.futureCourseList,
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
                    )),
                  ]))
        ]))
      ]),*/
          Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: searchController,
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            /*Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${items[index]}'),
                  );
                },
              ),
            ),*/
            projectWidget(),
          ],
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
      future: getUserCourseListFromWS(),
    );
  }
}
