part of 'services.dart';

class OffersServices {
  final _storage = const FlutterSecureStorage();
  Future<OfferSimpleModel> makeOrEditOffer(
    bool edit,
    int idHomework,
    int priceOffer,
    int idOffer,
  ) async {
    final homeworkRequest = await Request.sendRequestWithToken(
        !edit ? 'POST' : 'PUT',
        !edit ? 'offer/makeOffer/$idHomework' : 'offer/editOffer/$idOffer',
        {
          'priceOffer': priceOffer,
        },
        await _storage.read(key: 'token'));

    return offerSimpleModelFromJson(homeworkRequest!.body);
  }

  Future enterPendingTrade(int idOffer) async {
    final homeworkRequest = await Request.sendRequestWithToken(
        'GET',
        'trade/enterPendingTrade/$idOffer',
        {},
        await _storage.read(key: 'token'));

    print(homeworkRequest!.body);
  }

  Future<bool> uploadHomeworkResolvedFile(
      File file, int idOfferAccepted) async {
    final homeworkRequest = await Request.sendRequestWithFile(
        'PUT',
        'trade/uploadResolvedHomework/$idOfferAccepted',
        {},
        file,
        await _storage.read(key: 'token') ?? '');

    return validateStatus(homeworkRequest.statusCode);
  }

  Future<List<HomeworksModel>> getUsersHomeworksPending() async {
    final uploadWithFile = await Request.sendRequestWithToken(
      'GET',
      'offer/getUsersHomeworksPending',
      {},
      await _storage.read(key: 'token') ?? '',
    );
    return homeworksModelFromJson(uploadWithFile!.body);
  }

  Future<List<HomeworksModel>> getUserOfferSent() async {
    final offerSent = await Request.sendRequestWithToken(
      'GET',
      'offer/getOfferSentByUser',
      {},
      await _storage.read(key: 'token') ?? '',
    );
    return homeworksModelFromJson(offerSent!.body);
  }

  Future<List<HomeworksModel>> getUserOffersReceived() async {
    final offerSent = await Request.sendRequestWithToken(
      'GET',
      'offer/getOfferReceivedByUser',
      {},
      await _storage.read(key: 'token') ?? '',
    );
    return homeworksModelFromJson(offerSent!.body);
  }

  Future<OfferSimpleModel> deleteOffer(int idOffer) async {
    final deletedOffer = await Request.sendRequestWithToken(
      'DELETE',
      'offer/$idOffer',
      {},
      await _storage.read(key: 'token') ?? '',
    );
    print(deletedOffer!.body);
    return offerSimpleModelFromJson(deletedOffer.body);
  }
}
