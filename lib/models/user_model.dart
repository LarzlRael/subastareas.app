part of 'models.dart';

// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.id,
    required this.username,
    required this.name,
    required this.lastName,
    required this.email,
    required this.nickName,
    required this.phone,
    this.profileImageUrl,
    required this.google,
    required this.verify,
    required this.createdAt,
    required this.updatedAt,
    required this.wallet,
    required this.userProfile,
    required this.userRols,
    required this.accessToken,
  });

  int id;
  String username;
  String name;
  String lastName;
  String email;
  String nickName;
  dynamic phone;
  dynamic profileImageUrl;
  bool google;
  bool verify;
  DateTime createdAt;
  DateTime updatedAt;
  Wallet wallet;
  UserProfile userProfile;
  List<String> userRols;
  String accessToken;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        username: json["username"],
        name: json["name"],
        lastName: json["lastName"],
        email: json["email"],
        nickName: json["nickName"],
        phone: json["phone"],
        profileImageUrl: json["profileImageUrl"],
        google: json["google"],
        verify: json["verify"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        wallet: Wallet.fromJson(json["wallet"]),
        userProfile: UserProfile.fromJson(json["userProfile"]),
        userRols: List<String>.from(json["userRols"].map((x) => x)),
        accessToken: json["accessToken"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "name": name,
        "lastName": lastName,
        "email": email,
        "nickName": nickName,
        "phone": phone,
        "profileImageUrl": profileImageUrl,
        "google": google,
        "verify": verify,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "wallet": wallet.toJson(),
        "userProfile": userProfile.toJson(),
        "userRols": List<dynamic>.from(userRols.map((x) => x)),
        "accessToken": accessToken,
      };
}

class UserProfile {
  UserProfile({
    required this.id,
    required this.receiveNotifications,
    required this.isDarkTheme,
    required this.bio,
  });

  int id;
  bool receiveNotifications;
  bool isDarkTheme;
  dynamic bio;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        id: json["id"],
        receiveNotifications: json["receiveNotifications"],
        isDarkTheme: json["isDarkTheme"],
        bio: json["bio"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "receiveNotifications": receiveNotifications,
        "isDarkTheme": isDarkTheme,
        "bio": bio,
      };
}

class Wallet {
  Wallet({
    required this.balanceTotal,
    required this.balanceWithDrawable,
  });

  int balanceTotal;
  int balanceWithDrawable;

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        balanceTotal: json["balanceTotal"],
        balanceWithDrawable: json["balanceWithDrawable"],
      );

  Map<String, dynamic> toJson() => {
        "balanceTotal": balanceTotal,
        "balanceWithDrawable": balanceWithDrawable,
      };
}
