// To parse this JSON data, do
//
//     final homeworksModel = homeworksModelFromJson(jsonString);

import 'dart:convert';

List<HomeworksModel> homeworksModelFromJson(String str) {
  print(str);
  return List<HomeworksModel>.from(
      json.decode(str).map((x) => HomeworksModel.fromJson(x)));
}

String homeworksModelToJson(List<HomeworksModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HomeworksModel {
  HomeworksModel({
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
    this.offers,
  });

  int id;
  String title;
  String description;
  int offeredAmount;
  String fileUrl;
  String fileType;
  DateTime resolutionTime;
  String category;
  String level;
  dynamic observation;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  List<OfferManyHomeworks>? offers;

  factory HomeworksModel.fromJson(Map<String, dynamic> json) => HomeworksModel(
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
        offers: json["offers"] == null
            ? null
            : List<OfferManyHomeworks>.from(
                json["offers"].map((x) => OfferManyHomeworks.fromJson(x))),
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
        "offers": offers == null
            ? null
            : List<dynamic>.from(offers!.map((x) => x.toJson())),
      };
}

class OfferManyHomeworks {
  OfferManyHomeworks({
    required this.id,
    required this.priceOffer,
  });

  int id;
  int priceOffer;

  factory OfferManyHomeworks.fromJson(Map<String, dynamic> json) =>
      OfferManyHomeworks(
        id: json["id"],
        priceOffer: json["priceOffer"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "priceOffer": priceOffer,
      };
}
