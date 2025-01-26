import 'package:intl/intl.dart';

import 'application_model.dart';
import 'company_model.dart';

class Drive {
  int? driveId;
  int companyId;
  String jobRole;
  String? location;
  String? description;
  String? salary;
  DateTime? driveDate;
  int? eligible10thMark;
  int? eligible12thMark;
  double? eligibleCgpa;
  int? eligibleCurrentArrears;
  int? eligibleHistoryOfArrears;
  String? jobType;
  List<String> requiredSkills;
  String? venue;
  int numberOfRounds;
  int? batch;
  DateTime? deadLine;
  List<String> departments;
  String? campusMode;
  String? jobLink;
  DateTime? createdAt;
  final Company? company;
  final List<Application>? applications;
  
  // Constructor
  Drive({
    this.driveId,
    required this.companyId,
    required this.jobRole,
    this.location,
    this.description,
    this.salary,
    this.driveDate,
    this.eligible10thMark,
    this.eligible12thMark,
    this.eligibleCgpa,
    this.eligibleCurrentArrears,
    this.eligibleHistoryOfArrears,
    this.jobType,
    required this.requiredSkills,
    this.venue,
    required this.numberOfRounds,
    this.batch,
    this.deadLine,
    required this.departments,
    this.campusMode,
    this.jobLink,
    this.createdAt,
    this.applications,
    this.company
  });

  // Factory method to create a Drive object from JSON
  factory Drive.fromJson(Map<String, dynamic> json) {
    return Drive(
      driveId: json['drive_id'],
      companyId: json['company_id'],
      jobRole: json['job_role'],
      location: json['location'],
      description: json['description'],
      salary: json['salary'],
      driveDate: json['drive_date'] != null ? DateTime.parse(json['drive_date']) : null,
      eligible10thMark: json['eligible_10th_mark'],
      eligible12thMark: json['eligible_12th_mark'],
      eligibleCgpa: json['eligible_cgpa'] != null ? json['eligible_cgpa'].toDouble() : null,
      eligibleCurrentArrears: json['eligible_current_arrears'],
      eligibleHistoryOfArrears: json['eligible_history_of_arrears'],
      jobType: json['job_type'],
      requiredSkills: List<String>.from(json['required_skills']),
      venue: json['venue'],
      numberOfRounds: json['number_of_rounds'],
      batch: json['batch'],
      deadLine: json['deadLine'] != null ? DateTime.parse(json['deadLine']) : null,
      departments: List<String>.from(json['departments']),
      campusMode: json['campusMode'],
      jobLink: json['jobLink'],
      createdAt: DateTime.parse(json['created_at']),
      company:
      json['company'] != null ? Company.fromJson(json['company']) : null,
      applications: json['applications'] != null
          ? List<Application>.from(
          json['applications'].map((x) => Application.fromJson(x)))
          : null,
    );
  }

  // Method to convert a Drive object to JSON
  Map<String, dynamic> toJson() {
    final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
    return {
      'company_id': companyId,
      'job_role': jobRole,
      'location': location,
      'description': description,
      'salary': salary,
      'drive_date': driveDate?.toUtc().toIso8601String(),
      'eligible_10th_mark': eligible10thMark,
      'eligible_12th_mark': eligible12thMark,
      'eligible_cgpa': eligibleCgpa,
      'eligible_current_arrears': eligibleCurrentArrears,
      'eligible_history_of_arrears': eligibleHistoryOfArrears,
      'job_type': jobType,
      'required_skills': requiredSkills,
      'venue': venue,
      'number_of_rounds': numberOfRounds,
      'batch': batch,
      'deadLine': deadLine?.toUtc().toIso8601String(),
      'departments': departments,
      'campusMode': campusMode,
      'jobLink': jobLink,
    };
  }
}
