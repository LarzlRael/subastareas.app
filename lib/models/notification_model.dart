// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

part of 'models.dart';

// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

List<NotificationModel> notificationModelFromJson(String str) =>
    List<NotificationModel>.from(
        json.decode(str).map((x) => NotificationModel.fromJson(x)));

String notificationModelToJson(List<NotificationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotificationModel {
  NotificationModel({
    required this.id,
    required this.type,
    required this.visible,
    required this.seen,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  int id;
  String type;
  bool visible;
  bool seen;
  String content;
  DateTime createdAt;
  DateTime updatedAt;
  User user;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json["id"],
        type: json["type"],
        visible: json["visible"],
        seen: json["seen"],
        content: json["content"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "visible": visible,
        "seen": seen,
        "content": content,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user": user.toJson(),
      };
}

class User {
  User({
    required this.username,
    required this.profileImageUrl,
  });

  String username;
  String profileImageUrl;

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: capitalizeFirstLetter(json["username"]),
        profileImageUrl: json["profileImageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "profileImageUrl": profileImageUrl,
      };
}
