import 'package:e_tutoring/screens/login.dart';
import 'package:e_tutoring/screens/profile.dart';
import 'package:e_tutoring/utils/user_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'l10n/l10n.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget _body = CircularProgressIndicator();

  @override
  void initState() {
    super.initState();
    UserSecureStorage.getEmail().then((value) => (setState(() {
          // print(value);
          if (value != null)
            _body = Profile();
          else
            _body = MaterialApp(
              title: 'E-Tutoring',
              theme: ThemeData(fontFamily: 'OpenSans'),
              initialRoute: "/login",
              debugShowCheckedModeBanner: false,
              routes: <String, WidgetBuilder>{
                "/login": (BuildContext context) => new Login(),
                // "/register": (BuildContext context) => new Signin(),
              },
              // locale: provider.locale,
              supportedLocales: L10n.all,
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
            );
        })));
  }

  @override
  Widget build(BuildContext context) {
    return _body;
  }
}
