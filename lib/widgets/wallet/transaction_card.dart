part of '../widgets.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              FontAwesomeIcons.circleArrowUp,
              size: 25,
              color: Colors.blue,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SimpleText(
                      text: '27/02/2022',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      right: 6,
                    ),
                    SimpleText(
                      text: '22:48',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                Row(
                  children: [
                    SimpleText(
                      text: '9000',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      right: 5,
                    ),
                    SimpleText(
                      text: 'Depositado',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ],
            ),
            Icon(
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
