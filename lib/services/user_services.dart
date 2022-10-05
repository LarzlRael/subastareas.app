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
}
