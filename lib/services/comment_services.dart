part of 'services.dart';

class CommentServices {
  final _storage = const FlutterSecureStorage();
  Future<bool> newComment(int idCommnent, String commentContent) async {
    final comment = await Request.sendRequestWithToken(
        'POST',
        'comments/newComment/$idCommnent',
        {'content': commentContent},
        await _storage.read(key: 'token'));

    return validateStatus(comment!.statusCode);
  }

  Future<bool> editComment(int idCommnent, String commentContent) async {
    final comment = await Request.sendRequestWithToken(
      'PUT',
      'comments/editComment/$idCommnent',
      {'content': commentContent},
      await _storage.read(key: 'token'),
    );
    return validateStatus(comment!.statusCode);
  }

  Future<bool> deleteComment(int idCommnent) async {
    final comment = await Request.sendRequestWithToken(
        'DELETE',
        'comments/deletecomment/$idCommnent',
        {},
        await _storage.read(key: 'token'));

    return validateStatus(comment!.statusCode);
  }
}
