part of 'services.dart';

class TradeServices {
  final _storage = const FlutterSecureStorage();

  Future<List<TradeUserModel>> getHomeworksPendingToResolve() async {
    final homeworkRequest = await Request.sendRequestWithToken(
      'GET',
      'trade/getTradePendingToTrade/',
      {},
      await _storage.read(key: 'token'),
    );
    return tradeUserModelFromJson(homeworkRequest!.body);
  }

  Future<List<TradeUserModel>> getHomeworksResolved(String status) async {
    final homeworkRequest = await Request.sendRequestWithToken(
      'GET',
      'trade/getTradingByUser/$status',
      {},
      await _storage.read(key: 'token'),
    );
    return tradeUserModelFromJson(homeworkRequest!.body);
  }

  Future<bool> acceptOrDeclineTrade(int idOffer, bool accepted) async {
    final tradeRequest = await Request.sendRequestWithToken(
      'GET',
      accepted ? 'trade/acceptTrade/$idOffer' : 'trade/declineTrade/$idOffer',
      {},
      await _storage.read(key: 'token'),
    );

    return validateStatus(tradeRequest?.statusCode);
  }

  Future<List<PlanesModel>> getPlanes() async {
    final planesRequest = await Request.sendRequestWithToken(
      'GET',
      'planes/getPlanes',
      {},
      await _storage.read(key: 'token'),
    );
    return planesModelFromJson(planesRequest!.body);
  }

  Future<bool> shopCoins(int idPlan, String planName) async {
    /* buyCoins/:idPlan/:planName */
    final planesRequest = await Request.sendRequestWithToken(
      'GET',
      'shopping/buyCoins/$idPlan/$planName',
      {},
      await _storage.read(key: 'token'),
    );

    return validateStatus(planesRequest?.statusCode);
  }
}
