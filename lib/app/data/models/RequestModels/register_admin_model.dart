class RegisterAdmin {
  final String username;
  final String password;
  final String email;
  final String role;
  final String phoneNumber;
  final String name;
  final String profileUrl;

  RegisterAdmin({
    required this.username,
    required this.password,
    required this.email,
    required this.role,
    required this.phoneNumber,
    required this.name,
    required this.profileUrl,
  });

  // Convert JSON to RegisterAdmin model
  factory RegisterAdmin.fromJson(Map<String, dynamic> json) {
    return RegisterAdmin(
      username: json['username'],
      password: json['password'],
      email: json['email'],
      role: json['role'],
      phoneNumber: json['phone_number'],
      name: json['name'],
      profileUrl: json['profile_url'],
    );
  }

  // Convert RegisterAdmin model to JSON
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'email': email,
      'role': role,
      'phone_number': phoneNumber,
      'name': name,
      'profile_url': profileUrl,
    };
  }
}
