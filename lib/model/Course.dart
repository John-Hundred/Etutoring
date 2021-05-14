class Course {
  final String courseId;
  final String courseName;
  final String courseCfu;

  Course({this.courseId, this.courseName, this.courseCfu});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      courseId: json['course_id'],
      courseName: json['couse_name'],
      courseCfu: json['course_cfu'],
    );
  }
}
