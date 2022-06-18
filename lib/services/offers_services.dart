part of 'services.dart';

class OffersServices {
  final _storage = const FlutterSecureStorage();
  Future makeOrEditOffer(
    bool edit,
    int idHomework,
    int priceOffer,
    int idOffer,
  ) async {
    print('idHomework: $idHomework');
    final homeworkRequest = await Request.sendRequestWithToken(
        !edit ? 'POST' : 'PUT',
        !edit ? 'offer/makeOffer/$idHomework' : 'offer/editOffer/$idOffer',
        {
          'priceOffer': priceOffer,
        },
        await _storage.read(key: 'token'));

    print(homeworkRequest!.body);
  }
}
