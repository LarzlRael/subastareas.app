part of 'models.dart';
// To parse this JSON data, do
//
//     final publicProfile = publicProfileFromJson(jsonString);

// To parse this JSON data, do
//
//     final publicProfile = publicProfileFromJson(jsonString);

PublicProfile publicProfileFromJson(String str) =>
    PublicProfile.fromJson(json.decode(str));

String publicProfileToJson(PublicProfile data) => json.encode(data.toJson());

class PublicProfile {
  PublicProfile({
    required this.id,
    required this.name,
    required this.lastName,
    required this.nickName,
    required this.profileImageUrl,
  });

  int id;
  String name;
  String lastName;
  String nickName;
  dynamic profileImageUrl;

  factory PublicProfile.fromJson(Map<String, dynamic> json) => PublicProfile(
        id: json["id"],
        name: json["name"],
        lastName: json["lastName"],
        nickName: json["nickName"],
        profileImageUrl: json["profileImageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "lastName": lastName,
        "nickName": nickName,
        "profileImageUrl": profileImageUrl,
      };
}
