part of 'widgets.dart';

class HomeworkCard extends StatelessWidget {
  final isLogged;
  const HomeworkCard({
    Key? key,
    required this.isLogged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'auctionPage');
      },
      child: Container(
        margin: const EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width * 0.25,
              height: size.height * 0.15,
              child: const FadeInImage(
                image:
                    NetworkImage('https://octutor.org/media/posts/11/math.jpg'),
                placeholder: AssetImage('assets/icon.png'),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SimpleText(
                    text: 'Alguien me ayuda con una tarea',
                    fontSize: 18,
                    lineHeight: 1.35,
                    fontWeight: FontWeight.w700,
                    color: Colors.black54,
                  ),
                  const SimpleText(
                    top: 5,
                    bottom: 5,
                    text: 'Matematica',
                    fontSize: 16,
                    lineHeight: 1.35,
                    fontWeight: FontWeight.w700,
                    color: Colors.black45,
                  ),
                  Row(
                    children: const [
                      Icon(
                        Icons.timer_outlined,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      SimpleText(
                        text: '2.5 horas restantes',
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
              children: const [
                SimpleText(
                  text: '\$ 1.000',
                  color: Colors.lightGreen,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(
                  height: 15,
                ),
                SimpleText(
                  text: '3 ofertas',
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
