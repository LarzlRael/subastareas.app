part of 'services.dart';

class GoogleSignInServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  static GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  static Future<String> signiWithGoogle() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();

      final googleKey = await account!.authentication;

      print('token de google : ');
      print(googleKey.idToken);
      return googleKey.idToken!;
      // TODO idTOken form google
      /*  final Uri signInWithGoogleEndPont = Uri(
        scheme: 'https',
        host: 'walletneobackend.herokuapp.com',
        path: 'auth/googleAuth',
      );
      final session = await http.post(
        signInWithGoogleEndPont,
        body: {
          'googleToken': googleKey.idToken,
          'idDevice': await messaging.getToken() ?? ''

        },
      );

      print('==== Backend ====');
      print(session.body); */

      /* return session.body; */
    } catch (e) {
      print(e);
      return 'Error en google SignIn';
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
