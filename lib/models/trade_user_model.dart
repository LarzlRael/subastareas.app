part of 'models.dart';
// To parse this JSON data, do
//
//     final tradeUserModel = tradeUserModelFromJson(jsonString);

List<TradeUserModel> tradeUserModelFromJson(String str) =>
    List<TradeUserModel>.from(
        json.decode(str).map((x) => TradeUserModel.fromJson(x)));

String tradeUserModelToJson(List<TradeUserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TradeUserModel {
  TradeUserModel({
    required this.solvedHomeworkUrl,
    required this.tradeId,
    required this.homeworkId,
    required this.status,
    required this.solvedFileType,
    required this.title,
    required this.resolutionTime,
    required this.description,
    required this.category,
    required this.fileUrl,
    required this.fileType,
    required this.offerId,
    required this.username,
    required this.id,
    required this.profileImageUrl,
    required this.commentTaskRejected,
  });

  String? solvedHomeworkUrl;
  int tradeId;
  int homeworkId;
  String status;
  String solvedFileType;
  String title;
  DateTime resolutionTime;
  dynamic description;
  String category;
  dynamic fileUrl;
  String fileType;
  int offerId;
  String username;
  int id;
  dynamic profileImageUrl;
  dynamic commentTaskRejected;

  factory TradeUserModel.fromJson(Map<String, dynamic> json) => TradeUserModel(
        solvedHomeworkUrl: json["solvedHomeworkUrl"],
        tradeId: json["tradeId"],
        homeworkId: json["homeworkId"],
        status: json["status"],
        solvedFileType: json["solvedFileType"],
        title: json["title"],
        commentTaskRejected: json["commentTaskRejected"],
        resolutionTime: DateTime.parse(json["resolutionTime"]),
        description: json["description"],
        category: json["category"],
        fileUrl: json["fileUrl"],
        fileType: json["fileType"],
        offerId: json["offerId"],
        username: json["username"],
        id: json["id"],
        profileImageUrl: json["profileImageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "solvedHomeworkUrl": solvedHomeworkUrl,
        "tradeId": tradeId,
        "homeworkId": homeworkId,
        "status": status,
        "solvedFileType": solvedFileType,
        "title": title,
        "resolutionTime": resolutionTime.toIso8601String(),
        "description": description,
        "category": category,
        "fileUrl": fileUrl,
        "fileType": fileType,
        "offerId": offerId,
        "username": username,
        "id": id,
        "profileImageUrl": profileImageUrl,
      };
}
