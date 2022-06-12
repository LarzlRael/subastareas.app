part of 'services.dart';

class HomeworkServices {
  final _storage = const FlutterSecureStorage();
  Future<List<HomeworksModel>> getHomeworks() async {
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
    /* category/programacion,algebra/level/Universitario */
    final categorFilter = category.isNotEmpty ? category.join(',') : 'empty';
    final levelFilter = level.isNotEmpty ? level.join(',') : 'empty';
    final homeworkRequest = await Request.sendRequest(
      'GET',
      'homework/category/$categorFilter/level/$levelFilter',
      {},
    );
    /* print(homeworkRequest!.body); */
    final finalData = homeworksModelFromJson(homeworkRequest!.body);
    print(homeworkRequest.body);
    return finalData;
  }
}
