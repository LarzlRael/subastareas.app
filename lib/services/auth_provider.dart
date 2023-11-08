part of 'services.dart';

class LoginResponse {
  String message;
  int statusCode;
  bool correctCredentials;
  LoginResponse({
    required this.message,
    required this.statusCode,
    required this.correctCredentials,
  });
}

class AuthProvider with ChangeNotifier {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  bool isLogged = false;

  //User model
  late UserModel _user;
  bool _authenticating = false;

  UserModel get user {
    _user.name = _user.name;
    return _user;
  }

  setUser(UserModel value) => _user = value;

//
  bool get getAuthenticating => _authenticating;
  set setAuthenticating(bool valor) {
    _authenticating = valor;
    notifyListeners();
  }

  Future<LoginResponse> login(String email, String password) async {
    setAuthenticating = true;

    final data = {
      'username': email,
      'password': password,
      'idDevice': await messaging.getToken() ?? '',
      'deviceName': await getDeviceInfo(),
    };

    final resp =
        await Request.sendRequest(RequestType.post, 'auth/signIn', body: data);
    setAuthenticating = false;

    if (validateStatus(resp!.statusCode)) {
      setUser(userModelFromJson(resp.body));
      await _saveIdAnToken(user.id.toString(), user.accessToken);
      isLogged = true;
      notifyListeners();
      return LoginResponse(
        message: 'login_ok',
        statusCode: resp.statusCode,
        correctCredentials: validateStatus(resp.statusCode),
      );
    } else {
      final error = errorModelFromJson(resp.body);
      return LoginResponse(
        message: error.message,
        statusCode: resp.statusCode,
        correctCredentials: validateStatus(resp.statusCode),
      );
    }
  }

  Future changePassword(String password, String changePassword) async {
    setAuthenticating = true;

    final data = {
      'password': password,
      'changePassword': changePassword,
    };

    final resp = await Request.sendRequest(
      RequestType.post,
      'auth/changePassword',
      body: data,
    );
    setAuthenticating = false;

    return validateStatus(resp!.statusCode);
  }

  Future<bool> register(
    String username,
    String email,
    String password,
  ) async {
    setAuthenticating = true;

    final data = {
      'username': username,
      'password': password,
      'email': email,
    };

    final resp =
        await Request.sendRequest(RequestType.post, 'auth/signUp', body: data);
    setAuthenticating = false;

    if (validateStatus(resp!.statusCode)) {
      isLogged = true;
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> logout() async {
    await Request.sendRequestWithToken(
      RequestType.get,
      'auth/signOut/${await messaging.getToken()}',
    );

    await clearIdAndToken();
    await _googleSignIn.signOut();

    isLogged = false;
    notifyListeners();
    return true;
  }

  Future _saveIdAnToken(String id, String token) async {
    await KeyValueStorageServiceImpl().setKeyValue<String>('token', token);
    await KeyValueStorageServiceImpl().setKeyValue<String>('id', id);
  }

  Future<bool> renewToken() async {
    final deviceId = await messaging.getToken() ?? '';
    final resp = await Request.sendRequestWithToken(
      RequestType.get,
      'auth/renewToken/$deviceId',
    );

    if (validateStatus(resp!.statusCode)) {
      isLogged = true;
      setUser(userModelFromJson(resp.body));
      await _saveIdAnToken(user.id.toString(), user.accessToken);
      return true;
    } else {
      isLogged = false;
      logout();
      return false;
    }
  }

  Future<void> refreshUser() async {
    await renewToken();
  }

  Future clearIdAndToken() async {
    await KeyValueStorageServiceImpl().removeKey('token');
    await KeyValueStorageServiceImpl().removeKey('id');
  }

  Future updateProfileImage(File file, int idUser) async {
    final resp = await Request.sendRequestWithFile(
      RequestType.put,
      'auth/updateProfileImage/$idUser',
      {},
      file,
    );

    await renewToken();
    return resp.body;
  }

  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  Future<LoginResponse> signInWithGoogle() async {
    final GoogleSignInAccount? account = await _googleSignIn.signIn();

    final googleKey = await account!.authentication;

    final signInWithGoogleEndPoint = Uri(
      scheme: 'https',
      host: Environment.googleHttpsDomain,
      path: '/auth/googleAuth',
    );
    final resp = await http.post(
      signInWithGoogleEndPoint,
      body: {
        'googleToken': googleKey.idToken,
        'f': await messaging.getToken() ?? ''
      },
    );
    if (validateStatus(resp.statusCode)) {
      setUser(userModelFromJson(resp.body));
      await _saveIdAnToken(user.id.toString(), user.accessToken);
      return LoginResponse(
        message: 'login_ok',
        statusCode: resp.statusCode,
        correctCredentials: validateStatus(resp.statusCode),
      );
    } else {
      final error = errorModelFromJson(resp.body);
      return LoginResponse(
        message: error.message,
        statusCode: resp.statusCode,
        correctCredentials: validateStatus(resp.statusCode),
      );
    }
  }

  Future<GoogleSignInAccount?> googleSignOut() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signOut();
      return account;
    } catch (e) {
      print('Error en google SignOut');
      return null;
    }
  }
}