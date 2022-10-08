part of 'models.dart';

PublicProfile publicProfileFromJson(String str) =>
    PublicProfile.fromJson(json.decode(str));

String publicProfileToJson(PublicProfile data) => json.encode(data.toJson());

class PublicProfile {
  PublicProfile({
    required this.id,
    required this.name,
    required this.lastName,
    required this.nickName,
    required this.solvedHomeworks,
    required this.reputation,
    this.profileImageUrl,
    this.bio,
  });

  int id;
  String name;
  String lastName;
  String nickName;
  dynamic profileImageUrl;
  dynamic bio;
  int solvedHomeworks;
  int reputation;

  factory PublicProfile.fromJson(Map<String, dynamic> json) => PublicProfile(
        id: json["id"],
        name: json["name"],
        lastName: json["lastName"],
        nickName: json["nickName"],
        profileImageUrl: json["profileImageUrl"],
        bio: json["bio"],
        solvedHomeworks: json["solvedHomeworks"],
        reputation: json["reputation"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "lastName": lastName,
        "nickName": nickName,
        "profileImageUrl": profileImageUrl,
        "bio": bio,
        "solvedHomeworks": solvedHomeworks,
        "reputation": reputation,
      };
}
