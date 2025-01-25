import 'student_model.dart';
import 'staff_model.dart';
import 'admin_model.dart';
import 'user_role_model.dart';

class User {
  final int userId;
  final String username;
  final String email;
  final String password;
  final UserRole role;
  final DateTime createdAt;
  String? deviceToken;
  final Student? student;
  final Staff? staff;
  final Admin? admin;

  User({
    required this.userId,
    required this.username,
    required this.email,
    required this.password,
    required this.role,
    required this.createdAt,
    this.deviceToken,
    this.student,
    this.staff,
    this.admin,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      role: UserRole.values
          .firstWhere((e) => e.toString() == 'UserRole.' + json['role']),
      deviceToken: json['deviceToken'],
      createdAt: DateTime.parse(json['created_at']),
      student:
          json['student'] != null ? Student.fromJson(json['student']) : null,
      staff: json['staff'] != null ? Staff.fromJson(json['staff']) : null,
      admin: json['admin'] != null ? Admin.fromJson(json['admin']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'username': username,
      'email': email,
      'password': password,
      'role': role.toString().split('.').last,
      'deviceToken': deviceToken,
      'created_at': createdAt.toIso8601String(),
      'student': student?.toJson(),
      'staff': staff?.toJson(),
      'admin': admin?.toJson(),
    };
  }
}
