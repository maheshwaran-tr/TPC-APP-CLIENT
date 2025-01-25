import 'application_model.dart';
import 'company_model.dart';

class Drive {
  final int driveId;
  final int companyId;
  final String jobRole;
  final String? location;
  final String? description;
  final String? salary;
  final String? trainingPeriod;
  final String? trainingStipend;
  final DateTime? driveDate;
  final String? driveTime;
  final String? jobType;
  final List<String>? requiredSkills;
  final String? campusMode;
  final int? eligible10thMark;
  final int? eligible12thMark;
  final int? eligibleHistoryOfArrears;
  final int? eligibleCurrentArrears;
  final double? eligibleCgpa;
  final int? numberOfRounds;
  final String? venue;
  final DateTime createdAt;
  final Company? company;
  final List<Application>? applications;

  Drive({
    required this.driveId,
    required this.companyId,
    required this.jobRole,
    this.location,
    this.description,
    this.salary,
    this.trainingPeriod,
    this.trainingStipend,
    this.driveDate,
    this.driveTime,
    this.campusMode,
    this.jobType,
    this.venue,
    this.numberOfRounds,
    this.requiredSkills,
    this.eligible10thMark,
    this.eligible12thMark,
    this.eligibleCgpa,
    this.eligibleHistoryOfArrears,
    this.eligibleCurrentArrears,
    required this.createdAt,
    required this.company,
    required this.applications,
  });

  factory Drive.fromJson(Map<String, dynamic> json) {
    return Drive(
      driveId: json['drive_id'],
      companyId: json['company_id'],
      jobRole: json['job_role'],
      location: json['location'],
      description: json['description'],
      salary: json['salary'],
      trainingPeriod: json['training_period'],
      trainingStipend: json['training_stipend'],
      driveDate: json['drive_date'] != null
          ? DateTime.parse(json['drive_date'])
          : null,
      driveTime: json['drive_time'],
      venue: json['venue'],
      jobType: json['job_type'],
      requiredSkills: json['required_skills'] != null
          ? List<String>.from(json['required_skills'])
          : [],
      eligible10thMark: json['eligible_10th_mark'],
      eligible12thMark: json['eligible_12th_mark'],
      eligibleCgpa: json['eligible_cgpa']?.toDouble(),
      eligibleCurrentArrears: json['eligible_current_arrears'],
      eligibleHistoryOfArrears: json['eligible_history_of_arrears'],
      numberOfRounds: json['number_of_rounds'],
      createdAt: DateTime.parse(json['created_at']),
      company:
          json['company'] != null ? Company.fromJson(json['company']) : null,
      applications: json['applications'] != null
          ? List<Application>.from(
              json['applications'].map((x) => Application.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'drive_id': driveId,
      'company_id': companyId,
      'job_role': jobRole,
      'location': location,
      'description': description,
      'salary': salary,
      'training_period': trainingPeriod,
      'training_stipend': trainingStipend,
      'drive_date': driveDate?.toIso8601String(),
      'drive_time': driveTime,
      'venue': venue,
      'job_type': jobType,
      'required_skills': requiredSkills,
      'eligible_10th_mark': eligible10thMark,
      'eligible_12th_mark': eligible12thMark,
      'eligible_current_arrears':eligibleCurrentArrears,
      'eligible_history_of_arrears':eligibleHistoryOfArrears,
      'number_of_rounds': numberOfRounds,
      'eligible_cgpa': eligibleCgpa,
      'created_at': createdAt.toIso8601String(),
      'company': company?.toJson(),
      'applications': applications != null
          ? List<dynamic>.from(applications!.map((x) => x.toJson()))
          : null,
    };
  }
}
