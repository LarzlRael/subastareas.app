// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

part of 'models.dart';

List<NotificationModel> notificationsModelFromJson(String str) =>
    List<NotificationModel>.from(
        json.decode(str).map((x) => NotificationModel.fromJson(x)));

String notificationsModelToJson(List<NotificationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

NotificationModel notificationModelFromMap(Map<String, dynamic> map) =>
    NotificationModel.fromJson(map);

class NotificationModel {
  NotificationModel({
    required this.id,
    required this.type,
    required this.visible,
    required this.seen,
    required this.idHomework,
    required this.idOffer,
    required this.body,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.notified,
    required this.offerAmount,
    this.category,
  });

  int id;
  String type;
  bool visible;
  bool seen;
  bool notified;
  int idHomework;
  int idOffer;
  int offerAmount;
  dynamic category;
  String body;
  DateTime createdAt;
  DateTime updatedAt;
  User user;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json["id"],
        type: json["type"],
        notified: json["notified"],
        visible: json["visible"],
        seen: json["seen"],
        idOffer: json["idOffer"],
        idHomework: json["idHomework"],
        offerAmount: json["offerAmount"],
        body: json["body"],
        category: json["category"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: User.fromJson(json["userOrigin"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "visible": visible,
        "seen": seen,
        "idHomework": idHomework,
        "idOffer": idOffer,
        "category": category,
        "content": body,
        "offerAmount": offerAmount,
        "notified": notified,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user": user.toJson(),
      };
}

class User {
  User({
    required this.id,
    required this.username,
    required this.profileImageUrl,
  });

  int id;
  String username;
  dynamic profileImageUrl;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"].toString().toCapitalized(),
        profileImageUrl: json["profileImageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "profileImageUrl": profileImageUrl,
      };
}
