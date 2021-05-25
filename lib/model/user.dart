class User {
  String id;
  String username;
  String email;
  // ignore: non_constant_identifier_names
  String badge_number;
  String cf;
  // ignore: non_constant_identifier_names
  String birth_date;
  // ignore: non_constant_identifier_names
  String birth_city;

  User(this.id, this.username, this.email, this.badge_number, this.cf,
      this.birth_date, this.birth_city);

  User.fromJson(dynamic json) {
    for (var element in json) {
      id = element['id'];
      username = element['username'];
      email = element['email'];
      badge_number = element['badge_number'];
      cf = element['cf'];
      birth_date = element['birth_date'];
      birth_city = element['birth_city'];
    }
  }

  toString() {
    return "username = " + this.username;
  }
}
