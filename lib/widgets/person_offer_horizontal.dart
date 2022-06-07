part of 'widgets.dart';

class PersonOfferHorizontal extends StatelessWidget {
  final bool active;
  final Offer offer;

  const PersonOfferHorizontal({
    Key? key,
    required this.offer,
    this.active = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      margin: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              showProfileImage(offer.user.profileImageUrl, offer.user.username),
              SimpleText(
                left: 10,
                text: offer.user.username,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          SimpleText(text: '${offer.priceOffer}')
        ],
      ),
    );
  }
}
