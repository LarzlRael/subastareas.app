part of 'services.dart';

enum RequestTypeDIO {
  get,
  post,
  put,
  delete,
}

class RequestDio {
  String uri = '${Environment.serverApi}/';
  static Future<http.Response?> sendRequest(
      RequestType method, String url, Map<String, String>? body) async {
    final headers = {
      'Content-Type': 'application/json',
    };
    Uri uri = Uri.parse('${Environment.serverApi}/$url');
    late http.Response res;
    switch (method) {
      case RequestType.get:
        res = await http.get(uri);
        break;
      case RequestType.post:
        res = await http.post(uri, body: jsonEncode(body), headers: headers);
        break;
      case RequestType.put:
        res = await http.put(uri, body: jsonEncode(body), headers: headers);
        break;
      case RequestType.delete:
        res = await http.delete(uri);
    }
    return res;
  }

  static Future<Response?> sendRequestWithToken(RequestType method, String url,
      Map<String, dynamic> body, String? token) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final String urlBase = '${Environment.serverApi}/$url';
    late Response res;

    final dio = Dio();
    switch (method) {
      case RequestType.get:
        res = await dio.get(urlBase, options: Options(headers: headers));
        break;
      case RequestType.post:
        res = await dio.post(urlBase,
            data: jsonEncode(body), options: Options(headers: headers));
        break;
      case RequestType.put:
        res = await dio.put(urlBase,
            data: jsonEncode(body), options: Options(headers: headers));
        break;
      case RequestType.delete:
        res = await dio.delete(urlBase, options: Options(headers: headers));
    }
    return res;
  }
}
