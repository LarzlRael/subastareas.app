part of 'services.dart';

class SuperviseServices {
  final _storage = const FlutterSecureStorage();

  Future<List<HomeworkToSupervise>> getHomeworksToSupervise() async {
    final homeworkRequest = await Request.sendRequestWithToken(
      'GET',
      'supervisor/homeworksToSupervise/',
      {},
      await _storage.read(key: 'token'),
    );
    final finalData = homeworkToSuperviseFromJson(homeworkRequest!.body);
    return finalData;
  }
}
