part of 'services.dart';

class CommentServices {
  final _storage = const FlutterSecureStorage();
  Future<bool> newComment(int idHomework, String commentContent) async {
    final comment = await Request.sendRequestWithToken(
        RequestType.post,
        'comments/newComment/$idHomework',
        {'content': commentContent},
        await _storage.read(key: 'token'));

    return validateStatus(comment!.statusCode);
  }

  Future<bool> editComment(int idCommnent, String commentContent) async {
    final comment = await Request.sendRequestWithToken(
      RequestType.put,
      'comments/editComment/$idCommnent',
      {'content': commentContent},
      await _storage.read(key: 'token'),
    );
    return validateStatus(comment!.statusCode);
  }

  Future<bool> deleteComment(int idCommnent) async {
    final comment = await Request.sendRequestWithToken(
        RequestType.delete,
        'comments/deletecomment/$idCommnent',
        {},
        await _storage.read(key: 'token'));

    return validateStatus(comment!.statusCode);
  }
}
