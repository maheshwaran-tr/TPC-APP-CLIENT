
class Status {
  final int statusId;
  final String status;
  final String? description;

  Status({
    required this.statusId,
    required this.status,
    this.description,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      statusId: json['status_id'],
      status: json['status'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status_id': statusId,
      'status': status,
      'description': description,
    };
  }
}