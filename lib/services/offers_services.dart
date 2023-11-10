part of 'services.dart';

class OffersServices {
  Future<OfferSimpleModel> makeOrEditOffer(
    int idHomework,
    int amountOffered, {
    int? idOffer,
  }) async {
    final homeworkRequest = await Request.sendRequestWithToken(
      idOffer == null ? RequestType.post : RequestType.put,
      idOffer == null
          ? 'offer/makeOffer/$idHomework'
          : 'offer/editOffer/$idOffer',
      body: {
        'priceOffer': amountOffered,
      },
    );

    return offerSimpleModelFromJson(homeworkRequest!.body);
  }

  Future<bool> enterPendingTrade(int idOffer) async {
    final homeworkRequest = await Request.sendRequestWithToken(
      RequestType.get,
      'trade/enterPendingTrade/$idOffer',
    );

    return validateStatus(homeworkRequest!.statusCode);
  }

  Future<bool> uploadHomeworkResolvedFile(
    int idOfferAccepted,
    String filePath,
  ) async {
    final homeworkRequest = await Request.sendRequestWithFile(
      RequestType.put,
      'trade/uploadResolvedHomework/$idOfferAccepted',
      filePath,
    );

    return validateStatus(homeworkRequest.statusCode);
  }

  Future<List<HomeworksModel>> getUsersHomeworksPending() async {
    final uploadWithFile = await Request.sendRequestWithToken(
      RequestType.get,
      'offer/getUsersHomeworksPending',
    );
    return homeworksModelFromJson(uploadWithFile!.body);
  }

  Future<List<HomeworksModel>> getUserOfferSent() async {
    final offerSent = await Request.sendRequestWithToken(
      RequestType.get,
      'offer/getOfferSentByUser',
    );
    return homeworksModelFromJson(offerSent!.body);
  }

  Future<List<HomeworksModel>> getUserOffersReceived() async {
    final offerSent = await Request.sendRequestWithToken(
      RequestType.get,
      'offer/getOfferReceivedByUser',
    );
    return homeworksModelFromJson(offerSent!.body);
  }

  Future<OfferSimpleModel> deleteOffer(int idOffer) async {
    final deletedOffer = await Request.sendRequestWithToken(
      RequestType.delete,
      'offer/$idOffer',
    );
    return offerSimpleModelFromJson(deletedOffer!.body);
  }
}
