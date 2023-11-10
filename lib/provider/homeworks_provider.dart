part of 'providers.dart';

class HomeworksProvider with ChangeNotifier {
  OffersServices offersServices = OffersServices();

  HomeworksState state = HomeworksState.initial();
  PendingsHomeworkState pendingsHomeworkState = PendingsHomeworkState.initial();

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
        RequestType.get, 'homework/getOneHomework/$id');
    state = state.copyWith(
      isLoadingSelected: false,
      selectedHomework: oneHomeworkModelFromJson(homeworkRequest!.body),
    );
    notifyListeners();
  }

  Future<bool> deleteHomework(int idHomework) async {
    final res = await Request.sendRequestWithToken(
      RequestType.delete,
      'homework/deleteHomework/$idHomework',
    );

    state = state.copyWith(
      selectedHomework: null,
    );
    notifyListeners();
    return validateStatus(res!.statusCode);
  }

  Future<OfferSimpleModel> makeOrEditOffer(
    int idHomework,
    int amountOffered, {
    int? idOffer,
  }) async {
    final makeOrEditOffer = await offersServices
        .makeOrEditOffer(idHomework, amountOffered, idOffer: idOffer);
    getOneHomework(idHomework);
    return makeOrEditOffer;
  }

  Future<List<HomeworksModel>> getHomeworksByUser() async {
    final homeworkRequest = await Request.sendRequestWithToken(
      RequestType.get,
      'homework/homeworksByUser',
    );

    return homeworksModelFromJson(homeworkRequest!.body);
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

  Future<bool> uploadOrUpdateHomework(
    int idHomework,
    Map<String, String> body, {
    String? pathFile,
  }) async {
    if (pathFile != null) {
      final homeworkUploadWithFile = await Request.sendRequestWithFile(
        RequestType.post,
        'homework/create',
        pathFile,
        body: body,
      );
      return validateStatus(homeworkUploadWithFile.statusCode);
    }

    final homeworkRequest = await Request.sendRequestWithToken(
      idHomework == 0 ? RequestType.post : RequestType.put,
      idHomework == 0
          ? 'homework/create'
          : 'homework/updateHomework/$idHomework',
      body: body,
    );

    return validateStatus(homeworkRequest!.statusCode);
  }

  Future<void> getUserPendingsHomeworksToResolve() async {
    pendingsHomeworkState = pendingsHomeworkState.copyWith(isLoading: true);
    final request = await Request.sendRequestWithToken(
      RequestType.get,
      'offer/getUsersHomeworksPending',
    );
    final converted = homeworksModelFromJson(request!.body);
    pendingsHomeworkState = pendingsHomeworkState.copyWith(
      pendingsHomeworks: converted,
      isLoading: false,
    );
    notifyListeners();
  }

  Future<List<HomeworksModel>> getHomeworksByCategoryAndLevel(
      List<String> category) async {
    /* category/programacion,algebra/level/Universitario */
    final categoryFilter = category.isNotEmpty ? category.join(',') : 'empty';
    /* final levelFilter = level.isNotEmpty ? level.join(',') : 'empty'; */
    final homeworkRequest = await Request.sendRequest(
      RequestType.get,
      'homework/category/$categoryFilter',
    );
    return homeworksModelFromJson(homeworkRequest!.body);
  }

  Future<List<String>> getSubjectAndLevels() async {
    final homeworkRequest = await Request.sendRequest(
      RequestType.get,
      'homework/getSubjectsList',
    );
    final finalData = subjectsFromJson(homeworkRequest!.body);
    return finalData;
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

class PendingsHomeworkState {
  List<HomeworksModel> pendingsHomeworks;
  bool isLoading;
  factory PendingsHomeworkState.initial() => PendingsHomeworkState(
        pendingsHomeworks: [],
        isLoading: false,
      );
  PendingsHomeworkState({
    required this.pendingsHomeworks,
    required this.isLoading,
  });
  PendingsHomeworkState copyWith({
    List<HomeworksModel>? pendingsHomeworks,
    bool? isLoading,
  }) =>
      PendingsHomeworkState(
        pendingsHomeworks: pendingsHomeworks ?? this.pendingsHomeworks,
        isLoading: isLoading ?? this.isLoading,
      );
}
