// To parse this JSON data, do
//
//     final userTransactionModel = userTransactionModelFromJson(jsonString);

part of 'models.dart';

List<UserTransactionModel> userTransactionModelFromJson(String str) =>
    List<UserTransactionModel>.from(
        json.decode(str).map((x) => UserTransactionModel.fromJson(x)));

String userTransactionModelToJson(List<UserTransactionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserTransactionModel {
  UserTransactionModel({
    required this.id,
    required this.dollarValue,
    required this.currencyType,
    required this.transactionType,
    required this.amount,
    /* required this.status, */
    required this.createdAt,
    required this.updatedAt,
    required this.withdrawalRequestAmount,
  });

  int id;
  int dollarValue;
  String currencyType;
  String transactionType;
  int amount;
  int withdrawalRequestAmount;
  /* bool status; */
  DateTime createdAt;
  DateTime updatedAt;

  factory UserTransactionModel.fromJson(Map<String, dynamic> json) =>
      UserTransactionModel(
        id: json["id"],
        dollarValue: json["dollarValue"],
        currencyType: json["currencyType"],
        transactionType: json["transactionType"],
        amount: json["amount"],
        /* status: json["status"], */
        withdrawalRequestAmount: json["withdrawalRequestAmount"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dollarValue": dollarValue,
        "currencyType": currencyType,
        "transactionType": transactionType,
        "amount": amount,
        /* "status": status, */
        "withdrawalRequestAmount": withdrawalRequestAmount,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
