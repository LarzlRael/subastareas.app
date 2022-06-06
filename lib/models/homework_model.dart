// To parse this JSON data, do
//
//     final homeworkModel = homeworkModelFromJson(jsonString);

import 'dart:convert';

List<HomeworkModel> homeworkModelFromJson(String str) =>
    List<HomeworkModel>.from(
        json.decode(str).map((x) => HomeworkModel.fromJson(x)));

String homeworkModelToJson(List<HomeworkModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HomeworkModel {
  HomeworkModel({
    required this.id,
    required this.title,
    required this.description,
    required this.offeredAmount,
    required this.fileUrl,
    required this.fileType,
    required this.resolutionTime,
    required this.category,
    required this.level,
    required this.observation,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.offers,
    required this.userSupervisor,
  });

  int id;
  String title;
  String description;
  int offeredAmount;
  String fileUrl;
  String fileType;
  DateTime resolutionTime;
  String category;
  int level;
  dynamic observation;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  List<Offer> offers;
  dynamic userSupervisor;

  factory HomeworkModel.fromJson(Map<String, dynamic> json) => HomeworkModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        offeredAmount: json["offered_amount"],
        fileUrl: json["fileUrl"],
        fileType: json["fileType"],
        resolutionTime: DateTime.parse(json["resolutionTime"]),
        category: json["category"],
        level: json["level"],
        observation: json["observation"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        offers: List<Offer>.from(json["offers"].map((x) => Offer.fromJson(x))),
        userSupervisor: json["userSupervisor"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "offered_amount": offeredAmount,
        "fileUrl": fileUrl,
        "fileType": fileType,
        "resolutionTime": resolutionTime.toIso8601String(),
        "category": category,
        "level": level,
        "observation": observation,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "offers": List<dynamic>.from(offers.map((x) => x.toJson())),
        "userSupervisor": userSupervisor,
      };
}

class Offer {
  Offer({
    required this.id,
    required this.priceOffer,
    required this.accept,
    required this.edited,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  int id;
  int priceOffer;
  bool accept;
  bool edited;
  DateTime createdAt;
  DateTime updatedAt;
  User user;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        id: json["id"],
        priceOffer: json["priceOffer"],
        accept: json["accept"],
        edited: json["edited"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "priceOffer": priceOffer,
        "accept": accept,
        "edited": edited,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user": user.toJson(),
      };
}

class User {
  User({
    required this.id,
    required this.username,
    required this.password,
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
    required this.rols,
    required this.supervisor,
    required this.wallet,
    required this.professor,
    required this.device,
  });

  int id;
  String username;
  String password;
  dynamic name;
  dynamic lastName;
  String email;
  dynamic nickName;
  dynamic phone;
  String profileImageUrl;
  bool google;
  bool verify;
  DateTime createdAt;
  DateTime updatedAt;
  List<Rol> rols;
  dynamic supervisor;
  Wallet wallet;
  Professor professor;
  List<Device> device;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        password: json["password"],
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
        rols: List<Rol>.from(json["rols"].map((x) => Rol.fromJson(x))),
        supervisor: json["supervisor"],
        wallet: Wallet.fromJson(json["wallet"]),
        professor: Professor.fromJson(json["professor"]),
        device:
            List<Device>.from(json["device"].map((x) => Device.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "password": password,
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
        "rols": List<dynamic>.from(rols.map((x) => x.toJson())),
        "supervisor": supervisor,
        "wallet": wallet.toJson(),
        "professor": professor.toJson(),
        "device": List<dynamic>.from(device.map((x) => x.toJson())),
      };
}

class Device {
  Device({
    required this.id,
    required this.idDevice,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String idDevice;
  bool active;
  DateTime createdAt;
  DateTime updatedAt;

  factory Device.fromJson(Map<String, dynamic> json) => Device(
        id: json["id"],
        idDevice: json["idDevice"],
        active: json["active"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idDevice": idDevice,
        "active": active,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Professor {
  Professor({
    required this.id,
    required this.solvedHomeworks,
    required this.reputation,
  });

  int id;
  int solvedHomeworks;
  int reputation;

  factory Professor.fromJson(Map<String, dynamic> json) => Professor(
        id: json["id"],
        solvedHomeworks: json["solvedHomeworks"],
        reputation: json["reputation"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "solvedHomeworks": solvedHomeworks,
        "reputation": reputation,
      };
}

class Rol {
  Rol({
    required this.id,
    required this.rolName,
    required this.active,
  });

  int id;
  String rolName;
  bool active;

  factory Rol.fromJson(Map<String, dynamic> json) => Rol(
        id: json["id"],
        rolName: json["rolName"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rolName": rolName,
        "active": active,
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
