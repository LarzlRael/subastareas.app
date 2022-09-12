part of '../widgets.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({Key? key, required this.transaction})
      : super(key: key);
  final UserTransactionModel transaction;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              transaction.amount > 0
                  ? FontAwesomeIcons.circleArrowUp
                  : FontAwesomeIcons.circleArrowDown,
              size: 25,
              color: transaction.amount > 0 ? Colors.green : Colors.red,
            ),
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
                      text: '${transaction.amount}',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: transaction.amount < 0 ? Colors.red : Colors.green,
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
            const Icon(
              Icons.check_circle_outline,
              size: 30,
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
