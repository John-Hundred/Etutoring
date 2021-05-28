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
  // ignore: non_constant_identifier_names
  String degree_name;
  // ignore: non_constant_identifier_names
  String degree_location;
  // ignore: non_constant_identifier_names
  String degree_athenaeum;
  // ignore: non_constant_identifier_names
  String degree_path_name;
  // ignore: non_constant_identifier_names
  String phone_number;

  String nationality;

  // ignore: non_constant_identifier_names
  String residence_city;

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
      this.role_name,
      this.degree_name,
      this.degree_location,
      this.degree_athenaeum,
      this.degree_path_name,
      this.phone_number,
      this.nationality,
      this.residence_city);

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
    degree_name = json['degree_name'] ?? '';
    degree_location = json['degree_location'] ?? '';
    degree_athenaeum = json['degree_athenaeum'] ?? '';
    degree_path_name = json['degree_path_name'] ?? '';
    phone_number = json['phone_number'] ?? '';
    nationality = json['nationality'] ?? '';
    residence_city = json['residence_city'] ?? '';
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
