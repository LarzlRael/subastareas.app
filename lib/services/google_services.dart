part of 'services.dart';

class GoogleSignInServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final _storage = const FlutterSecureStorage();
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();

      final googleKey = await account!.authentication;

      final signInWithGoogleEndPont = Uri(
        scheme: 'https',
        host: Environment.googleHttpsDomain,
        path: '/auth/googleAuth',
      );
      final session = await http.post(
        signInWithGoogleEndPont,
        body: {
          'googleToken': googleKey.idToken,
        },
      );

      final user = userModelFromJson(session.body);
      await _storage.write(key: 'token', value: user.accessToken);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<GoogleSignInAccount?> signOut() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signOut();
      return account;
    } catch (e) {
      print('Error en google SignOut');
      return null;
    }
  }
}
