// To parse this JSON data, do
//
//     final staffRegisterModel = staffRegisterModelFromJson(jsonString);
import 'dart:convert';

StaffRegisterModel staffRegisterModelFromJson(String str) => StaffRegisterModel.fromJson(json.decode(str));

String staffRegisterModelToJson(StaffRegisterModel data) => json.encode(data.toJson());

class StaffRegisterModel {
    final String username; // Staff Roll Number
    final String password;
    final String email;
    final String role;
    final int deptId;
    final String phoneNumber;

    StaffRegisterModel({
        required this.password,
        required this.email,
        required this.role,
        required this.username,
        required this.deptId,
        required this.phoneNumber,
    });

    factory StaffRegisterModel.fromJson(Map<String, dynamic> json) => StaffRegisterModel(
        password: json["password"],
        email: json["email"],
        role: json["role"],
        username: json["username"],
        deptId: json["dept_id"],
        phoneNumber: json["phone_number"],
    );

    Map<String, dynamic> toJson() => {
        "password": password,
        "email": email,
        "role": role,
        "username": username,
        "dept_id": deptId,
        "phone_number": phoneNumber,
    };
}