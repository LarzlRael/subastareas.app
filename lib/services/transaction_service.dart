part of 'services.dart';

class TransactionServices {
  final _storage = const FlutterSecureStorage();

  Future<List<UserTransactionModel>> getUserHistoryTransaction() async {
    final homeworkRequest = await Request.sendRequestWithToken(
      RequestType.get,
      'transaction/getUserTransactionsHistory',
    );
    final finalData = userTransactionModelFromJson(homeworkRequest!.body);
    return finalData;
  }

  Future<bool> withdrawMoneyTransaction(int amount, String phone) async {
    final homeworkRequest = await Request.sendRequestWithToken(
      RequestType.get,
      'transaction/withdrawMoneyTransaction',
      body: {
        'amount': amount,
        'phone': phone,
      },
      /* {"statusCode":400,"message":["accountNumber must be a string","paymentMethod must be a string","status must be a string","phone must be empty"],"error":"Bad Request"} */
    );
    return validateStatus(homeworkRequest!.statusCode);
  }
  /* Admin services */

  Future<List<WithdrawalRequestsModel>> getListUserWithdrawRequest() async {
    final homeworkRequest = await Request.sendRequestWithToken(
      RequestType.get,
      'transaction/getListUserWithdrawRequest',
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
  Future<void> confirmWithDraw(
      BuildContext context, WithDrawRequestBody withDrawRequestBody) async {
    Request.sendRequestWithToken(
      RequestType.get,
      'transaction/confirmWithDraw',
      body: withDrawRequestBody.bodyToJson(),
    ).then((res) {
      if (validateStatus(res!.statusCode)) {
        GlobalSnackBar.show(context, "Operacion realizada con exito");
        context.push('/select_option');
      } else {
        GlobalSnackBar.show(context, "Hubo un error",
            backgroundColor: Colors.red);
      }
    });
  }
}
