part of 'services.dart';

class SuperviseServices {
  final _storage = const FlutterSecureStorage();

  Future<List<HomeworkToSupervise>> getHomeworksToSupervise() async {
    final homeworkRequest = await Request.sendRequestWithToken(
      RequestType.get,
      'supervisor/homeworksToSupervise/',
      {},
      await _storage.read(key: 'token'),
    );
    final finalData = homeworkToSuperviseFromJson(homeworkRequest!.body);
    return finalData;
  }

  Future<bool> superviseHomework(
      String observation, String status, int idHomework) async {
    final homeworkRequest = await Request.sendRequestWithToken(
      RequestType.post,
      'supervisor/superviseHomework/',
      {
        'observation': observation,
        'status': status,
        'idHomework': idHomework,
      },
      await _storage.read(key: 'token'),
    );
    return validateStatus(homeworkRequest!.statusCode);
  }
}
