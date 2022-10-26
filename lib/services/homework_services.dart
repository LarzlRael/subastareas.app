part of 'services.dart';

class HomeworkServices {
  final _storage = const FlutterSecureStorage();
  Future<List<HomeworksModel>> getHomeworks() async {
    final homeworkRequest = await Request.sendRequest(
      'GET',
      'homework',
      null,
    );

    return homeworksModelFromJson(homeworkRequest!.body);
  }

  Future<OneHomeworkModel> getOneHomework(int id) async {
    final homeworkRequest = await Request.sendRequest(
      'GET',
      'homework/getOneHomework/$id',
      null,
    );
    return oneHomeworkModelFromJson(homeworkRequest!.body);
  }

  Future<List<HomeworksModel>> getHomeworksByUser() async {
    final homeworkRequest = await Request.sendRequestWithToken(
      'GET',
      'homework/homeworksByUser',
      {},
      await _storage.read(key: 'token'),
    );

    return homeworksModelFromJson(homeworkRequest!.body);
  }

  Future<List<HomeworksModel>> getHomeworksByCategoryAndLevel(
      List<String> category) async {
    /* category/programacion,algebra/level/Universitario */
    final categoryFilter = category.isNotEmpty ? category.join(',') : 'empty';
    /* final levelFilter = level.isNotEmpty ? level.join(',') : 'empty'; */
    final homeworkRequest = await Request.sendRequest(
      'GET',
      'homework/category/$categoryFilter',
      {},
    );

    return homeworksModelFromJson(homeworkRequest!.body);
  }

  Future<List<String>> getSubjectAndLevels() async {
    final homeworkRequest = await Request.sendRequest(
      'GET',
      'homework/getSubjectsList',
      {},
    );
    final finalData = subjectsFromJson(homeworkRequest!.body);
    return finalData;
  }

  Future clearNotifications() async {
    final homeworkRequest = await Request.sendRequestWithToken(
      'GET',
      'devices/clearNotificated',
      {},
      await _storage.read(key: 'token'),
    );
    return (homeworkRequest!.statusCode);
    /* homeworkRequest!.body; */
  }

  Future<bool> uploadHomeworkOnlyText(body, int idHomework) async {
    final homeworkRequest = await Request.sendRequestWithToken(
      idHomework == 0 ? 'POST' : 'PUT',
      idHomework == 0
          ? 'homework/create'
          : 'homework/updateHomework/$idHomework',
      body,
      await _storage.read(key: 'token'),
    );

    return validateStatus(homeworkRequest!.statusCode);
  }

  Future<bool> uploadHomeworkWithFile(
      Map<String, String> body, File file) async {
    final homeworkUploadWithFile = await Request.sendRequestWithFile(
      'POST',
      'homework/create',
      body,
      file,
      await _storage.read(key: 'token') ?? '',
    );
    return validateStatus(homeworkUploadWithFile.statusCode);
  }
}
