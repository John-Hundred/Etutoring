import 'dart:ui';
import 'package:argon_flutter/model/course.dart';
import 'package:flutter/material.dart';
import 'package:argon_flutter/constants/Theme.dart';

//widgets
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:argon_flutter/widgets/drawer.dart';

// ignore: must_be_immutable
class Testhttp extends StatelessWidget {
  Future<List<Course>> futureListCourse = fetchCourse();

  getListWidgetData() {
    List<Widget> coursesList =
        []; // this will hold Rows according to available lines

    fetchCourse().then((courses) => {
          for (var course in courses)
            {
              // print(course.toString())
              coursesList.add(Text(course.toString())),
              // print(coursesList)
            }
        });
    print(coursesList);
    return coursesList;
  }

  getData() {
    // this.getListWidgetData();
    return FutureBuilder<List<Course>>(
      future: this.futureListCourse,
      builder: (context, courses) {
        // print(courses);
        if (courses.hasData) {
          return Text(courses.data.first.toString(),
              style: TextStyle(
                  color: ArgonColors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold));
        } else if (courses.hasError) {
          return Text("${courses.error}");
        }
        // By default, show a loading spinner.
        return CircularProgressIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // print(this.futureListCourse);

    /**
   * fetchCourse ritorna un Future<List<Course>>
   * print(fetchCourse); -> non va bene perché torna un oggetto non strutturato per l'async
   * Soluzione:
   * fetchCourse().then((courses) => print(courses));
   * con il .then si specifica che si vuole ricevero dalla funzione fetchCourse il ritorno (return)
   * il return è una Lista semplice -> si può stampare
   * [id: 1, name: Analisi Matematica, cfu: 9 , id: 1,
   *  name: Analisi Matematica, cfu: 9, id: 2, name: Architettura degli Elaboratori, cfu: 9]
   */
    // fetchCourse().then((courses) => {print(courses)});

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: Navbar(
          title: "Test",
          transparent: true,
        ),
        backgroundColor: ArgonColors.bgColorScreen,
        drawer: ArgonDrawer(currentPage: "Testhttp"),
        body: Stack(children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      alignment: Alignment.topCenter,
                      image: AssetImage("assets/img/profile-screen-bg.png"),
                      fit: BoxFit.fitWidth))),
          SafeArea(
            child: ListView(children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 74.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Stack(children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            elevation: .0,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0))),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 85.0, bottom: 20.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            /*Container(
                                              decoration: BoxDecoration(
                                                color: ArgonColors.info,
                                                borderRadius:
                                                    BorderRadius.circular(3.0),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.3),
                                                    spreadRadius: 1,
                                                    blurRadius: 7,
                                                    offset: Offset(0,
                                                        3), // changes position of shadow
                                                  ),
                                                ],
                                              ),
                                              child: Text(
                                                "CONNECT",
                                                style: TextStyle(
                                                    color: ArgonColors.white,
                                                    fontSize: 12.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.0,
                                                  vertical: 8.0),
                                            ),
                                            SizedBox(
                                              width: 30.0,
                                            ),*/
                                            /* Container(
                                              decoration: BoxDecoration(
                                                color: ArgonColors.initial,
                                                borderRadius:
                                                    BorderRadius.circular(3.0),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.3),
                                                    spreadRadius: 1,
                                                    blurRadius: 7,
                                                    offset: Offset(0,
                                                        3), // changes position of shadow
                                                  ),
                                                ],
                                              ),
                                              child: Text(
                                                "MESSAGE",
                                                style: TextStyle(
                                                    color: ArgonColors.white,
                                                    fontSize: 12.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.0,
                                                  vertical: 8.0),
                                            ),*/
                                            /*SizedBox(
                                              width: 30.0,
                                            ),*/
                                            Container(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Column(
                                                  // As you expect multiple lines you need a column not a row
                                                  // children: getListWidgetData(),
                                                  ),
                                            ),
                                            Expanded(
                                              /*padding: EdgeInsets.symmetric(
                                                  horizontal: 8.0,
                                                  vertical: 8.0),*/
                                              child: getData(),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 40.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              children: [
                                                /*Text("2K",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            82, 95, 127, 1),
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text("Orders",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            50, 50, 93, 1),
                                                        fontSize: 12.0))*/
                                              ],
                                            ),
                                            Column(
                                                /*children: [
                                                Text("10",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            82, 95, 127, 1),
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text("Photos",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            50, 50, 93, 1),
                                                        fontSize: 12.0))
                                              ],*/
                                                ),
                                            Column(
                                              children: [
                                                /*Text("89",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            82, 95, 127, 1),
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text("Comments",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            50, 50, 93, 1),
                                                        fontSize: 12.0))*/
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 40.0),
                                        /*Align(
                                          child: Text("Jessica Jones, 27",
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      50, 50, 93, 1),
                                                  fontSize: 28.0)),
                                        ),*/
                                        /*SizedBox(height: 10.0),
                                        Align(
                                          child: Text("San Francisco, USA",
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      50, 50, 93, 1),
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w200)),
                                        ),*/
                                        /*Divider(
                                          height: 40.0,
                                          thickness: 1.5,
                                          indent: 32.0,
                                          endIndent: 32.0,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 32.0, right: 32.0),
                                          child: Align(
                                            child: Text(
                                                "An artist of considerable range, Jessica name taken by Melbourne...",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        82, 95, 127, 1),
                                                    fontSize: 17.0,
                                                    fontWeight:
                                                        FontWeight.w200)),
                                          ),
                                        ),*/
                                        /*SizedBox(height: 15.0),
                                        Align(
                                            child: Text("Show more",
                                                style: TextStyle(
                                                    color: ArgonColors.primary,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16.0))),*/
                                        /*SizedBox(height: 25.0),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 25.0, left: 25.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Album",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16.0,
                                                    color: ArgonColors.text),
                                              ),
                                              Text(
                                                "View All",
                                                style: TextStyle(
                                                    color: ArgonColors.primary,
                                                    fontSize: 13.0,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),*/
                                        /*SizedBox(
                                          height: 250,
                                          child: GridView.count(
                                              primary: false,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 24.0,
                                                  vertical: 15.0),
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10,
                                              crossAxisCount: 3,
                                              children: <Widget>[
                                                Container(
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  6.0)),
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              "https://images.unsplash.com/photo-1501601983405-7c7cabaa1581?fit=crop&w=240&q=80"),
                                                          fit: BoxFit.cover),
                                                    )),
                                                Container(
                                                    decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(6.0)),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          "https://images.unsplash.com/photo-1543747579-795b9c2c3ada?fit=crop&w=240&q=80hoto-1501601983405-7c7cabaa1581?fit=crop&w=240&q=80"),
                                                      fit: BoxFit.cover),
                                                )),
                                                Container(
                                                    decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(6.0)),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          "https://images.unsplash.com/photo-1551798507-629020c81463?fit=crop&w=240&q=80"),
                                                      fit: BoxFit.cover),
                                                )),
                                                Container(
                                                    decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(6.0)),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          "https://images.unsplash.com/photo-1470225620780-dba8ba36b745?fit=crop&w=240&q=80"),
                                                      fit: BoxFit.cover),
                                                )),
                                                Container(
                                                    decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(6.0)),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          "https://images.unsplash.com/photo-1503642551022-c011aafb3c88?fit=crop&w=240&q=80"),
                                                      fit: BoxFit.cover),
                                                )),
                                                Container(
                                                    decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(6.0)),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          "https://images.unsplash.com/photo-1482686115713-0fbcaced6e28?fit=crop&w=240&q=80"),
                                                      fit: BoxFit.cover),
                                                )),
                                              ]),
                                        )*/
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                      FractionalTranslation(
                          translation: Offset(0.0, -0.5),
                          child: Align(
                            /*child: CircleAvatar(
                              backgroundImage: AssetImage(
                                  "assets/img/profile-screen-avatar.jpg"),
                              radius: 65.0,
                              // maxRadius: 200.0,
                            ),*/
                            alignment: FractionalOffset(0.5, 0.0),
                          ))
                    ]),
                  ],
                ),
              ),
            ]),
          )
        ]));
  }
}
