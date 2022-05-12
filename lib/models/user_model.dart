// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.id,
    required this.username,
    required this.name,
    required this.lastName,
    required this.email,
    required this.nickName,
    required this.phone,
    required this.profileImageUrl,
    required this.google,
    required this.verify,
    required this.createdAt,
    required this.updatedAt,
    required this.supervisor,
    required this.wallet,
    required this.professor,
    required this.userRols,
    required this.userDevices,
    required this.accessToken,
  });

  int id;
  String username;
  dynamic name;
  dynamic lastName;
  String email;
  dynamic nickName;
  dynamic phone;
  dynamic profileImageUrl;
  bool google;
  bool verify;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic supervisor;
  Wallet wallet;
  dynamic professor;
  List<String> userRols;
  List<String> userDevices;
  String accessToken;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        username: json["username"],
        name: json["name"],
        lastName: json["lastName"],
        email: json["email"],
        nickName: json["nickName"],
        phone: json["phone"],
        profileImageUrl: json["profileImageUrl"],
        google: json["google"],
        verify: json["verify"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        supervisor: json["supervisor"],
        wallet: Wallet.fromJson(json["wallet"]),
        professor: json["professor"],
        userRols: List<String>.from(json["userRols"].map((x) => x)),
        userDevices: List<String>.from(json["userDevices"].map((x) => x)),
        accessToken: json["accessToken"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "name": name,
        "lastName": lastName,
        "email": email,
        "nickName": nickName,
        "phone": phone,
        "profileImageUrl": profileImageUrl,
        "google": google,
        "verify": verify,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "supervisor": supervisor,
        "wallet": wallet.toJson(),
        "professor": professor,
        "userRols": List<dynamic>.from(userRols.map((x) => x)),
        "userDevices": List<dynamic>.from(userDevices.map((x) => x)),
        "accessToken": accessToken,
      };
}

class Wallet {
  Wallet({
    required this.id,
    required this.balance,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int balance;
  DateTime createdAt;
  DateTime updatedAt;

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        id: json["id"],
        balance: json["balance"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "balance": balance,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
