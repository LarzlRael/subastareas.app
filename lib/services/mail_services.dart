part of 'services.dart';

class MailServices {
  final _storage = const FlutterSecureStorage();

  Future requestPasswordChange(String email) async {
    final requestPasswordChange = await Request.sendRequest(
      RequestType.get,
      'auth/requestPasswordChange/$email',
      {},
    );

    return validateStatus(requestPasswordChange!.statusCode);
  }

  Future<bool> requestEmailVerification(String email) async {
    final requestEmailVerification = await Request.sendRequest(
      RequestType.get,
      'auth/sendEmailVerification/$email',
      {},
    );
    return validateStatus(requestEmailVerification!.statusCode);
  }
}
