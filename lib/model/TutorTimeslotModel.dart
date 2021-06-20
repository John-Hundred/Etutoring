class TutorTimeslotModel {
  // ignore: non_constant_identifier_names
  String tutor_time_slot_id;
  String day;
  // ignore: non_constant_identifier_names
  String hour_from;
  // ignore: non_constant_identifier_names
  String hour_to;
  // ignore: non_constant_identifier_names
  String user_id;

  bool selected = false;

  TutorTimeslotModel(this.tutor_time_slot_id, this.day, this.hour_from,
      this.hour_to, this.user_id);

  TutorTimeslotModel.fromJson(dynamic json) {
    tutor_time_slot_id = json['tutor_time_slot_id'] ?? '';
    day = json['day'] ?? '-';
    hour_from = json['hour_from'] ?? '-';
    hour_to = json['hour_to'] ?? '-';
    user_id = json['user_id'] ?? '-';
  }

  toString() {
    return this.day + ", " + this.hour_from + ", " + this.hour_to;
  }
}
