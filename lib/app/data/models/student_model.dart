import 'application_model.dart';
import 'department_model.dart';

class Student {
  final int studentId;
  final int? userId;
  final String? rollno;
  final String? regno;
  final String name;
  final int deptId;
  final String? gender;
  final String? fatherName;
  final String? dob;
  final int? score10th;
  final String? board10th;
  final int? yop10th;
  final int? score12th;
  final String? board12th;
  final int? yop12th;
  final int? scoreDiploma;
  final String? branchDiploma;
  final int? yopDiploma;
  final double? cgpa;
  final int? historyOfArrears;  
  final int? currentArrears;
  final String? section;
  final String? phoneNumber;
  final String? email;
  final String? resumeUrl;
  final String? profileUrl;
  final String? placementWilling;
  final DateTime? createdAt;
  final List<Application>? applications;
  final Department? department;
  // resumeUrl

  Student({
    required this.studentId,
    this.userId,
    this.rollno,
    this.regno,
    required this.name,
    required this.deptId,
    this.gender,
    this.fatherName,
    this.dob,
    this.score10th,
    this.board10th,
    this.yop10th,
    this.score12th,
    this.board12th,
    this.yop12th,
    this.scoreDiploma,
    this.branchDiploma,
    this.yopDiploma,
    this.cgpa,
    this.section,
    this.phoneNumber,
    this.email,
    this.placementWilling,
    this.resumeUrl,
    this.profileUrl,
    this.historyOfArrears,
    this.currentArrears,
    this.createdAt,
    this.applications,
    this.department,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      studentId: json['student_id'],
      userId: json['user_id'],
      rollno: json['rollno'],
      regno: json['regno'],
      name: json['name'],
      deptId: json['dept_id'],
      gender: json['gender'],
      fatherName: json['father_name'],
      dob: json['dob'],
      score10th: json['score_10th'],
      board10th: json['board_10th'],
      yop10th: json['yop_10th'],
      score12th: json['score_12th'],
      board12th: json['board_12th'],
      yop12th: json['yop_12th'],
      scoreDiploma: json['score_diploma'],
      branchDiploma: json['branch_diploma'],
      currentArrears:json['current_arrears'],
      historyOfArrears: json['history_of_arrears'],
      yopDiploma: json['yop_diploma'],
      cgpa: json['cgpa']?.toDouble(),
      phoneNumber: json['phone_number'],
      email: json['email'],
      placementWilling: json['placement_willing'],
      createdAt: DateTime.parse(json['created_at']),
      applications: json['applications'] != null ? List<Application>.from(
          json['applications'].map((x) => Application.fromJson(x))): null,

      department: json['department'] != null? Department.fromJson(json['department']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'student_id': studentId,
      'user_id': userId,
      'rollno': rollno,
      'regno': regno,
      'name': name,
      'dept_id': deptId,
      'gender': gender,
      'father_name': fatherName,
      'dob': dob,
      'score_10th': score10th,
      'board_10th': board10th,
      'yop_10th': yop10th,
      'score_12th': score12th,
      'board_12th': board12th,
      'yop_12th': yop12th,
      'score_diploma': scoreDiploma,
      'branch_diploma': branchDiploma,
      'current_arrears':currentArrears,
      'history_of_arrears':historyOfArrears,
      'yop_diploma': yopDiploma,
      'cgpa': cgpa,
      'phone_number': phoneNumber,
      'email': email,
      'placement_willing': placementWilling,
      'created_at': createdAt?.toIso8601String(),
      'applications': List<dynamic>.from(applications!.map((x) => x.toJson())),
      'department': department?.toJson(),
    };
  }
}