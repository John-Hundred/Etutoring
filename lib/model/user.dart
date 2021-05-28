class User {
  String id;
  String firstname;
  String lastname;
  String username;
  String email;
  // ignore: non_constant_identifier_names
  String badge_number;
  String cf;
  // ignore: non_constant_identifier_names
  String birth_date;
  // ignore: non_constant_identifier_names
  String birth_city;
  // ignore: non_constant_identifier_names
  String role_name;

  User(
      this.id,
      this.firstname,
      this.lastname,
      this.username,
      this.email,
      this.badge_number,
      this.cf,
      this.birth_date,
      this.birth_city,
      this.role_name);

  User.fromJson(dynamic json) {
    id = json['id'] ?? '';
    firstname = json['firstname'] ?? '';
    lastname = json['lastname'] ?? '';
    username = json['username'] ?? '';
    email = json['email'] ?? '';
    badge_number = json['badge_number'] ?? '';
    cf = json['cf'] ?? '';
    birth_date = json['birth_date'] ?? '';
    birth_city = json['birth_city'] ?? '';
    role_name = json['role_name'] ?? '';
  }

  toString() {
    return "id = " +
        this.id +
        "\nfirstname = " +
        this.firstname +
        "\nfirstname = " +
        this.lastname +
        "\nusername = " +
        this.username +
        "\nemail =" +
        this.email +
        "\nbadge number = " +
        this.badge_number +
        "\nbirth date = " +
        this.birth_date +
        "\nbirth city = " +
        this.birth_city +
        "\nrole_name = " +
        this.role_name;
  }
}
