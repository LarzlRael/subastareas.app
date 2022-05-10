import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:subastareaspp/enviroments/enviroments_variables.dart'
    as Enviroments;
import 'package:subastareaspp/models/error_model.dart';

class Services {
  Future<http.Response?> sendRequest(String method, String url, body) async {
    print(body);
    final URI = Uri.parse('${Enviroments.serverHttpUrl}/$url');
    late http.Response res;
    switch (method) {
      case "GET":
        res = await http.get(URI);
        break;
      case "POST":
        res = await http.post(URI, body: jsonEncode(body), headers: {
          'Content-Type': 'application/json',
        });
        break;
      case "PUT":
        res = await http.put(URI,
            body: jsonEncode(body),
            headers: {'Content-type': 'application/json'});
        break;
      case "DELETE":
        res = await http.delete(URI);
    }
  }
}
