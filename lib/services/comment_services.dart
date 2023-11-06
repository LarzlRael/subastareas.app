/* part of 'services.dart';

class CommentServices {
  Future<bool> newComment(int idHomework, String commentContent) async {
    final comment = await Request.sendRequestWithToken(
      RequestType.post,
      'comments/newComment/$idHomework',
      body: {'content': commentContent},
    );

    return validateStatus(comment!.statusCode);
  }

  Future<bool> editComment(int idCommnent, String commentContent) async {
    final comment = await Request.sendRequestWithToken(
      RequestType.put,
      'comments/editComment/$idCommnent',
      body: {'content': commentContent},
    );
    return validateStatus(comment!.statusCode);
  }

  Future<bool> deleteComment(int idCommnent) async {
    final comment = await Request.sendRequestWithToken(
      RequestType.delete,
      'comments/deletecomment/$idCommnent',
    );

    return validateStatus(comment!.statusCode);
  }
}
 */
