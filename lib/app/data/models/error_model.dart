class ErrorModel {
  String? message;
  String? statusCode;

  ErrorModel({this.message, this.statusCode});

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
        statusCode: json['status_code'], message: json['message']);
  }

  Map<String, dynamic> toJson() {
    return {
      'status_code': statusCode,
      'message': message,
    };
  }
}
