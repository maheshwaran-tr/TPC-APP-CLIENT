class DriveRequest {
  final int companyId;
  final String jobRole;
  final String? location;
  final String? description;
  final String? salary;
  final DateTime? driveDate;
  final String? driveTime;
  final int? eligible10thMark;
  final int? eligible12thMark;
  final double? eligibleCgpa;
  final int? eligibleHistoryOfArrears;
  final int? eligibleCurrentArrears;
  final String? jobType;
  final String? venue;
  final List<String> requiredSkills;
  final int numberOfRounds;
  final DateTime deadLine;
  final List<String> departments;
  final String campusMode;
  final int batch;
  final String? jobLink;
  DriveRequest( {
    required this.companyId,
    required this.jobRole,
    this.location,
    required this.batch,
    this.description,
    this.salary,
    this.driveDate,
    this.driveTime,
    this.eligible10thMark,
    this.eligible12thMark,
    this.eligibleCgpa,
    this.eligibleHistoryOfArrears,
    this.eligibleCurrentArrears,
    this.jobType,
    required this.campusMode,
    this.venue,
    required this.departments,
    required this.deadLine,
    required this.requiredSkills,
    required this.numberOfRounds,
    this.jobLink,
  });

  // Factory method to create an instance from a map (used for API response parsing)
  factory DriveRequest.fromMap(Map<String, dynamic> map) {
    return DriveRequest(
      companyId: map['company_id'],
      jobRole: map['job_role'],
      location: map['location'],
      description: map['description'],
      salary: map['salary'],
      departments: map['departments'],
      driveDate:
          map['drive_date'] != null ? DateTime.parse(map['drive_date']) : null,
      driveTime: map['drive_time'],
      eligible10thMark: map['eligible_10th_mark'],
      eligible12thMark: map['eligible_12th_mark'],
      deadLine: map["deadLine"],
      eligibleCgpa: map['eligible_cgpa']?.toDouble(),
      eligibleHistoryOfArrears: map['eligible_history_of_arrears'],
      eligibleCurrentArrears: map['eligible_current_arrears'],
      jobType: map['job_type'],
      venue: map['venue'],
      campusMode: map['campusMode'],
      requiredSkills: List<String>.from(map['required_skills']),
      numberOfRounds: map['number_of_rounds'],
      batch: map['batch'],
      jobLink:map['jobLink']
    );
  }

  // Method to convert an instance to a map (used for API requests)
  Map<String, dynamic> toMap() {
    return {
      'company_id': companyId,
      'job_role': jobRole,
      'location': location,
      'description': description,
      'salary': salary,
      'drive_date': driveDate?.toIso8601String(),
      'drive_time': driveTime,
      'eligible_10th_mark': eligible10thMark,
      'eligible_12th_mark': eligible12thMark,
      'eligible_cgpa': eligibleCgpa,
      'eligible_history_of_arrears': eligibleHistoryOfArrears,
      'eligible_current_arrears': eligibleCurrentArrears,
      'job_type': jobType,
      'venue': venue,
      'required_skills': requiredSkills,
      'number_of_rounds': numberOfRounds,
      'batch':batch,
      'jobLine':jobLink
    };
  }
}
