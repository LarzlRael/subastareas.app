part of 'widgets.dart';

class PersonOfferCard extends StatelessWidget {
  final bool active;
  final String nameOffered;
  final int offerPrice;

  const PersonOfferCard({
    Key? key,
    required this.nameOffered,
    required this.offerPrice,
    this.active = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FittedBox(
      child: Container(
        margin: const EdgeInsets.all(5.0),
        width: size.width * 0.25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: active ? Color(0xFF353853) : Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CircleAvatar(
                radius: 25,
              ),
              SimpleText(
                text: nameOffered,
                textAlign: TextAlign.center,
                top: 10,
                bottom: 10,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: active ? Colors.white : Colors.black,
              ),
              SimpleText(
                text: offerPrice.toString(),
                color: Colors.grey,
                fontSize: 13,
                /* color: active ? Colors.white : Colors.black, */
              ),
            ],
          ),
        ),
      ),
    );
  }
}
