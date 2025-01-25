
class Department {
  final int deptId;
  final String name;
  final String? description;
  final String? logo;

  Department({
    required this.deptId,
    required this.name,
    this.description,
    this.logo,
    
  });

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      deptId: json['dept_id'],
      name: json['name'],
      description: json['description'],
      logo: json['logo_url']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dept_id': deptId,
      'name': name,
      'description': description,
      'logo_url':logo
    };
  }
}
