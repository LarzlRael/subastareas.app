part of 'services.dart';

class SuperviseServices {
  Future<List<HomeworkToSupervise>> getHomeworksToSupervise() async {
    final homeworkRequest = await Request.sendRequestWithToken(
      RequestType.get,
      'supervisor/homeworksToSupervise/',
    );
    final finalData = homeworkToSuperviseFromJson(homeworkRequest!.body);
    return finalData;
  }

  Future<bool> superviseHomework(
      int idHomework, String observation, String status) async {
    final homeworkRequest = await Request.sendRequestWithToken(
      RequestType.post,
      'supervisor/superviseHomework/',
      body: {
        'observation': observation,
        'status': status,
        'idHomework': idHomework,
      },
    );
    return validateStatus(homeworkRequest!.statusCode);
  }
}
