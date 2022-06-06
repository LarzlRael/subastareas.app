import 'package:subastareaspp/models/homework_model.dart';
import 'package:subastareaspp/models/one_homework_model.dart';
import 'package:subastareaspp/servives/services.dart';

class HomeworkServices {
  Future<List<HomeworkModel>> gethomeworks() async {
    final homeworkRequest = await Services.sendRequestWithToken(
        'GET',
        'homework',
        null,
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImdhdG9tb24iLCJpYXQiOjE2NTQ0NjU1NDUsImV4cCI6MTY1NDU1MTk0NX0.aNKXtd_RnbVYCdqqHgqCangNpr3I7M1zfP0XX1j6sa0');
    /* homeworkRequest.body */
    print(homeworkRequest!.body);
    final finalData = homeworkModelFromJson(homeworkRequest.body);
    return finalData;
  }

  Future<OneHomeworkModel> getOneHomework(int id) async {
    final homeworkRequest = await Services.sendRequestWithToken(
        'GET',
        'homework/getonehomework/$id',
        null,
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImdhdG9tb24iLCJpYXQiOjE2NTQ0NjU1NDUsImV4cCI6MTY1NDU1MTk0NX0.aNKXtd_RnbVYCdqqHgqCangNpr3I7M1zfP0XX1j6sa0');
    /* homeworkRequest.body */
    print(homeworkRequest!.body);
    final finalData = oneHomeworkModelFromJson(homeworkRequest.body);
    return finalData;
  }
}
