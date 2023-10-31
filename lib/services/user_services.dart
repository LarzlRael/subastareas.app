part of 'services.dart';

class UserServices {
  Future<PublicProfile> getPublicProfile(int idUser) async {
    final resp = await Request.sendRequestWithToken(
      RequestType.get,
      'auth/viewPublicProfile/$idUser',
    );

    return publicProfileFromJson(resp!.body);
  }

  Future<bool> changeUserPreferences(
      int idProfileUser, bool isDarkTheme, bool sendNotifications) async {
    final resp = await Request.sendRequestWithToken(
      RequestType.post,
      'userProfile/changePreferences',
      body: {
        'id': idProfileUser,
        'isDarkTheme': isDarkTheme,
        'notifications': sendNotifications,
      },
    );

    return validateStatus(resp!.statusCode);
  }
}
