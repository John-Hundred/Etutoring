import 'dart:async';
import 'dart:convert';

import 'package:argon_flutter/widgets/drawer.dart';
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Mycourse extends StatefulWidget {
  @override
  MycourseState createState() => new MycourseState();
}

class MycourseState extends State<Mycourse> {
  List data;

  Future<String> getData() async {
    var response =
        await http.get(Uri.https("jsonplaceholder.typicode.com", "posts"));

    this.setState(() {
      data = jsonDecode(response.body);
    });

    // sprint(data[1]["title"]);

    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new Navbar(title: "Course"),
      drawer: ArgonDrawer(currentPage: "course"),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return new Card(
            child: new Text(data[index]["title"]),
          );
        },
      ),
    );
  }
}
