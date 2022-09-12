// To parse this JSON data, do
//
//     final priceDollarToday = priceDollarTodayFromJson(jsonString);

part of './models.dart';

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
    required this.priceUsd,
    required this.amount,
    required this.priceBob,
    required this.nameBobPrice,
  });

  String planeName;
  double priceUsd;
  int amount;
  double priceBob;
  String nameBobPrice;

  factory PlanesModel.fromJson(Map<String, dynamic> json) => PlanesModel(
        planeName: json["planeName"],
        priceUsd: json["priceUsd"].toDouble(),
        amount: json["amount"],
        priceBob: json["priceBob"].toDouble(),
        nameBobPrice: json["nameBobPrice"],
      );

  Map<String, dynamic> toJson() => {
        "planeName": planeName,
        "priceUsd": priceUsd,
        "amount": amount,
        "priceBob": priceBob,
        "nameBobPrice": nameBobPrice,
      };
}
