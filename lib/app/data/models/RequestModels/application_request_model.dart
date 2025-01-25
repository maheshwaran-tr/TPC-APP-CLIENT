class ApplicationRequest {
  String studentId;
  String driveId;

  ApplicationRequest({
    required this.studentId,
    required this.driveId,
  });

  factory ApplicationRequest.fromJson(Map<String, dynamic> json) =>
      ApplicationRequest(
        studentId: json["student_Id"],
        driveId: json["drive_id"],
      );

  Map<String, dynamic> toJson() => {
        "student_id": studentId,
        "drive_id": driveId,
      };
}