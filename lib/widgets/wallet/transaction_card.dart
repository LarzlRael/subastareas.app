part of '../widgets.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({Key? key, required this.transaction})
      : super(key: key);
  final UserTransactionModel transaction;
  final transactionType = 'solicitud_retiro';
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: ListTile(
        /* padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20), */
        leading: showIconTransactionType(),
        title: Text(convertTime(
          transaction.createdAt,
          format: 'dd/MM/yyyy',
        )),
        subtitle: SimpleText(
          text: transaction.transactionType == transactionType
              ? transaction.withdrawalRequestAmount.toString()
              : transaction.amount.toString(),
          fontSize: 18,
          fontWeight: FontWeight.bold,
          lightThemeColor: transaction.amount < 0 ? Colors.red : Colors.green,
          right: 5,
        ),
        trailing: transaction.transactionType != transactionType
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
