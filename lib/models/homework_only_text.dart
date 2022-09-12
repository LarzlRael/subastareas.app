// To parse this JSON data, do
//
//     final homeworkOnlyText = homeworkOnlyTextFromJson(jsonString);

import 'dart:convert';

HomeworkOnlyText homeworkOnlyTextFromJson(String str) =>
    HomeworkOnlyText.fromJson(json.decode(str));

String homeworkOnlyTextToJson(HomeworkOnlyText data) =>
    json.encode(data.toJson());

class HomeworkOnlyText {
  HomeworkOnlyText({
    required this.title,
    required this.offeredAmount,
    required this.resolutionTime,
    required this.category,
  });

  String title;
  String offeredAmount;
  bool resolutionTime;
  String category;

  factory HomeworkOnlyText.fromJson(Map<String, dynamic> json) =>
      HomeworkOnlyText(
        title: json["title"],
        offeredAmount: json["offered_amount"],
        resolutionTime: json["resolutionTime"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "offered_amount": offeredAmount,
        "resolutionTime": resolutionTime,
        "category": category,
      };
}
