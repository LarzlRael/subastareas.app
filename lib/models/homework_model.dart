import 'dart:convert';

Translate translateFromJson(String str) => Translate.fromJson(json.decode(str));

String translateToJson(Translate data) => json.encode(data.toJson());

class Translate {
  Translate({
    this.id = "",
    required this.title,
    required this.description,
    required this.offeredAmount,
    required this.category,
    required this.resolutionTime,
  });

  String id;
  String title;
  String description;
  int offeredAmount;
  String category;
  DateTime resolutionTime;

  factory Translate.fromJson(Map<String, dynamic> json) => Translate(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        offeredAmount: json["offered_amount"],
        category: json["category"],
        resolutionTime: DateTime.parse(json["resolutionTime"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "offered_amount": offeredAmount,
        "category": category,
        "resolutionTime": resolutionTime.toIso8601String(),
      };
}
