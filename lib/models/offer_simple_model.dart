part of 'models.dart';
// To parse this JSON data, do
//
//     final offerSimpleModel = offerSimpleModelFromJson(jsonString);

OfferSimpleModel offerSimpleModelFromJson(String str) =>
    OfferSimpleModel.fromJson(json.decode(str));

String offerSimpleModelToJson(OfferSimpleModel data) =>
    json.encode(data.toJson());

class OfferSimpleModel {
  OfferSimpleModel(
      {required this.id,
      required this.priceOffer,
      required this.status,
      required this.user,
      required this.edited,
      this.type});

  int id;
  int priceOffer;
  String status;
  User user;
  bool edited;
  String? type;

  factory OfferSimpleModel.fromJson(Map<String, dynamic> json) =>
      OfferSimpleModel(
        id: json["id"],
        priceOffer: json["priceOffer"],
        status: json["status"],
        edited: json["edited"],
        user: User.fromJson(json["user"]),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "priceOffer": priceOffer,
        "status": status,
        "edited": edited,
        "user": user.toJson(),
        "type": type,
      };
}

class UserOffer {
  UserOffer({
    required this.id,
    required this.username,
    this.profileImageUrl,
  });

  int id;
  String username;
  dynamic profileImageUrl;

  factory UserOffer.fromJson(Map<String, dynamic> json) => UserOffer(
        id: json["id"],
        username: json["username"],
        profileImageUrl: json["profileImageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "profileImageUrl": profileImageUrl,
      };
}
