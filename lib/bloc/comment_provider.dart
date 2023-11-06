import 'package:flutter/material.dart';
import 'package:subastareaspp/services/services.dart';
import 'package:subastareaspp/utils/utils.dart';

import '../models/models.dart';

class CommentProvider with ChangeNotifier {
  CommentState state = CommentState.initial();

  getComments(int idHomework) async {
    state = state.copyWith(isLoading: true);
    final comments = await Request.sendRequestWithToken(
      RequestType.get,
      'comments/getComments/$idHomework',
    );
    final commentsConvert = commentsFromJson(comments!.body);
    state = state.copyWith(
      comments: commentsConvert,
      isLoading: false,
    );
    notifyListeners();
  }

  Future<Comment> newComment(int idHomework, String commentContent) async {
    state = state.copyWith(isLoading: true);
    final comment = await Request.sendRequestWithToken(
      RequestType.post,
      'comments/newComment/$idHomework',
      body: {'content': commentContent},
    );

    final commentConvert = commentModelFromJson(comment!.body);
    state = state.copyWith(
      comments: [
        commentConvert,
        ...state.comments,
      ],
      isLoading: false,
    );
    notifyListeners();
    return commentConvert;
  }

  Future<bool> edirOrNewComment(
    int idHomework,
    String content, {
    int? idComment,
  }) async {
    try {
      final commnentRes = idComment == null
          ? await newComment(idHomework, content)
          : await editComment(idComment, content);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Comment> editComment(int idComment, String commentContent) async {
    final comment = await Request.sendRequestWithToken(
      RequestType.put,
      'comments/editComment/$idComment',
      body: {'content': commentContent},
    );
    final commentConvert = commentModelFromJson(comment!.body);
    state = state.copyWith(
      comments: state.comments
          .map((existingComment) => existingComment.id == idComment
              ? commentConvert
              : existingComment)
          .toList(),
    );

    return commentConvert;
  }

  Future<bool> deleteComment(int idCommnent) async {
    final comment = await Request.sendRequestWithToken(
      RequestType.delete,
      'comments/deletecomment/$idCommnent',
    );

    if (validateStatus(comment?.statusCode)) {
      state = state.copyWith(
        comments: [
          ...state.comments
              .where((element) => element.id != idCommnent)
              .toList(),
        ],
      );
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }
}

class CommentState {
  final List<Comment> comments;
  final bool isLoading;

  CommentState({required this.comments, required this.isLoading});

  factory CommentState.initial() => CommentState(
        comments: [],
        isLoading: false,
      );

  CommentState copyWith({List<Comment>? comments, bool? isLoading}) =>
      CommentState(
        comments: comments ?? this.comments,
        isLoading: isLoading ?? this.isLoading,
      );
}
