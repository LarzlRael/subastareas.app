part of 'models.dart';
// To parse this JSON data, do
//
//     final offerSimpleModel = offerSimpleModelFromJson(jsonString);

OfferSimpleModel offerSimpleModelFromJson(String str) =>
    OfferSimpleModel.fromJson(json.decode(str));

String offerSimpleModelToJson(OfferSimpleModel data) =>
    json.encode(data.toJson());

class OfferSimpleModel {
  OfferSimpleModel({
    required this.id,
    required this.priceOffer,
    required this.status,
    required this.user,
  });

  int id;
  int priceOffer;
  String status;
  User user;

  factory OfferSimpleModel.fromJson(Map<String, dynamic> json) =>
      OfferSimpleModel(
        id: json["id"],
        priceOffer: json["priceOffer"],
        status: json["status"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "priceOffer": priceOffer,
        "status": status,
        "user": user.toJson(),
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
