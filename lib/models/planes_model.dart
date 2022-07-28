// To parse this JSON data, do
//
//     final priceDollarToday = priceDollarTodayFromJson(jsonString);

part of './models.dart';

// To parse this JSON data, do
//
//     final planesModel = planesModelFromJson(jsonString);

// To parse this JSON data, do
//
//     final planesModel = planesModelFromJson(jsonString);

List<PlanesModel> planesModelFromJson(String str) => List<PlanesModel>.from(
    json.decode(str).map((x) => PlanesModel.fromJson(x)));

String planesModelToJson(List<PlanesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PlanesModel {
  PlanesModel({
    required this.planeName,
    required this.price,
    required this.amount,
  });

  String planeName;
  String price;
  int amount;

  factory PlanesModel.fromJson(Map<String, dynamic> json) => PlanesModel(
        planeName: json["planeName"],
        price: json["price"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "planeName": planeName,
        "price": price,
        "amount": amount,
      };
}
