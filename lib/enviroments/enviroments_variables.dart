import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static initEnviroment() async {
    await dotenv.load(
      fileName: '.env',
    );
  }

  static String serverApi =
      dotenv.env['SERVER_API'] ?? 'No está configurado el SERVER_API';

  static String googleHttpsDomain =
      dotenv.env['SERVER_API'] ?? 'No está configurado el SERVER_API';
}
