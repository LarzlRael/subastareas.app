part of 'services.dart';

class HomeworkServices {
  final _storage = const FlutterSecureStorage();
  Future<List<HomeworksModel>> gethomeworks(
      List<String> categories, List<String> level) async {
    var homeworkRequest;
    if (categories.isEmpty && level.isEmpty) {
      final homeworkRequest = await Request.sendRequest(
        'GET',
        'homework',
        null,
      );
      /* homeworkRequest.body */
      /* print(homeworkRequest!.body); */
      final finalData = homeworksModelFromJson(homeworkRequest!.body);
      print(homeworkRequest.body);
      return finalData;
    } else {
      return getHomeworksByCategoryAndLevel(categories, level);
    }
  }

  Future<OneHomeworkModel> getOneHomework(int id) async {
    final homeworkRequest = await Request.sendRequest(
      'GET',
      'homework/getonehomework/$id',
      null,
    );
    /* print(homeworkRequest!.body); */
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
    /* print(homeworkRequest!.body); */
    final finalData = homeworksModelFromJson(homeworkRequest!.body);
    return finalData;
  }

  Future<List<HomeworksModel>> getHomeworksByCategoryAndLevel(
      List<String> category, List<String> level) async {
    final homeworkRequest = await Request.sendRequest(
      'GET',
      'homework/${category.map((e) => e)}/fisica/level/${level.map((e) => e)}',
      {},
    );
    /* print(homeworkRequest!.body); */
    final finalData = homeworksModelFromJson(homeworkRequest!.body);
    print(homeworkRequest.body);
    return finalData;
  }
}
