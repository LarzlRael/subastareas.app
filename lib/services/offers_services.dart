part of 'services.dart';

class OffersServices {
  final _storage = const FlutterSecureStorage();
  Future makeOffer(int idHomework, int priceOffer) async {
    print('idHomework: $idHomework');
    final homeworkRequest = await Request.sendRequestWithToken(
        'POST',
        'offer/makeOffer/$idHomework',
        {
          'priceOffer': priceOffer,
        },
        await _storage.read(key: 'token'));

    print(homeworkRequest!.body);
  }
}
