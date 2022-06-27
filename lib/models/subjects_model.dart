part of 'models.dart';

List<String> subjectsFromJson(String str) {
  return List<String>.from(json.decode(str).map((x) => x));
}

String subjectsToJson(List<String> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x)));
