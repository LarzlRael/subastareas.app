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
        !edit ? RequestType.post : RequestType.put,
        !edit ? 'offer/makeOffer/$idHomework' : 'offer/editOffer/$idOffer',
        {
          'priceOffer': priceOffer,
        },
        await _storage.read(key: 'token'));

    return offerSimpleModelFromJson(homeworkRequest!.body);
  }

  Future<bool> enterPendingTrade(int idOffer) async {
    final homeworkRequest = await Request.sendRequestWithToken(
      RequestType.get,
      'trade/enterPendingTrade/$idOffer',
      {},
      await _storage.read(key: 'token'),
    );

    return validateStatus(homeworkRequest!.statusCode);
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
      RequestType.get,
      'offer/getUsersHomeworksPending',
      {},
      await _storage.read(key: 'token') ?? '',
    );
    return homeworksModelFromJson(uploadWithFile!.body);
  }

  Future<List<HomeworksModel>> getUserOfferSent() async {
    final offerSent = await Request.sendRequestWithToken(
      RequestType.get,
      'offer/getOfferSentByUser',
      {},
      await _storage.read(key: 'token') ?? '',
    );
    return homeworksModelFromJson(offerSent!.body);
  }

  Future<List<HomeworksModel>> getUserOffersReceived() async {
    final offerSent = await Request.sendRequestWithToken(
      RequestType.get,
      'offer/getOfferReceivedByUser',
      {},
      await _storage.read(key: 'token') ?? '',
    );
    return homeworksModelFromJson(offerSent!.body);
  }

  Future<OfferSimpleModel> deleteOffer(int idOffer) async {
    final deletedOffer = await Request.sendRequestWithToken(
      RequestType.delete,
      'offer/$idOffer',
      {},
      await _storage.read(key: 'token') ?? '',
    );
    print(deletedOffer!.body);
    return offerSimpleModelFromJson(deletedOffer.body);
  }
}
