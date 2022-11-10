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
    required this.idTransaction,
    required this.idWithdraw,
    required this.withdrawalRequestAmount,
    required this.transactionType,
    required this.username,
    required this.profileImageUrl,
    required this.email,
    required this.phone,
    required this.createdAt,
    required this.idUser,
  });

  int idTransaction;
  int idWithdraw;
  int withdrawalRequestAmount;
  String transactionType;
  String username;
  int idUser;
  dynamic profileImageUrl;
  String email;
  String phone;
  DateTime createdAt;

  factory WithdrawalRequestsModel.fromJson(Map<String, dynamic> json) =>
      WithdrawalRequestsModel(
        idTransaction: json["id_transaction"],
        idWithdraw: json["id_withdraw"],
        withdrawalRequestAmount: json["withdrawalRequestAmount"],
        transactionType: json["transactionType"],
        username: json["username"],
        profileImageUrl: json["profileImageUrl"],
        email: json["email"],
        idUser: json["id_user"],
        phone: json["phone"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id_transaction": idTransaction,
        "id_withdraw": idWithdraw,
        "withdrawalRequestAmount": withdrawalRequestAmount,
        "transactionType": transactionType,
        "username": username,
        "profileImageUrl": profileImageUrl,
        "email": email,
        "id_user": idUser,
        "phone": phone,
        "created_at": createdAt.toIso8601String(),
      };
}
