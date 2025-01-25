// To parse this JSON data, do
//
//     final studentRegisterModel = studentRegisterModelFromJson(jsonString);

import 'dart:convert';

StudentRegisterModel studentRegisterModelFromJson(String str) =>
    StudentRegisterModel.fromJson(json.decode(str));

String studentRegisterModelToJson(StudentRegisterModel data) =>
    json.encode(data.toJson());

class StudentRegisterModel {
  final String username; // Student Roll Number
  final String password;
  final String role;
  final String regno;
  final String name;
  final int deptId;
  final String gender;
  final String fatherName;
  final DateTime dob;
  final int score10Th;
  final String board10Th;
  final int yop10Th;
  final int score12Th;
  final String board12Th;
  final int yop12Th;
  final int scoreDiploma;
  final String branchDiploma;
  final int yopDiploma;
  final String? profileUrl;
  final String? resumeUrl;
  final int historyOfArrears;
  final int currentArrears;
  final double cgpa;
  final String phoneNumber;
  final String email;
  final String placementWilling;

  StudentRegisterModel({
    required this.password,
    required this.role,
    required this.username,
    required this.regno,
    required this.name,
    required this.deptId,
    required this.gender,
    required this.fatherName,
    required this.dob,
    required this.score10Th,
    required this.board10Th,
    required this.yop10Th,
    required this.score12Th,
    required this.board12Th,
    required this.yop12Th,
    required this.scoreDiploma,
    required this.branchDiploma,
    required this.yopDiploma,
    required this.cgpa,
    required this.phoneNumber,
    this.profileUrl,
    this.resumeUrl,
    required this.historyOfArrears,
    required this.currentArrears,
    required this.email,
    required this.placementWilling,
  });

  factory StudentRegisterModel.fromJson(Map<String, dynamic> json) =>
      StudentRegisterModel(
        password: json["password"],
        role: json["role"],
        username: json["username"],
        regno: json["regno"],
        name: json["name"],
        deptId: json["dept_id"],
        gender: json["gender"],
        fatherName: json["father_name"],
        dob: DateTime.parse(json["dob"]),
        score10Th: json["score_10th"],
        board10Th: json["board_10th"],
        yop10Th: json["yop_10th"],
        score12Th: json["score_12th"],
        board12Th: json["board_12th"],
        yop12Th: json["yop_12th"],
        scoreDiploma: json["score_diploma"],
        branchDiploma: json["branch_diploma"],
        yopDiploma: json["yop_diploma"],
        cgpa: json["cgpa"].toDouble(),
        phoneNumber: json["phone_number"],
        email: json["email"],
        placementWilling: json["placement_willing"],
        historyOfArrears: json["history_of_arrears"],
        currentArrears: json["current_arrears"],
        profileUrl: json["profile_url"],
        resumeUrl: json["resume_url"],
      );

  Map<String, dynamic> toJson() => {
        "password": password,
        "role": role,
        "username": username,
        "regno": regno,
        "name": name,
        "dept_id": deptId,
        "gender": gender,
        "father_name": fatherName,
        "dob":
            "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "score_10th": score10Th,
        "board_10th": board10Th,
        "yop_10th": yop10Th,
        "score_12th": score12Th,
        "board_12th": board12Th,
        "yop_12th": yop12Th,
        "score_diploma": scoreDiploma,
        "branch_diploma": branchDiploma,
        "yop_diploma": yopDiploma,
        "cgpa": cgpa,
        "phone_number": phoneNumber,
        "email": email,
        "placement_willing": placementWilling,
      };
}
