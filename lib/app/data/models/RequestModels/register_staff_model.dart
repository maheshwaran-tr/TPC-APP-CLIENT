class RegisterStaff {
  final String username;
  final String password;
  final String email;
  final String phoneNumber;
  final String profileUrl;
  final String role;
  final String name;

  RegisterStaff({
    required this.username,
    required this.password,
    required this.email,
    required this.phoneNumber,
    required this.profileUrl,
    required this.role,
    required this.name,
  });

  // Convert JSON to Staff model
  factory RegisterStaff.fromJson(Map<String, dynamic> json) {
    return RegisterStaff(
      username: json['username'],
      password: json['password'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      profileUrl: json['profile_url'],
      role: json['role'],
      name: json['name'],
    );
  }

  // Convert Staff model to JSON
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'email': email,
      'phone_number': phoneNumber,
      'profile_url': profileUrl,
      'role': role,
      'name': name,
    };
  }
}
