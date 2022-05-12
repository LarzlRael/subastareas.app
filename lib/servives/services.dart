import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';
import 'package:subastareaspp/enviroments/enviroments_variables.dart'
    as Enviroments;
import 'package:subastareaspp/models/error_model.dart';
import 'package:http_parser/http_parser.dart';

class Services {
  static Future<http.Response?> sendRequest(
      String method, String url, body) async {
    final headers = {
      'Content-Type': 'application/json',
    };
    final URI = Uri.parse('${Enviroments.serverHttpUrl}/$url');
    late http.Response res;
    switch (method) {
      case "GET":
        res = await http.get(URI);
        break;
      case "POST":
        res = await http.post(URI, body: jsonEncode(body), headers: headers);
        break;
      case "PUT":
        res = await http.put(URI, body: jsonEncode(body), headers: headers);
        break;
      case "DELETE":
        res = await http.delete(URI);
    }
    return res;
  }

  static Future<http.Response?> sendRequestWithToken(
      String method, String url, body, String? token) async {
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

  Future sendRequestWithFile(
      File file, String url, String method, token) async {
    final URI = Uri.parse('${Enviroments.serverHttpUrl}/$url');
    final mimeType = mime(file.path)!.split('/');
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final uploadFile = await http.MultipartFile.fromPath(
      'file',
      file.path,
      contentType: MediaType(mimeType[0], mimeType[1]),
    );
    switch (method) {
      case "POST":
        final uploadPostRequest = await http.MultipartRequest(
          'POST',
          URI,
        );
        uploadPostRequest.headers.addAll(headers);
        uploadPostRequest.files.add(uploadFile);
        final streamResponse = await uploadPostRequest.send();
        final resp = await http.Response.fromStream(streamResponse);
        break;
      case "PUT":
        final uploadPostRequest = await http.MultipartRequest(
          'PUT',
          URI,
        );
        uploadPostRequest.headers.addAll(headers);
        uploadPostRequest.files.add(uploadFile);
        final streamResponse = await uploadPostRequest.send();
        final resp = await http.Response.fromStream(streamResponse);
        break;
    }
  }
}
