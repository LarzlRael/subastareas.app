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

  Future<bool> withdrawMoneyTransaction(int balance) async {
    final homeworkRequest = await Request.sendRequestWithToken(
      'GET',
      'transaction/withdrawMoneyTransaction/$balance',
      {},
      await _storage.read(key: 'token'),
    );
    return validateStatus(homeworkRequest!.statusCode);
  }
  /* Admin services */

  Future<List<WithdrawalRequestsModel>> getListUserWithdrawRequest() async {
    final homeworkRequest = await Request.sendRequestWithToken(
      'GET',
      'transaction/getListUserWithdrawRequest/',
      {},
      await _storage.read(key: 'token'),
    );
    return withdrawalRequestsModelFromJson(homeworkRequest!.body);
  }
}
