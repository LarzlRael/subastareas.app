part of 'services.dart';

class TradeServices {
  Future<List<TradeUserModel>> getHomeworksPendingToResolve() async {
    final homeworkRequest = await Request.sendRequestWithToken(
      RequestType.get,
      'trade/getTradePendingToTrade/',
    );
    return tradeUserModelFromJson(homeworkRequest!.body);
  }

  Future<List<TradeUserModel>> getHomeworksResolved(String status) async {
    final homeworkRequest = await Request.sendRequestWithToken(
      RequestType.get,
      'trade/getTradingByUser/$status',
    );
    return tradeUserModelFromJson(homeworkRequest!.body);
  }

  Future<bool> acceptOrDeclineTrade(
    int idOffer,
    bool accepted, {
    String? reasonRejected,
  }) async {
    final tradeRequest = await Request.sendRequestWithToken(
      RequestType.get,
      accepted
          ? 'trade/acceptTrade/$idOffer'
          : 'trade/declineTrade/$idOffer/$reasonRejected',
    );

    return validateStatus(tradeRequest?.statusCode);
  }

  Future<List<PlanesModel>> getPlanes() async {
    final planesRequest = await Request.sendRequestWithToken(
      RequestType.get,
      'planes/getPlanes',
    );
    return planesModelFromJson(planesRequest!.body);
  }

  Future<bool> shopCoins(int idPlan, String planName) async {
    /* buyCoins/:idPlan/:planName */
    final planesRequest = await Request.sendRequestWithToken(
      RequestType.get,
      'shopping/buyCoins/$idPlan/$planName',
    );

    return validateStatus(planesRequest?.statusCode);
  }
}
