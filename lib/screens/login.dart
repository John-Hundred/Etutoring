import 'package:argon_flutter/screens/profileUser.dart';
import 'package:argon_flutter/widgets/input.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginUser extends StatefulWidget {
  LoginUserState createState() => LoginUserState();
}

class LoginUserState extends State {
  // bool _checkboxValue = false;
  // For CircularProgressIndicator.
  bool visible = false;

  // Getting value from TextField widget.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future userLogin() async {
    // Showing CircularProgressIndicator.
    setState(() {
      visible = true;
    });

    // Getting value from Controller
    String email = emailController.text;
    String password = passwordController.text;

    // SERVER LOGIN API URL
    var url = 'e-tutoring-web/ws/ws/user_login.php';

    // Store all data with Param Name.
    var data = {'email': email, 'password': password};

    // Starting Web API Call.
    var response =
        await http.post(Uri.http("192.168.56.1", url), body: json.encode(data));

    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    // If the Response Message is Matched.
    if (message == 'Login Matched') {
      // Hiding the CircularProgressIndicator.
      setState(() {
        visible = false;
      });

      // Navigate to Profile Screen & Sending Email to Next Screen.
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ProfileScreen(email: emailController.text)));
    } else {
      // If Email or Password did not Matched.
      // Hiding the CircularProgressIndicator.
      setState(() {
        visible = false;
      });

      // Showing Alert Dialog with Response JSON Message.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(message),
            actions: <Widget>[
              TextButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        /*appBar: AppBar(
          title: Text('E-Tutoring Login'),
        ),*/
        //drawer: ArgonDrawer(currentPage: "Login"),
        body: Stack(children: [
      Container(
        decoration: BoxDecoration(
            // background img
            image: DecorationImage(
                image: AssetImage("assets/img/register-bg.png"),
                fit: BoxFit.cover)),
      ),
      SafeArea(
          child: ListView(children: [
        Padding(
          padding: const EdgeInsets.only(
              top: 32, left: 24.0, right: 24.0, bottom: 32),
          child: Card(
              // elevation: 5,
              //clipBehavior: Clip.antiAlias,
              /*shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),*/
              child: Column(children: [
            SingleChildScrollView(

                /*height: MediaQuery.of(context).size.height * 0.15,
                        decoration: BoxDecoration(
                            color: ArgonColors.white,
                            border: Border(
                                bottom: BorderSide(
                                    width: 0.5, color: ArgonColors.muted))),*/
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text('Login',
                                  style: TextStyle(fontSize: 21)))),
                      // Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Input(
                            placeholder: "Email",
                            controller: emailController,
                            prefixIcon: Icon(Icons.email)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Input(
                            placeholder: "Password",
                            controller: passwordController,
                            // autocorrect: true,
                            // obscureText: true,
                            prefixIcon: Icon(Icons.lock)),
                      ),
                      /*Padding(
                                padding: const EdgeInsets.only(left: 24.0),
                                child: RichText(
                                    text: TextSpan(
                                        text: "password strength: ",
                                        style:
                                            TextStyle(color: ArgonColors.muted),
                                        children: [
                                      TextSpan(
                                          text: "strong",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: ArgonColors.success))
                                    ])),
                              ),*/
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, top: 0, bottom: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            /*Checkbox(
                                        activeColor: ArgonColors.primary,
                                        onChanged: (bool newValue) => setState(
                                            () => _checkboxValue = newValue),
                                        value: _checkboxValue),*/
                            /*Text("I agree with the",
                                        style: TextStyle(
                                            color: ArgonColors.muted,
                                            fontWeight: FontWeight.w200)),*/
                            /*GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(context, '/pro');
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(left: 5),
                                          child: Text("Privacy Policy",
                                              style: TextStyle(
                                                  color: ArgonColors.primary)),
                                        )),*/
                          ],
                        ),
                      ),
                      /*Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Center(
                          child: TextButton(
                            /*textColor: ArgonColors.white,
                                            color: ArgonColors.primary,*/
                            onPressed: userLogin,
                            /*shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                            ),*/

                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 16.0,
                                    right: 16.0,
                                    top: 0,
                                    bottom: 12),
                                child: Text("Click Here To Login",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.0))),
                          ),
                        ),
                      ),*/
                      Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Center(
                              child: ElevatedButton(
                            // textColor: ArgonColors.text,
                            // color: ArgonColors.secondary,
                            onPressed: userLogin,
                            /*shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),*/
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 16.0,
                                    right: 16.0,
                                    top: 12,
                                    bottom: 12),
                                child: Text("Login",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.0))),
                          ))),
                      Visibility(
                        visible: visible,
                        child: Center(
                            child: Container(
                                margin: EdgeInsets.only(bottom: 30),
                                child: CircularProgressIndicator())),
                      )
                    ],
                  ),
                ])),
          ])),
        )
      ]))
    ]));
    /*SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text('Login', style: TextStyle(fontSize: 21))),
                Divider(),
                Container(
                    width: 280,
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                      controller: emailController,
                      autocorrect: true,
                      decoration:
                          InputDecoration(hintText: 'Enter Your Email Here'),
                    )),
                Container(
                    width: 280,
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                      controller: passwordController,
                      autocorrect: true,
                      obscureText: true,
                      decoration:
                          InputDecoration(hintText: 'Enter Your Password Here'),
                    )),
                ElevatedButton(
                  onPressed: userLogin,
                  /*color: Colors.green,
                textColor: Colors.white,
                padding: EdgeInsets.fromLTRB(9, 9, 9, 9),*/
                  child: Text('Click Here To Login'),
                ),
                Visibility(
                    visible: visible,
                    child: Container(
                        margin: EdgeInsets.only(bottom: 30),
                        child: CircularProgressIndicator())),
              ],
            ),
          ),
        ));*/
  }
}
