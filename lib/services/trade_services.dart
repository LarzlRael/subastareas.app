part of 'services.dart';

class TradeServices {
  final _storage = const FlutterSecureStorage();

  Future<List<TradeUserModel>> getHomeworksResolvedByUser(String status) async {
    final homeworkRequest = await Request.sendRequestWithToken(
      'GET',
      'trade/getTradingByUser/$status',
      {},
      await _storage.read(key: 'token'),
    );
    final finalData = tradeUserModelFromJson(homeworkRequest!.body);
    return finalData;
  }

  Future acceptOrDeclineTrade(int idOffer, int idTrade, bool accepted) async {
    final tradeRequest = await Request.sendRequestWithToken(
      'GET',
      accepted
          ? 'trade/acceptrade/$idOffer/$idTrade'
          : 'trade/declineTrade/$idOffer/$idTrade',
      {},
      await _storage.read(key: 'token'),
    );

    return tradeRequest!.body;
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
