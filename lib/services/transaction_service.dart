part of 'services.dart';

class TransactionServices {
  final _storage = const FlutterSecureStorage();

  Future<List<UserTransactionModel>> getUserHistoryTransaction() async {
    final homeworkRequest = await Request.sendRequestWithToken(
      'GET',
      'transaction/getUserTransactionsHistory',
      {},
      await _storage.read(key: 'token'),
    );
    final finalData = userTransactionModelFromJson(homeworkRequest!.body);
    return finalData;
  }
}
