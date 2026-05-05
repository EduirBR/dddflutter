class ResponseModel {
  final String message;
  final bool error;
  final dynamic data;
  final int? statusCode;

  ResponseModel({
    required this.message,
    required this.error,
    required this.data,
    this.statusCode,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json, int? statusCode) =>
      ResponseModel(
        message: json['message'],
        error: json['error'],
        data: json['data'],
        statusCode: statusCode,
      );
}

typedef RequestFunction =
    Future<ResponseModel> Function(Map<String, dynamic> body);
