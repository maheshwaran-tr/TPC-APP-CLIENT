class RegisterStudent {
  String password;
  String role;
  String username;
  String regno;
  String name;
  int deptId;
  String gender;
  String fatherName;
  DateTime dob;
  int score10th;
  String board10th;
  int yop10th;
  int score12th;
  String board12th;
  int yop12th;
  int scoreDiploma;
  String branchDiploma;
  DateTime? yopDiploma;
  int currentArrears;
  int historyOfArrears;
  double cgpa;
  String phoneNumber;
  String email;
  String? resumeUrl;
  String? profileUrl;
  String placementWilling;

  RegisterStudent({
    required this.password,
    required this.role,
    required this.username,
    required this.regno,
    required this.name,
    required this.deptId,
    required this.gender,
    required this.fatherName,
    required this.dob,
    required this.score10th,
    required this.board10th,
    required this.yop10th,
    required this.score12th,
    required this.board12th,
    required this.yop12th,
    required this.scoreDiploma,
    required this.branchDiploma,
    this.yopDiploma,
    required this.currentArrears,
    required this.historyOfArrears,
    required this.cgpa,
    required this.phoneNumber,
    required this.email,
    this.resumeUrl,
    this.profileUrl,
    required this.placementWilling,
  });

  // Factory method to create a RegisterStudent instance from a map (e.g., from JSON)
  factory RegisterStudent.fromJson(Map<String, dynamic> json) {
    return RegisterStudent(
      password: json['password'],
      role: json['role'],
      username: json['username'],
      regno: json['regno'],
      name: json['name'],
      deptId: json['dept_id'],
      gender: json['gender'],
      fatherName: json['father_name'],
      dob: DateTime.parse(json['dob']),
      score10th: json['score_10th'],
      board10th: json['board_10th'],
      yop10th: json['yop_10th'],
      score12th: json['score_12th'],
      board12th: json['board_12th'],
      yop12th: json['yop_12th'],
      scoreDiploma: json['score_diploma'],
      branchDiploma: json['branch_diploma'],
      yopDiploma: json['yop_diploma'] != null ? DateTime.parse(json['yop_diploma']) : null,
      currentArrears: json['current_arrears'],
      historyOfArrears: json['history_of_arrears'],
      cgpa: json['cgpa'].toDouble(),
      phoneNumber: json['phone_number'],
      email: json['email'],
      resumeUrl: json['resume_url'],
      profileUrl: json['profile_url'],
      placementWilling: json['placement_willing'],
    );
  }

  // Method to convert a RegisterStudent instance to a map (e.g., for sending data as JSON)
  Map<String, dynamic> toJson() {
    return {
      'password': password,
      'role': role,
      'username': username,
      'regno': regno,
      'name': name,
      'dept_id': deptId,
      'gender': gender,
      'father_name': fatherName,
      'dob': dob.toIso8601String(),
      'score_10th': score10th,
      'board_10th': board10th,
      'yop_10th': yop10th,
      'score_12th': score12th,
      'board_12th': board12th,
      'yop_12th': yop12th,
      'score_diploma': scoreDiploma,
      'branch_diploma': branchDiploma,
      'yop_diploma': yopDiploma?.toIso8601String(),
      'current_arrears': currentArrears,
      'history_of_arrears': historyOfArrears,
      'cgpa': cgpa,
      'phone_number': phoneNumber,
      'email': email,
      'resume_url': resumeUrl,
      'profile_url': profileUrl,
      'placement_willing': placementWilling,
    };
  }
}
