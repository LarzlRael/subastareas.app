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
  User user;
  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: parseField<int>(json, "id") ?? 0,
        type: parseField<String>(json, "type") ?? "",
        notified: parseField<bool>(json, "notified") ?? false,
        visible: parseField<bool>(json, "visible") ?? false,
        seen: parseField<bool>(json, "seen") ?? false,
        idOffer: parseField<int>(json, "idOffer") ?? 0,
        idHomework: parseField<int>(json, "idHomework") ?? 0,
        offerAmount: parseField<int>(json, "offerAmount") ?? 0,
        body: parseField<String>(json, "body") ?? "",
        category: parseField<String>(json, "category") ?? "",
        createdAt: parseDateTime(json["created_at"]),
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
        "user": user.toJson(),
      };

  static DateTime parseDateTime(String dateTimeString) {
    try {
      DateTime dateTime =
          DateFormat("E MMM dd y HH:mm:ss 'GMT'Z (zzz)", "en_US")
              .parse(dateTimeString);
      return dateTime;
    } catch (e) {
      return DateTime.now(); // Maneja errores de formato como desees
    }
  }

  static T? parseField<T>(Map<String, dynamic> json, String field) {
    if (json.containsKey(field)) {
      final dynamic value = json[field];
      if (value is T) {
        return value;
      }
      if (T == int && value is String) {
        return int.tryParse(value) as T?;
      }
      if (T == double && value is String) {
        return double.tryParse(value) as T?;
      }
      if (T == bool && value is String) {
        if (value.toLowerCase() == 'true') {
          return true as T;
        } else if (value.toLowerCase() == 'false') {
          return false as T;
        }
      }
      if (T == DateTime && value is String) {
        return DateTime.parse(value) as T;
      }
      // Agrega otros tipos de datos según sea necesario
    }
    return null;
  }
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

  static T? parseField<T>(Map<String, dynamic> json, String field) {
    if (json.containsKey(field)) {
      final dynamic value = json[field];
      if (value is T) {
        return value;
      }
      if (T == int && value is String) {
        return int.tryParse(value) as T?;
      }
      if (T == double && value is String) {
        return double.tryParse(value) as T?;
      }
      if (T == bool && value is String) {
        if (value.toLowerCase() == 'true') {
          return true as T;
        } else if (value.toLowerCase() == 'false') {
          return false as T;
        }
      }
      if (T == DateTime && value is String) {
        return DateTime.parse(value) as T;
      }
      // Agrega otros tipos de datos según sea necesario
    }
    return null;
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: parseField<int>(json, "id") ?? 0,
        username: json["username"].toString().toCapitalized(),
        profileImageUrl: json["profileImageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "profileImageUrl": profileImageUrl,
      };
}
