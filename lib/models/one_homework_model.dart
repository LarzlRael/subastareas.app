part of 'models.dart';

OneHomeworkModel oneHomeworkModelFromJson(String str) =>
    OneHomeworkModel.fromJson(json.decode(str));

String oneHomeworkModelToJson(OneHomeworkModel data) =>
    json.encode(data.toJson());

class OneHomeworkModel {
  OneHomeworkModel({
    required this.homework,
    required this.comments,
    required this.offers,
  });

  Homework homework;
  List<Comment> comments;
  List<Offer> offers;

  factory OneHomeworkModel.fromJson(Map<String, dynamic> json) =>
      OneHomeworkModel(
        homework: Homework.fromJson(json["homework"]),
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
        offers: List<Offer>.from(json["offers"].map((x) => Offer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "homework": homework.toJson(),
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
        "offers": List<dynamic>.from(offers.map((x) => x.toJson())),
      };
}

class Comment {
  Comment({
    required this.id,
    required this.content,
    required this.edited,
    required this.createdAt,
    required this.user,
  });

  int id;
  String content;
  DateTime createdAt;
  bool edited;
  CommentUser user;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        content: json["content"],
        edited: json["edited"],
        createdAt: DateTime.parse(json["created_at"]),
        user: CommentUser.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
        "edited": edited,
        "user": user.toJson(),
      };
}

class CommentUser {
  CommentUser({
    required this.id,
    required this.username,
    required this.profileImageUrl,
  });

  int id;
  String username;
  String? profileImageUrl;

  factory CommentUser.fromJson(Map<String, dynamic> json) => CommentUser(
        id: json["id"],
        username: capitalizeFirstLetter(json["username"]),
        profileImageUrl: json["profileImageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "profileImageUrl": profileImageUrl,
      };
}

class Homework {
  Homework({
    required this.id,
    required this.title,
    required this.description,
    required this.offeredAmount,
    required this.fileUrl,
    required this.fileType,
    required this.resolutionTime,
    required this.category,
    required this.observation,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.visible,
  });

  int id;
  String title;
  dynamic description;
  int offeredAmount;
  dynamic fileUrl;
  String fileType;
  DateTime resolutionTime;
  String category;
  bool visible;
  dynamic observation;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  CommentUser user;

  factory Homework.fromJson(Map<String, dynamic> json) => Homework(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        offeredAmount: json["offered_amount"],
        fileUrl: json["fileUrl"],
        fileType: json["fileType"],
        visible: json["visible"],
        resolutionTime: DateTime.parse(json["resolutionTime"]),
        category: json["category"],
        observation: json["observation"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: CommentUser.fromJson(json["user"]),
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
        "observation": observation,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user": user.toJson(),
      };
}

class Offer {
  Offer({
    required this.id,
    required this.priceOffer,
    required this.user,
    required this.status,
    required this.edited,
  });

  int id;
  int priceOffer;
  OfferUser user;
  String status;
  bool edited;
  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        id: json["id"],
        priceOffer: json["priceOffer"],
        user: OfferUser.fromJson(json["user"]),
        status: json["status"],
        edited: json["edited"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "priceOffer": priceOffer,
        "user": user.toJson(),
        "status": status,
        "edited": edited,
      };
}

class OfferUser {
  OfferUser({
    required this.id,
    required this.username,
    this.profileImageUrl,
    /* required this.profileImageUrl, */
  });

  int id;
  String username;
  String? profileImageUrl;

  factory OfferUser.fromJson(Map<String, dynamic> json) => OfferUser(
        id: json["id"],
        username: json["username"],
        profileImageUrl: json["profileImageUrl"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
      };
}
