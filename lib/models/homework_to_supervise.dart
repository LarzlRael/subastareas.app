part of 'models.dart';

List<HomeworkToSupervise> homeworkToSuperviseFromJson(String str) =>
    List<HomeworkToSupervise>.from(
        json.decode(str).map((x) => HomeworkToSupervise.fromJson(x)));

String homeworkToSuperviseToJson(List<HomeworkToSupervise> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HomeworkToSupervise {
  HomeworkToSupervise({
    required this.id,
    required this.title,
    required this.description,
    required this.offeredAmount,
    required this.fileUrl,
    required this.fileType,
    required this.resolutionTime,
    required this.category,
    required this.subCategory,
    required this.observation,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String title;
  dynamic description;
  int offeredAmount;
  String fileUrl;
  String fileType;
  DateTime resolutionTime;
  String category;
  dynamic subCategory;
  dynamic observation;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  factory HomeworkToSupervise.fromJson(Map<String, dynamic> json) =>
      HomeworkToSupervise(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        offeredAmount: json["offered_amount"],
        fileUrl: json["fileUrl"],
        fileType: json["fileType"],
        resolutionTime: DateTime.parse(json["resolutionTime"]),
        category: json["category"],
        subCategory: json["subCategory"],
        observation: json["observation"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
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
        "subCategory": subCategory,
        "observation": observation,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
