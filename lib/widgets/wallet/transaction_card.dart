part of '../widgets.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({Key? key, required this.transaction})
      : super(key: key);
  final UserTransactionModel transaction;
  final transactionType = 'solicutud_retiro';
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                showIconTransactionType(),
                const SizedBox(width: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SimpleText(
                          text: convertTime(
                            transaction.createdAt,
                            format: 'dd/MM/yyyy',
                          ),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          right: 6,
                        ),
                        /*  SimpleText(
                      text: '22:48',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ), */
                      ],
                    ),
                    Row(
                      children: [
                        SimpleText(
                          text: transaction.transactionType == transactionType
                              ? transaction.withdrawalRequestAmount.toString()
                              : transaction.amount.toString(),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          lightThemeColor: transaction.amount < 0
                              ? Colors.red
                              : Colors.green,
                          right: 5,
                        ),
                        SimpleText(
                          text: transaction.transactionType,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            transaction.transactionType != 'solicutud_retiro'
                ? const Icon(
                    FontAwesomeIcons.circleCheck,
                    size: 25,
                    color: Colors.green,
                  )
                : const Icon(
                    FontAwesomeIcons.clock,
                    size: 25,
                    color: Colors.orange,
                  ),
          ],
        ),
      ),
    );
  }

  Widget showIconTransactionType() {
    if (transaction.transactionType == transactionType) {
      return const Icon(
        FontAwesomeIcons.circleMinus,
        size: 25,
        color: Colors.orange,
      );
    }
    return Icon(
      transaction.amount > 0
          ? FontAwesomeIcons.circleArrowUp
          : FontAwesomeIcons.circleArrowDown,
      size: 25,
      color: transaction.amount > 0 ? Colors.green : Colors.red,
    );
  }
}
