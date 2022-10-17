part of '../widgets.dart';

class HomeworkPendingToResolve extends StatelessWidget {
  final TradeUserModel tradeUserModel;

  const HomeworkPendingToResolve({
    Key? key,
    required this.tradeUserModel,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          'verify_homework_resolved',
          arguments: tradeUserModel,
        );
      },
      child: Container(
        /* color: Colors.red, */
        margin: const EdgeInsets.only(bottom: 20),
        width: double.infinity,
        height: 140,
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SimpleText(
                  text: tradeUserModel.title.length > 60
                      ? '${tradeUserModel.title.substring(0, 60)}...'
                      : tradeUserModel.title,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  bottom: 10,
                ),
                Row(
                  children: [
                    SimpleText(
                      text:
                          '${getDateDiff(tradeUserModel.resolutionTime).inHours < 0 ? 0 : getDateDiff(tradeUserModel.resolutionTime).inHours} horas restantes',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      bottom: 10,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
