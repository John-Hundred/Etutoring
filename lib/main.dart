import 'package:e_tutoring/provider/locale_provider.dart';
import 'package:e_tutoring/screens/login.dart';
import 'package:e_tutoring/screens/profile.dart';
import 'package:e_tutoring/utils/user_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'l10n/l10n.dart';

Future main() async {
  /*WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);*/

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'E-Tutoring';

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => LocaleProvider(),
        builder: (context, child) {
          final provider = Provider.of<LocaleProvider>(context);

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: title,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.deepPurple.shade100,
              primaryColor: Colors.deepPurpleAccent,
            ),
            locale: provider.locale,
            supportedLocales: L10n.all,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            home: MainPage(),
          );
        },
      );
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Widget _body = CircularProgressIndicator();
  @override
  void initState() {
    super.initState();
    UserSecureStorage.getEmail().then((value) => (setState(() {
          // print(value);
          if (value != null)
            _body = Profile();
          else {
            _body = Login();
            /*MaterialApp(
              title: 'E-Tutoring',
              theme: ThemeData(fontFamily: 'OpenSans'),
              initialRoute: "/login",
              debugShowCheckedModeBanner: false,
              routes: <String, WidgetBuilder>{
                "/login": (BuildContext context) => new Login(),
              },
              locale: _provider.locale,
              supportedLocales: L10n.all,
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
            );*/
          }
        })));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: _body,
      );

  /*@override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => LocaleProvider(),
      builder: (context, child) {
        // _provider = Provider.of<LocaleProvider>(context);
        return _body;
      });*/
  /*Widget build(BuildContext context) {
    return _body;
  }*/
}
