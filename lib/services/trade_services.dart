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
    final finalData = tradeUserModelFromJson(homeworkRequest!.body);
    return finalData;
  }

  Future<List<TradeUserModel>> getHomeworksResolved(String status) async {
    final homeworkRequest = await Request.sendRequestWithToken(
      'GET',
      'trade/getTradingByUser/$status',
      {},
      await _storage.read(key: 'token'),
    );
    final finalData = tradeUserModelFromJson(homeworkRequest!.body);
    return finalData;
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
    final finalData = planesModelFromJson(planesRequest!.body);
    return finalData;
  }
}
