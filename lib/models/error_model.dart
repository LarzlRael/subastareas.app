part of 'models.dart';

ErrorModel errorModelFromJson(String str) =>
    ErrorModel.fromJson(json.decode(str));

String errorModelToJson(ErrorModel data) => json.encode(data.toJson());

class ErrorModel {
  ErrorModel({
    required this.statusCode,
    required this.message,
    required this.error,
  });

  int statusCode;
  String message;
  String error;

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        statusCode: json["statusCode"],
        message: json["message"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "error": error,
      };
}
