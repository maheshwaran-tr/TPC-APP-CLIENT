class Admin {
  final int? adminId;
  final int? userId;
  final String adminRollNo;
  final String name;
  final String? phoneNumber;
  final String? email;
  final String? profileUrl;
  final DateTime createdAt;

  Admin({
    required this.adminId,
    required this.adminRollNo,
    required this.name,
    required this.userId,
    this.phoneNumber,
    this.email,
    this.profileUrl,
    required this.createdAt,
  });

  // Factory constructor for creating an instance from JSON
  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      adminId: json['admin_id'],
      adminRollNo: json['admin_rollno'],
      name: json['name'],
      userId: json['user_id'],
      phoneNumber: json['phone_number'],
      email: json['email'],
      profileUrl: json['profile_url'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  // Method for converting an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'admin_id': adminId,
      'admin_rollno': adminRollNo,
      'name': name,
      'user_id': userId,
      'phone_number': phoneNumber,
      'email': email,
      'profile_url': profileUrl,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
