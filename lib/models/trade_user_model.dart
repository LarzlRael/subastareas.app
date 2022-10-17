part of 'models.dart';
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
    required this.title,
    required this.resolutionTime,
    required this.description,
    required this.offerId,
    required this.fileType,
    required this.solvedFileType,
    required this.fileUrl,
  });

  String? solvedHomeworkUrl;
  int tradeId;
  int homeworkId;
  int offerId;
  String status;
  String title;
  DateTime resolutionTime;
  String fileType;
  String solvedFileType;
  String? fileUrl;
  String? description;

  factory TradeUserModel.fromJson(Map<String, dynamic> json) => TradeUserModel(
        solvedHomeworkUrl: json["solvedHomeworkUrl"] == null
            ? null
            : json["solvedHomeworkUrl"],
        fileUrl: json["fileUrl"] == null ? null : json["fileUrl"],
        tradeId: json["tradeId"],
        offerId: json["offerId"],
        homeworkId: json["homeworkId"],
        status: json["status"],
        title: json["title"],
        fileType: json["fileType"],
        solvedFileType: json["solvedFileType"],
        resolutionTime: DateTime.parse(json["resolutionTime"]),
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toJson() => {
        "solvedHomeworkUrl":
            solvedHomeworkUrl == null ? null : solvedHomeworkUrl,
        "fileUrl": fileUrl == null ? null : fileUrl,
        "tradeId": tradeId,
        "homeworkId": homeworkId,
        "status": status,
        "title": title,
        "resolutionTime": resolutionTime.toIso8601String(),
        "description": description == null ? null : description,
        "offerId": offerId,
        "fileType": fileType,
        "solvedFileType": solvedFileType,
      };
}
