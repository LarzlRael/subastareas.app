part of '../widgets.dart';

class PersonOfferHorizontal extends StatelessWidget {
  final bool active;
  final Offer offer;
  final OneHomeworkModel homework;
  final AuthServices auth;
  final bool isOwner;
  final AnimationController animationController;
  final int id;
  const PersonOfferHorizontal({
    Key? key,
    required this.offer,
    this.active = false,
    required this.auth,
    required this.homework,
    required this.isOwner,
    required this.animationController,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor:
            CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        child: Container(child: horizontalOffer(context)),
      ),
    );
  }

  InkWell horizontalOffer(BuildContext context) {
    return InkWell(
      onLongPress: () {
        if (isOwner) {
          showFilterBottomMenuShett(
            context,
            AcceptOfferButton(offer: offer),
          );
        } else {
          null;
        }
      },
      onTap: () {
        Navigator.pushNamed(
          context,
          'public_profile_page',
        );
      },
      child: Ink(
        child: HorizontalOfferRow(offer: offer),
      ),
    );
  }
}

class HorizontalOfferRow extends StatelessWidget {
  const HorizontalOfferRow({
    Key? key,
    required this.offer,
  }) : super(key: key);

  final Offer offer;

  @override
  Widget build(BuildContext context) {
    return Container(
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
