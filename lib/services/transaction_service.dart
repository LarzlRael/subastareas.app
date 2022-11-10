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

  Future<bool> withdrawMoneyTransaction(int amount, String phone) async {
    final homeworkRequest = await Request.sendRequestWithToken(
      'POST',
      'transaction/withdrawMoneyTransaction',
      {
        'amount': amount,
        'phone': phone,
      },
      /* {"statusCode":400,"message":["accountNumber must be a string","paymentMethod must be a string","status must be a string","phone must be empty"],"error":"Bad Request"} */
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

  /* Future<List<WithdrawalRequestsModel>> getListUserWithdrawRequest() async {
    final homeworkRequest = await Request.sendRequestWithToken(
      'GET',
      'transaction/getListUserWithdrawRequest/',
      {},
      await _storage.read(key: 'token'),
    );
    return withdrawalRequestsModelFromJson(homeworkRequest!.body);
  } */
  Future<bool> confirmWithDraw(WithDrawRequestBody withDrawRequestBody) async {
    final homeworkRequest = await Request.sendRequestWithToken(
      'GET',
      'transaction/confirmWithDraw/',
      {},
      await _storage.read(key: 'token'),
    );
    return validateStatus(homeworkRequest!.statusCode);
  }
}
