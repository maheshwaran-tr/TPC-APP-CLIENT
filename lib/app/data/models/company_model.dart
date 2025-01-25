import 'drive_model.dart';

class Company {
  final int companyId;
  final String companyName;
  final DateTime createdAt;
  final List<Drive>? drives;
  final String logoUrl;

  Company({
    required this.companyId,
    required this.companyName,
    required this.createdAt,
    required this.drives,
    required this.logoUrl,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      companyId: json['company_id'],
      companyName: json['company_name'],
      createdAt: DateTime.parse(json['created_at']),
      drives: json['drives']!=null ? List<Drive>.from(json['drives'].map((x) => Drive.fromJson(x))):null,
      logoUrl: json['logo_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'company_id': companyId,
      'company_name': companyName,
      'created_at': createdAt.toIso8601String(),
      'drives': drives!=null? List<dynamic>.from(drives!.map((x) => x.toJson())):null,
      'logo_url': logoUrl,
    };
  }
}