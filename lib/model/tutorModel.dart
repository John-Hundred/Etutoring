class TutorModel {
  dynamic id;
  String firstname;
  String lastname;
  String username;
  String email;
  String description;
  String img;
  String cf;
  // ignore: non_constant_identifier_names
  String birth_date;
  // ignore: non_constant_identifier_names
  String birth_city;
  // ignore: non_constant_identifier_names
  String role_name;
  // ignore: non_constant_identifier_names
  String phone_number;

  String nationality;

  String address;
  // ignore: non_constant_identifier_names
  String residence_city;

  // ignore: non_constant_identifier_names
  dynamic time_slot;

  dynamic courses;

  TutorModel(
      this.id,
      this.firstname,
      this.lastname,
      this.username,
      this.email,
      this.description,
      this.img,
      this.cf,
      this.birth_date,
      this.birth_city,
      this.role_name,
      this.phone_number,
      this.nationality,
      this.address,
      this.residence_city,
      this.time_slot,
      this.courses);

  TutorModel.fromJson(dynamic json) {
    id = json['id'] ?? '';
    firstname = json['firstname'] ?? '-';
    lastname = json['lastname'] ?? '-';
    username = json['username'] ?? '-';
    email = json['email'] ?? '-';
    description = json['description'] ?? '-';
    img = json['img'] ?? '-';
    cf = json['cf'] ?? '';
    birth_date = json['birth_date'] ?? '-';
    birth_city = json['birth_city'] ?? '-';
    role_name = json['role_name'] ?? '-';
    phone_number = json['phone_number'] ?? '-';
    nationality = json['nationality'] ?? '-';
    address = json['address'] ?? '-';
    residence_city = json['residence_city'] ?? '-';
    time_slot = json['time_slot'] ?? '-';
    courses = json['courses'] ?? '-';
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
        "\nbirth date = " +
        this.birth_date +
        "\nbirth city = " +
        this.birth_city +
        "\nrole_name = " +
        this.role_name;
  }
}
