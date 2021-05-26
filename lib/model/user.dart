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
    id = json['id'];
    username = json['username'];
    email = json['email'];
    badge_number = json['badge_number'];
    cf = json['cf'];
    birth_date = json['birth_date'];
    birth_city = json['birth_city'];
  }

  toString() {
    return "id = " +
        this.id +
        "\nusername = " +
        this.username +
        "\nemail =" +
        this.email +
        "\nbadge number = " +
        this.badge_number;
  }
}
