part of '../widgets.dart';

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
    final filterProvider = Provider.of<FilterProvider>(context);
    return InkWell(
      onLongPress: () {
        showFilterBottomMenuShett(
          context,
          AcceptOfferButton(amount: offer.priceOffer),
        );
      },
      child: Ink(
        child: Container(
          /* color: Colors.amber, */
          margin: const EdgeInsets.only(bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  showProfileImage(
                    offer.user.profileImageUrl,
                    offer.user.username,
                    radius: 20,
                  ),
                  SimpleText(
                    left: 15,
                    text: offer.user.username,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              SimpleText(
                text: '${offer.priceOffer}',
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

showFilterBottomMenuShett(BuildContext context, Widget content) {
  showModalBottomSheet(
    /* isScrollControlled: true, */
    context: context,
    builder: (context) {
      return SafeArea(child: content);
    },
  );
}
