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
    print('id del homework: $id');
    _oneHomeworkController.sink.add(await homeworkServices.getOneHomework(id));
  }

  deleteComment(int idComment, int idHomework) async {
    print('id del comentario: $idComment');
    print('id del homework: $idHomework');
    await commentService.deleteComment(idComment);
    await getOneHomework(idHomework);
  }

  newCommet(int idHomework, String content) async {
    await commentService.newComment(
      idHomework,
      content,
    );
    await getOneHomework(idHomework);
  }

  editComment(int idComment, int idHomework, String content) async {
    await commentService.editComment(
      idComment,
      content,
    );
    await getOneHomework(idHomework);
  }

  makeOffer(int idHomework, int offer) async {
    await offersServices.makeOffer(idHomework, offer);
    await getOneHomework(idHomework);
  }

  getHomeworks() async {
    _homeworksController.sink.add(await homeworkServices.getHomeworks());
  }

  getHomeworksByCategory(List<String> category) async {
    _homeworksController.sink
        .add(await homeworkServices.getHomeworksByCategoryAndLevel(category));
  }
}
