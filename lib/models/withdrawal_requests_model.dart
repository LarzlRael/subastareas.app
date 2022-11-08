part of 'models.dart';
// To parse this JSON data, do
//
//     final withdrawalRequestsModel = withdrawalRequestsModelFromJson(jsonString);

List<WithdrawalRequestsModel> withdrawalRequestsModelFromJson(String str) =>
    List<WithdrawalRequestsModel>.from(
        json.decode(str).map((x) => WithdrawalRequestsModel.fromJson(x)));

String withdrawalRequestsModelToJson(List<WithdrawalRequestsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WithdrawalRequestsModel {
  WithdrawalRequestsModel({
    required this.id,
    required this.createdAt,
    required this.amount,
    required this.transactionType,
    required this.username,
    required this.email,
    required this.profileImageUrl,
  });

  int id;
  DateTime createdAt;
  int amount;
  String transactionType;
  String username;
  String email;
  dynamic profileImageUrl;

  factory WithdrawalRequestsModel.fromJson(Map<String, dynamic> json) =>
      WithdrawalRequestsModel(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        amount: json["amount"],
        email: json["email"],
        transactionType: json["transactionType"],
        username: json["username"],
        profileImageUrl: json["profileImageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "amount": amount,
        "transactionType": transactionType,
        "username": username,
        "email": email,
        "profileImageUrl": profileImageUrl,
      };
}
