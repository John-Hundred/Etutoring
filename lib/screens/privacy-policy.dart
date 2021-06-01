import 'package:argon_flutter/constants/Theme.dart';
import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({
    Key key,
    this.color = const Color(0xFF2DBD3A),
    this.child,
  }) : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Privacy Policy'),
            backgroundColor: Color.fromRGBO(213, 21, 36, 1)),
        extendBodyBehindAppBar: true,
        body: Stack(children: <Widget>[
          SafeArea(
              child: ListView(children: [
            Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Stack(children: <Widget>[
                        Container(
                            child: Card(
                                // color: Color.fromRGBO(205, 205, 205, 1),
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 0.0, bottom: 20.0),
                                    child: Row(children: [
                                      Expanded(
                                          child: Column(children: [
                                        Text("Modalità di trattamento dei dati",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20)),
                                        ListTile(
                                            title: new Text(
                                              "Il Titolare adotta le opportune misure di sicurezza volte ad impedire l’accesso, la divulgazione, la modifica o la distruzione non autorizzate dei Dati Personali;",
                                            ),
                                            leading: Container(
                                                height: 8.0,
                                                width: 8.0,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  shape: BoxShape.circle,
                                                ))),
                                        ListTile(
                                            title: new Text(
                                              "il trattamento viene effettuato mediante strumenti informatici e/o telematici, con modalità organizzative e con logiche strettamente correlate alle finalità indicate;",
                                            ),
                                            leading: Container(
                                                height: 8.0,
                                                width: 8.0,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  shape: BoxShape.circle,
                                                ))),
                                        ListTile(
                                            title: new Text(
                                                "oltre al Titolare, in alcuni casi, potrebbero avere accesso ai Dati altri soggetti coinvolti nell’organizzazione di questa Applicazione (personale amministrativo, commerciale, marketing, legali, amministratori di sistema) ovvero soggetti esterni nominati anche, se necessario, Responsabili del Trattamento da parte del Titolare;"),
                                            leading: Container(
                                                height: 8.0,
                                                width: 8.0,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  shape: BoxShape.circle,
                                                ))),
                                        Divider(
                                            height: 4,
                                            thickness: 0,
                                            color: ArgonColors.muted),
                                      ]))
                                    ]))))
                      ])
                    ]))
          ]))
        ]));
  }
}
