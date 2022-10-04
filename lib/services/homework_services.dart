part of 'services.dart';

class HomeworkServices {
  final _storage = const FlutterSecureStorage();
  Future<List<HomeworksModel>> getHomeworks() async {
    final homeworkRequest = await Request.sendRequest(
      'GET',
      'homework',
      null,
    );

    final finalData = homeworksModelFromJson(homeworkRequest!.body);
    return finalData;
  }

  Future<OneHomeworkModel> getOneHomework(int id) async {
    final homeworkRequest = await Request.sendRequest(
      'GET',
      'homework/getonehomework/$id',
      null,
    );
    final finalData = oneHomeworkModelFromJson(homeworkRequest!.body);
    return finalData;
  }

  Future<List<HomeworksModel>> getHomeworksByUser() async {
    final homeworkRequest = await Request.sendRequestWithToken(
      'GET',
      'homework/homeworksbyuser',
      {},
      await _storage.read(key: 'token'),
    );

    final finalData = homeworksModelFromJson(homeworkRequest!.body);
    return finalData;
  }

  Future<List<HomeworksModel>> getHomeworksByCategoryAndLevel(
      List<String> category) async {
    /* category/programacion,algebra/level/Universitario */
    final categorFilter = category.isNotEmpty ? category.join(',') : 'empty';
    /* final levelFilter = level.isNotEmpty ? level.join(',') : 'empty'; */
    final homeworkRequest = await Request.sendRequest(
      'GET',
      'homework/category/$categorFilter',
      {},
    );

    final finalData = homeworksModelFromJson(homeworkRequest!.body);

    return finalData;
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

  Future<List<NotificationModel>> getUserNotifications() async {
    final homeworkRequest = await Request.sendRequestWithToken(
      'GET',
      'devices/getUserNotifications',
      {},
      await _storage.read(key: 'token'),
    );

    final finalData = notificationModelFromJson(homeworkRequest!.body);

    return finalData;
  }

  Future clearNotifications() async {
    final homeworkRequest = await Request.sendRequestWithToken(
      'GET',
      'devices/clearnotificated',
      {},
      await _storage.read(key: 'token'),
    );

    return (homeworkRequest!.statusCode);
    /* homeworkRequest!.body; */
  }

  Future seeNotification(int idNotification) async {
    final homeworkRequest = await Request.sendRequestWithToken(
      'PUT',
      'devices/seeNotification/$idNotification',
      {},
      await _storage.read(key: 'token'),
    );
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
