import 'dart:async';

import 'package:subastareaspp/models/models.dart';
import 'package:subastareaspp/services/services.dart';

class OneHomeworkBloc {
  static final OneHomeworkBloc _singleton = OneHomeworkBloc._internal();
  HomeworkServices homeworkServices = HomeworkServices();
  CommentServices commentService = CommentServices();
  OffersServices offersServices = OffersServices();
  factory OneHomeworkBloc() {
    return _singleton;
  }
  OneHomeworkBloc._internal();

  final _oneHomeworkController = StreamController<OneHomeworkModel>.broadcast();
  final _homeworksController =
      StreamController<List<HomeworksModel>>.broadcast();

  Stream<OneHomeworkModel> get oneHomeworkStream =>
      _oneHomeworkController.stream;
  Stream<List<HomeworksModel>> get homeworksStream =>
      _homeworksController.stream;
  dispose() {
    _oneHomeworkController.close();
    _homeworksController.close();
  }

  getOneHomework(int id) async {
    _oneHomeworkController.sink.add(await homeworkServices.getOneHomework(id));
  }

  deleteHomework(int id) async {
    await homeworkServices.getOneHomework(id);
  }

  deleteComment(int idComment, int idHomework) async {
    await commentService.deleteComment(idComment);
    await getOneHomework(idHomework);
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

  getHomeworks() async {
    _homeworksController.sink.add(await homeworkServices.getHomeworks());
  }

  getSearchedHomeworks(String query) async {
    _homeworksController.sink
        .add(await homeworkServices.getSearchedHomeworks(query));
  }

  getHomeworksByCategory(List<String> category) async {
    _homeworksController.sink
        .add(await homeworkServices.getHomeworksByCategoryAndLevel(category));
  }

  Future<OfferSimpleModel> deleteOffer(int idHomework, int idOffer) async {
    final offerDeleted = await offersServices.deleteOffer(idOffer);
    await getOneHomework(idHomework);
    return offerDeleted;
  }
}
