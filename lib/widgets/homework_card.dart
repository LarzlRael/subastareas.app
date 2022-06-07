part of 'widgets.dart';

class HomeworkCard extends StatelessWidget {
  final bool isLogged;
  final HomeworksModel homework;
  const HomeworkCard({
    Key? key,
    required this.isLogged,
    required this.homework,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'auctionPage', arguments: homework.id);
      },
      child: Container(
        margin: const EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width * 0.25,
              height: size.height * 0.15,
              child: Hero(
                tag: homework.id,
                child: Image.asset(
                  'assets/category/quimica.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SimpleText(
                    text: homework.title,
                    fontSize: 18,
                    lineHeight: 1.35,
                    fontWeight: FontWeight.w700,
                    color: Colors.black54,
                  ),
                  SimpleText(
                    top: 5,
                    bottom: 5,
                    text: homework.category,
                    fontSize: 16,
                    lineHeight: 1.35,
                    fontWeight: FontWeight.w700,
                    color: Colors.black45,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.timer_outlined,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SimpleText(
                        text:
                            '${getDateDiff(homework.resolutionTime).inHours} horas restantes',
                        color: Colors.red,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SimpleText(
                  text: '\$ ${homework.offeredAmount}',
                  color: Colors.lightGreen,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                const SizedBox(
                  height: 15,
                ),
                /* homework.offers.length > 0
                    ? SimpleText(
                        text: '${homework.offers.length} ofertas',
                        color: Colors.grey,
                        fontSize: 16,
                      )
                    : Container(), */
              ],
            ),
          ],
        ),
      ),
    );
  }
}
