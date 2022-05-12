import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:subastareaspp/models/user_model.dart';
import 'package:subastareaspp/servives/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:subastareaspp/utils/validation.dart';

class AuthServices with ChangeNotifier {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final _storage = const FlutterSecureStorage();
  Future<bool> login(String email, String password) async {
    /* this.autenticando = true; */

    final data = {
      'username': email,
      'password': password,
      'idDevice': await messaging.getToken() ?? ''
    };

    final resp = await Services.sendRequest('POST', 'auth/signin', data);

    print(resp!.body);
    if (validateStatus(resp.statusCode)) {
      final userModel = userModelFromJson(resp.body);
      await _saveToken(userModel.accessToken);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> logout() async {
    final resp = await Services.sendRequestWithToken(
        'GET',
        'auth/signout/${await messaging.getToken()}',
        null,
        await _storage.read(key: 'token'));
    print(resp!.body);
    return true;
  }

  Future _saveToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }
}
