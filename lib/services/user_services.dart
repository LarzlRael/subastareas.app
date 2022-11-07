part of 'services.dart';

class UserServices {
  final _storage = const FlutterSecureStorage();

  Future<PublicProfile> getPublicProfile(int idUser) async {
    final resp = await Request.sendRequestWithToken(
      'GET',
      'auth/viewPublicProfile/$idUser',
      {},
      await _storage.read(key: 'token'),
    );

    return publicProfileFromJson(resp!.body);
  }

  Future<bool> changeUserPreferences(
      int idProfileUser, bool isDarkTheme, bool sendNotifications) async {
    final resp = await Request.sendRequestWithToken(
      'POST',
      'userProfile/changePreferences',
      {
        'id': idProfileUser,
        'isDarkTheme': isDarkTheme,
        'notifications': sendNotifications,
      },
      await _storage.read(key: 'token'),
    );

    return validateStatus(resp!.statusCode);
  }
}
