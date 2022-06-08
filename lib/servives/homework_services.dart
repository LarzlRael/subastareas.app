import 'package:subastareaspp/models/homeworks_model.dart';
import 'package:subastareaspp/models/one_homework_model.dart';
import 'package:subastareaspp/servives/services.dart';

class HomeworkServices {
  Future<List<HomeworksModel>> gethomeworks() async {
    final homeworkRequest = await Services.sendRequest(
      'GET',
      'homework',
      null,
    );
    /* homeworkRequest.body */
    /* print(homeworkRequest!.body); */
    final finalData = homeworksModelFromJson(homeworkRequest!.body);
    return finalData;
  }

  Future<OneHomeworkModel> getOneHomework(int id) async {
    final homeworkRequest = await Services.sendRequest(
      'GET',
      'homework/getonehomework/$id',
      null,
    );

    final finalData = oneHomeworkModelFromJson(homeworkRequest!.body);
    return finalData;
  }
}
