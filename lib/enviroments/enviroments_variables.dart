import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:subastareaspp/utils/utils.dart';

/* const baseURL = 'https://subastareas2.herokuapp.com'; */
/* const baseURL = 'http://192.168.0.106:3000';
const serverHttpUrl = baseURL;
final googleHttpsDomain = getUrlResource(baseURL); */

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
