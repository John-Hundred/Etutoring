import 'package:argon_flutter/widgets/button_widget.dart';
import 'package:argon_flutter/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:argon_flutter/utils/user_secure_storage.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final formKey = GlobalKey<FormState>();
  final controllerName = TextEditingController();
  final controllerNamePwd = TextEditingController();
  /*DateTime birthday;
  List<String> pets = [];*/

  @override
  void initState() {
    super.initState();
    // init();
  }

  Future init() async {
    final name = await UserSecureStorage.getUsername() ?? '';
    final password = await UserSecureStorage.getPassword() ?? '';
    /*final birthday = await UserSecureStorage.getBirthday() ?? '';
    final pets = await UserSecureStorage.getPets() ?? [];*/

    this.controllerName.text = name;
    this.controllerNamePwd.text = password;
    /*this.birthday = birthday;
    this.pets = pets;*/
    /*setState(() {
      this.controllerName.text = name;
      this.controllerNamePwd.text = password;
      this.birthday = birthday;
      this.pets = pets;
    });*/
  }

  @override
  Widget build(BuildContext context) {
    this.setState(() {
      init();
    });
    return Scaffold(
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TitleWidget(icon: Icons.lock, text: 'Welcome to\nE-tutoring'),
            const SizedBox(height: 32),
            buildName(),
            const SizedBox(height: 12),
            buildPassword(),
            const SizedBox(height: 12),
            /*buildBirthday(),
            const SizedBox(height: 12),
            buildPets(),
            const SizedBox(height: 32),*/
            buildButton(),
          ],
        ),
      ),
    );
  }

  Widget buildName() => buildTitle(
        title: 'Name',
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your name';
            }
            return null;
          },
          controller: controllerName,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Your Name',
          ),
        ),
      );

  Widget buildPassword() => buildTitle(
        title: 'Password',
        child: TextFormField(
          obscureText: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            return null;
          },
          controller: controllerNamePwd,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Your Password',
          ),
        ),
      );

  /*Widget buildBirthday() => buildTitle(
        title: 'Birthday',
        child: BirthdayWidget(
          birthday: birthday,
          onChangedBirthday: (birthday) =>
              setState(() => this.birthday = birthday),
        ),
      );

  Widget buildPets() => buildTitle(
        title: 'Pets',
        child: PetsButtonsWidget(
          pets: pets,
          onSelectedPet: (pet) => setState(
              () => pets.contains(pet) ? pets.remove(pet) : pets.add(pet)),
        ),
      );*/

  Widget buildButton() => ButtonWidget(
      text: 'Save',
      onClicked: () async {
        if (formKey.currentState.validate()) {
          // If the form is valid, display a snackbar. In the real world,
          // you'd often call a server or save the information in a database.
          print('save');
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Login and Save Data')));
        }
        await UserSecureStorage.setUsername(controllerName.text);
        await UserSecureStorage.setPassword(controllerNamePwd.text);
        /*await UserSecureStorage.setPets(pets);

        if (birthday != null) {
          await UserSecureStorage.setBirthday(birthday);
        }*/
      });

  Widget buildTitle({
    String title,
    Widget child,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          child,
        ],
      );
}
