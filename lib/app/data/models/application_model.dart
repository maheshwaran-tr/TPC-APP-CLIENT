import 'drive_model.dart';
import 'status_model.dart';
import 'student_model.dart';

class Application {
  final int? applicationId;
  final int studentId;
  final int driveId;
  final int statusId;
  final DateTime? createdAt;
  final Student? student;
  Drive? drive;
  final Status? status;

  Application({
    this.applicationId,
    required this.studentId,
    required this.driveId,
    required this.statusId,
    this.createdAt,
    this.student,
    this.drive,
    this.status,
  });

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      applicationId: json['application_id'],
      studentId: json['student_id'],
      driveId: json['drive_id'],
      statusId: json['status_id'],
      createdAt: DateTime.parse(json['created_at']),
      student: json['student'] != null ? Student.fromJson(json['student']):null,
      drive: json['drive'] != null ? Drive.fromJson(json['drive']):null,
      status: json['status'] != null ? Status.fromJson(json['status']):null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'application_id': applicationId,
      'student_id': studentId,
      'drive_id': driveId,
      'status_id': statusId,
      'created_at': createdAt?.toIso8601String(),
      'student': student?.toJson(),
      'drive': drive?.toJson(),
      'status': status?.toJson(),
    };
  }
}
