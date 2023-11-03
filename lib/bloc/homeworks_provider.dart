import 'dart:async';

import 'package:flutter/material.dart';
import 'package:subastareaspp/models/models.dart';
import 'package:subastareaspp/services/services.dart';

class HomeworksProvider with ChangeNotifier {
  CommentServices commentService = CommentServices();
  OffersServices offersServices = OffersServices();

  HomeworksState state = HomeworksState.initial();

  getHomeworks() async {
    state = state.copyWith(isLoadingHomeworks: true);
    final homeworkRequest = await Request.sendRequest(
      RequestType.get,
      'homework',
    );
    state = state.copyWith(
      homeworks: homeworksModelFromJson(homeworkRequest!.body),
      isLoadingHomeworks: false,
    );
    notifyListeners();
  }

  getOneHomework(int id) async {
    state = state.copyWith(isLoadingSelected: true);
    final homeworkRequest = await Request.sendRequest(
      RequestType.get,
      'homework/getOneHomework/$id',
    );
    state = state.copyWith(
      isLoadingSelected: false,
      selectedHomework: oneHomeworkModelFromJson(homeworkRequest!.body),
    );
    notifyListeners();
  }

  deleteHomework(int idHomework) async {
    Request.sendRequestWithToken(
      RequestType.delete,
      'homework/deleteHomework/$idHomework',
    );

    state = state.copyWith(
      selectedHomework: null,
    );
  }

  deleteComment(int idComment, int idHomework) async {
    await commentService.deleteComment(idComment);
  }

  Future<bool> edirOrNewComment(
    int idHomework,
    String content, {
    int? idComment,
  }) async {
    final commnentRes = idComment == null
        ? await commentService.newComment(idHomework, content)
        : await commentService.editComment(idComment, content);
    await getOneHomework(idHomework);

    return commnentRes;
  }

  Future<OfferSimpleModel> makeOrEditOffer(
      bool edit, int idHomework, int offer, int idOffer) async {
    final makeOrEditOffer =
        await offersServices.makeOrEditOffer(edit, idHomework, offer, idOffer);
    await getOneHomework(idHomework);
    return makeOrEditOffer;
  }

  getSearchedHomeworks(String query) async {
    if (query.isEmpty) {
      return await getHomeworks();
    }
    final homeworkRequest = await Request.sendRequest(
      RequestType.get,
      'homework/findHomework/$query',
    );

    state.copyWith(
      homeworks: homeworksModelFromJson(homeworkRequest!.body),
    );
    notifyListeners();
  }

  getHomeworksByCategory(List<String> category) async {
    final categoryFilter = category.isNotEmpty ? category.join(',') : 'empty';
    /* final levelFilter = level.isNotEmpty ? level.join(',') : 'empty'; */
    final homeworkRequest = await Request.sendRequest(
      RequestType.get,
      'homework/category/$categoryFilter',
    );
    state.copyWith(
      homeworks: homeworksModelFromJson(homeworkRequest!.body),
    );
    notifyListeners();
  }

  Future<OfferSimpleModel> deleteOffer(int idHomework, int idOffer) async {
    final offerDeleted = await offersServices.deleteOffer(idOffer);
    await getOneHomework(idHomework);
    return offerDeleted;
  }
}

class HomeworksState {
  final List<HomeworksModel> homeworks;
  final bool isLoadingSelected;
  final bool isLoadingHomeworks;

  final OneHomeworkModel? selectedHomework;

  HomeworksState({
    required this.homeworks,
    required this.isLoadingSelected,
    required this.isLoadingHomeworks,
    this.selectedHomework,
  });

  factory HomeworksState.initial() => HomeworksState(
        homeworks: [],
        isLoadingSelected: false,
        selectedHomework: null,
        isLoadingHomeworks: false,
      );

  HomeworksState copyWith({
    List<HomeworksModel>? homeworks,
    bool? isLoadingSelected,
    bool? isLoadingHomeworks,
    OneHomeworkModel? selectedHomework,
  }) =>
      HomeworksState(
        homeworks: homeworks ?? this.homeworks,
        isLoadingHomeworks: isLoadingHomeworks ?? this.isLoadingHomeworks,
        isLoadingSelected: isLoadingSelected ?? this.isLoadingSelected,
        selectedHomework: selectedHomework ?? this.selectedHomework,
      );
}
