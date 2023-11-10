part of 'services.dart';

enum RequestType {
  get,
  post,
  put,
  delete,
}

class Request {
  String uri = '${Environment.serverApi}/';
  static Future<http.Response?> sendRequest(
    RequestType method,
    String url, {
    Map<String, String>? body,
  }) async {
    final headers = {
      'Content-Type': 'application/json',
    };
    Uri uri = Uri.parse('${Environment.serverApi}/$url');
    String requestBody = body != null ? jsonEncode(body) : '{}';
    late http.Response res;
    switch (method) {
      case RequestType.get:
        res = await http.get(uri);
        break;
      case RequestType.post:
        res = await http.post(uri, body: requestBody, headers: headers);
        break;
      case RequestType.put:
        res = await http.put(uri, body: requestBody, headers: headers);
        break;
      case RequestType.delete:
        res = await http.delete(uri);
    }
    return res;
  }

  static Future<http.Response?> sendRequestWithToken(
    RequestType method,
    String url, {
    Map<String, dynamic>? body,
  }) async {
    final token = await KeyValueStorageServiceImpl().getValue<String>('token');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final Uri uri = Uri.parse('${Environment.serverApi}/$url');

    String requestBody = body != null ? jsonEncode(body) : '{}';
    late http.Response res;
    switch (method) {
      case RequestType.get:
        res = await http.get(uri, headers: headers);
        break;
      case RequestType.post:
        res = await http.post(uri, body: requestBody, headers: headers);
        break;
      case RequestType.put:
        res = await http.put(uri, body: requestBody, headers: headers);
        break;
      case RequestType.delete:
        res = await http.delete(uri, headers: headers);
    }
    return res;
  }

  static Future<http.Response> sendRequestWithFile(
    RequestType requestType,
    String url,
    String filePath, {
    Map<String, String>? body,
  }) async {
    late http.Response res;
    final token = await KeyValueStorageServiceImpl().getValue<String>('token');
    final Uri uri = Uri.parse('${Environment.serverApi}/$url');

    final mimeType = mime(filePath)!.split('/');
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final uploadFile = await http.MultipartFile.fromPath(
      'file',
      filePath,
      contentType: MediaType(mimeType[0], mimeType[1]),
    );

    final uploadPostRequest = http.MultipartRequest(
      requestType == RequestType.post ? 'POST' : 'PUT',
      uri,
    );
    uploadPostRequest.headers.addAll(headers);
    uploadPostRequest.files.add(uploadFile);
    if (body != null) uploadPostRequest.fields.addAll(body);
    final streamResponse = await uploadPostRequest.send();
    res = await http.Response.fromStream(streamResponse);

    return res;
  }
}
