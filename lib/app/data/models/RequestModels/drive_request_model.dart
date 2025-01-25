class DriveRequest {
  final int companyId;
  final String jobRole;
  final String? location;
  final String? description;
  final String? salary;
  final String? trainingPeriod;
  final String? trainingStipend;
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

  DriveRequest({
    required this.companyId,
    required this.jobRole,
    this.location,
    this.description,
    this.salary,
    this.trainingPeriod,
    this.trainingStipend,
    this.driveDate,
    this.driveTime,
    this.eligible10thMark,
    this.eligible12thMark,
    this.eligibleCgpa,
    this.eligibleHistoryOfArrears,
    this.eligibleCurrentArrears,
    this.jobType,
    this.venue,
    required this.requiredSkills,
    required this.numberOfRounds,
  });

  // Factory method to create an instance from a map (used for API response parsing)
  factory DriveRequest.fromMap(Map<String, dynamic> map) {
    return DriveRequest(
      companyId: map['company_id'],
      jobRole: map['job_role'],
      location: map['location'],
      description: map['description'],
      salary: map['salary'],
      trainingPeriod: map['training_period'],
      trainingStipend: map['training_stipend'],
      driveDate:
          map['drive_date'] != null ? DateTime.parse(map['drive_date']) : null,
      driveTime: map['drive_time'],
      eligible10thMark: map['eligible_10th_mark'],
      eligible12thMark: map['eligible_12th_mark'],
      eligibleCgpa: map['eligible_cgpa']?.toDouble(),
      eligibleHistoryOfArrears: map['eligible_history_of_arrears'],
      eligibleCurrentArrears: map['eligible_current_arrears'],
      jobType: map['job_type'],
      venue: map['venue'],
      requiredSkills: List<String>.from(map['required_skills']),
      numberOfRounds: map['number_of_rounds'],
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
      'training_period': trainingPeriod,
      'training_stipend': trainingStipend,
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
    };
  }
}
