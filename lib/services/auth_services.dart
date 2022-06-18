part of 'services.dart';

class AuthServices with ChangeNotifier {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  bool isLogged = false;
  final _storage = const FlutterSecureStorage();
  late UserModel _user;

  UserModel get user {
    _user.name = _user.name;
    return _user;
  }

  setUsuario(UserModel value) => _user = value;

  Future<bool> login(String email, String password) async {
    /* this.autenticando = true; */

    final data = {
      'username': email,
      'password': password,
      'idDevice': await messaging.getToken() ?? ''
    };

    final resp = await Request.sendRequest('POST', 'auth/signin', data);

    if (validateStatus(resp!.statusCode)) {
      /* print(userModelFromJson(resp.body).accessToken); */
      setUsuario(userModelFromJson(resp.body));
      await _saveIdAnToken(user.id.toString(), user.accessToken);
      isLogged = true;
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> register(
    String username,
    String email,
    String password,
  ) async {
    /* this.autenticando = true; */

    final data = {
      'username': email,
      'password': password,
      'email': email,
    };

    final resp = await Request.sendRequest('POST', 'auth/signup', data);

    print(resp!.body);
    if (validateStatus(resp.statusCode)) {
      /* setUsuario(userModelFromJson(resp.body));
      await _saveIdAnToken(usuario.id.toString(), usuario.accessToken); */
      isLogged = true;
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> logout() async {
    await Request.sendRequestWithToken(
        'GET',
        'auth/signout/${await messaging.getToken()}',
        {},
        await _storage.read(key: 'token'));

    await clearIdAndToken();
    isLogged = false;
    /* setUsuario(null); */
    notifyListeners();
    return true;
  }

  Future _saveIdAnToken(String id, String token) async {
    await _storage.write(key: 'token', value: token);
    await _storage.write(key: 'id', value: id);
  }

  Future<bool> isLoggenIn() async {
    final resp = await Request.sendRequestWithToken(
      'GET',
      'auth/renewtoken',
      {},
      await _storage.read(key: 'token'),
    );

    if (resp?.statusCode == 200) {
      isLogged = true;
      setUsuario(userModelFromJson(resp!.body));
      await _saveIdAnToken(user.id.toString(), user.accessToken);
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

  Future updateProfileImage(File file, int idUser) async {
    final resp = await Request.sendRequestWithFile(
        file,
        'auth/updateprofileimage/$idUser',
        'PUT',
        {},
        await _storage.read(key: 'token') ?? '');
    print(resp.body);
    await isLoggenIn();
    return resp.body;
  }
}
