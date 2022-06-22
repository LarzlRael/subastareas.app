part of 'services.dart';

class Request {
  String uri = '${Enviroments.serverHttpUrl}/';
  static Future<http.Response?> sendRequest(
      String method, String url, Map<String, String>? body) async {
    final headers = {
      'Content-Type': 'application/json',
    };
    Uri uri = Uri.parse('${Enviroments.serverHttpUrl}/$url');
    late http.Response res;
    switch (method) {
      case "GET":
        res = await http.get(uri);
        break;
      case "POST":
        res = await http.post(uri, body: jsonEncode(body), headers: headers);
        break;
      case "PUT":
        res = await http.put(uri, body: jsonEncode(body), headers: headers);
        break;
      case "DELETE":
        res = await http.delete(uri);
    }
    return res;
  }

  static Future<http.Response?> sendRequestWithToken(String method, String url,
      Map<String, dynamic> body, String? token) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final Uri uri = Uri.parse('${Enviroments.serverHttpUrl}/$url');
    late http.Response res;
    switch (method) {
      case "GET":
        res = await http.get(uri, headers: headers);
        break;
      case "POST":
        res = await http.post(uri, body: jsonEncode(body), headers: headers);
        break;
      case "PUT":
        res = await http.put(uri, body: jsonEncode(body), headers: headers);
        break;
      case "DELETE":
        res = await http.delete(uri, headers: headers);
    }
    return res;
  }

  static Future<http.Response> sendRequestWithFile(
    File file,
    String url,
    String method,
    Map<String, String> otherFields,
    String token,
  ) async {
    late http.Response res;
    final Uri uri = Uri.parse('${Enviroments.serverHttpUrl}/$url');
    final mimeType = mime(file.path)!.split('/');
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final uploadFile = await http.MultipartFile.fromPath(
      'file',
      file.path,
      contentType: MediaType(mimeType[0], mimeType[1]),
    );

    final uploadPostRequest = http.MultipartRequest(
      method,
      uri,
    );
    uploadPostRequest.headers.addAll(headers);
    uploadPostRequest.files.add(uploadFile);
    uploadPostRequest.fields.addAll(otherFields);
    final streamResponse = await uploadPostRequest.send();
    res = await http.Response.fromStream(streamResponse);

    return res;
  }
}
