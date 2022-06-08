import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:subastareaspp/models/homeworks_model.dart';
import 'package:subastareaspp/models/one_homework_model.dart';
import 'package:subastareaspp/servives/services.dart';
import 'package:subastareaspp/utils/validation.dart';

class CommentServices {
  final _storage = const FlutterSecureStorage();
  Future<bool> newComment(int idCommnent, String commentContent) async {
    final comment = await Services.sendRequestWithToken(
        'POST',
        'comments/newComment/$idCommnent',
        {'content': commentContent},
        await _storage.read(key: 'token'));

    return validateStatus(comment!.statusCode);
  }

  Future<bool> editComment(int idCommnent, String commentContent) async {
    final comment = await Services.sendRequestWithToken(
      'PUT',
      'comments/editComment/$idCommnent',
      {'content': commentContent},
      await _storage.read(key: 'token'),
    );
    /* homeworkRequest.body */
    return validateStatus(comment!.statusCode);
  }

  Future<bool> deleteComment(int idCommnent) async {
    final comment = await Services.sendRequestWithToken(
        'DELETE',
        'comments/deletecomment/$idCommnent',
        {},
        await _storage.read(key: 'token'));
    /* homeworkRequest.body */
    return validateStatus(comment!.statusCode);
  }
}
