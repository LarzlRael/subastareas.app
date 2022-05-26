import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:subastareaspp/models/user_model.dart';
import 'package:subastareaspp/servives/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:subastareaspp/utils/validation.dart';

class AuthServices with ChangeNotifier {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  bool isLogged = false;
  final _storage = const FlutterSecureStorage();
  late UserModel _usuario;

  UserModel get usuario {
    _usuario.name = _usuario.name;
    return _usuario;
  }

  setUsuario(UserModel value) => _usuario = value;

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
      setUsuario(userModelFromJson(resp.body));
      await _saveIdAnToken(usuario.id.toString(), usuario.accessToken);
      isLogged = true;
      notifyListeners();
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

    await clearIdAndToken();
    isLogged = false;
    notifyListeners();
    return true;
  }

  Future _saveIdAnToken(String id, String token) async {
    await _storage.write(key: 'token', value: token);
    await _storage.write(key: 'id', value: id);
  }

  Future<bool> isLoggenIn() async {
    final resp = await Services.sendRequestWithToken(
      'GET',
      'auth/renewtoken',
      null,
      await _storage.read(key: 'token'),
    );

    if (resp?.statusCode == 200) {
      isLogged = true;
      setUsuario(userModelFromJson(resp!.body));
      await _saveIdAnToken(usuario.id.toString(), usuario.accessToken);
      return true;
    } else {
      isLogged = false;
      logout();
      return false;
    }
  }

  Future clearIdAndToken() async {
    await _storage.delete(key: 'token');
    await _storage.delete(key: 'id');
  }

  Future<String> getCurrentToken() async {
    return await _storage.read(key: 'token') ?? '';
  }
}
