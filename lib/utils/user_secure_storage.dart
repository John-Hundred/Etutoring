import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static final _storage = FlutterSecureStorage();

  static const _keyEmail = 'email';
  /*static const _keyPets = 'pets';
  static const _keyBirthday = 'birthday';*/
  static const _keyPassword = 'password';

  static Future setEmail(String email) async =>
      await _storage.write(key: _keyEmail, value: email);

  static Future<String> getEmail() async => await _storage.read(key: _keyEmail);

  static Future setPassword(String password) async =>
      await _storage.write(key: _keyPassword, value: password);

  static Future<String> getPassword() async =>
      await _storage.read(key: _keyPassword);

  /*static Future setPets(List<String> pets) async {
    final value = json.encode(pets);

    await _storage.write(key: _keyPets, value: value);
  }

  static Future<List<String>> getPets() async {
    final value = await _storage.read(key: _keyPets);

    return value == null ? null : List<String>.from(json.decode(value));
  }

  static Future setBirthday(DateTime dateOfBirth) async {
    final birthday = dateOfBirth.toIso8601String();

    await _storage.write(key: _keyBirthday, value: birthday);
  }

  static Future<DateTime> getBirthday() async {
    final birthday = await _storage.read(key: _keyBirthday);

    return birthday == null ? null : DateTime.tryParse(birthday);
  }*/
}
