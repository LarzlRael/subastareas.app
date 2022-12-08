part of 'services.dart';

class HomeworkServices {
  final _storage = const FlutterSecureStorage();
  Future<List<HomeworksModel>> getHomeworks() async {
    final homeworkRequest = await Request.sendRequest(
      RequestType.get,
      'homework',
      null,
    );

    return homeworksModelFromJson(homeworkRequest!.body);
  }

  Future<List<HomeworksModel>> getSearchedHomeworks(String querySearch) async {
    if (querySearch.isEmpty) {
      return await getHomeworks();
    }
    final homeworkRequest = await Request.sendRequest(
      RequestType.get,
      'homework/findHomework/$querySearch',
      null,
    );

    return homeworksModelFromJson(homeworkRequest!.body);
  }

  Future<OneHomeworkModel> getOneHomework(int id) async {
    final homeworkRequest = await Request.sendRequest(
      RequestType.get,
      'homework/getOneHomework/$id',
      null,
    );
    return oneHomeworkModelFromJson(homeworkRequest!.body);
  }

  Future<List<HomeworksModel>> getHomeworksByUser() async {
    final homeworkRequest = await Request.sendRequestWithToken(
      RequestType.get,
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
      RequestType.get,
      'homework/category/$categoryFilter',
      {},
    );
    return homeworksModelFromJson(homeworkRequest!.body);
  }

  Future<List<String>> getSubjectAndLevels() async {
    final homeworkRequest = await Request.sendRequest(
      RequestType.get,
      'homework/getSubjectsList',
      {},
    );
    final finalData = subjectsFromJson(homeworkRequest!.body);
    return finalData;
  }

  Future clearNotifications() async {
    final homeworkRequest = await Request.sendRequestWithToken(
      RequestType.get,
      'devices/clearNotificated',
      {},
      await _storage.read(key: 'token'),
    );
    return (homeworkRequest!.statusCode);
    /* homeworkRequest!.body; */
  }

  /* Future<bool> uploadHomeworkOnlyText(body, int idHomework) async {
    final homeworkRequest = await Request.sendRequestWithToken(
      idHomework == 0 ? 'POST' : 'PUT',
      idHomework == 0
          ? 'homework/create'
          : 'homework/updateHomework/$idHomework',
      body,
      await _storage.read(key: 'token'),
    );

    return validateStatus(homeworkRequest!.statusCode);
  } */

  Future<bool> uploadHomework(
      Map<String, String> body, File? file, int idHomework) async {
    if (file != null) {
      final homeworkUploadWithFile = await Request.sendRequestWithFile(
        RequestType.post,
        'homework/create',
        body,
        file,
        await _storage.read(key: 'token') ?? '',
      );
      return validateStatus(homeworkUploadWithFile.statusCode);
    } else {
      final homeworkRequest = await Request.sendRequestWithToken(
        idHomework == 0 ? RequestType.post : RequestType.put,
        idHomework == 0
            ? 'homework/create'
            : 'homework/updateHomework/$idHomework',
        body,
        await _storage.read(key: 'token'),
      );

      return validateStatus(homeworkRequest!.statusCode);
    }
  }

  Future deleteHomework(int idHomework) async {
    return Request.sendRequestWithToken(
      RequestType.delete,
      'homework/deleteHomework/$idHomework',
      {},
      await _storage.read(key: 'token'),
    );
  }

  Future<bool> updateHomework(
      Map<String, String> body, File? file, int idHomework) async {
    if (file == null) {
      final homeworkUploadWithFile = await Request.sendRequestWithToken(
        RequestType.put,
        'homework/updateHomework/$idHomework',
        body,
        await _storage.read(key: 'token') ?? '',
      );
      return validateStatus(homeworkUploadWithFile!.statusCode);
    } else {
      final homeworkUploadWithFile = await Request.sendRequestWithFile(
        RequestType.put,
        'homework/updateHomework/$idHomework',
        body,
        file,
        await _storage.read(key: 'token') ?? '',
      );
      return validateStatus(homeworkUploadWithFile.statusCode);
    }
    /* final homeworkUploadWithFile = await Request.sendRequestWithFile(
      'POST',
      'updateHomework/$idHomework',
      body,
      file,
      await _storage.read(key: 'token') ?? '',
    );
    return validateStatus(homeworkUploadWithFile.statusCode); */
  }
}
