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
    this.active = false,
    required this.offer,
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
        child: Container(
          child: horizontalOffer(
            context,
          ),
        ),
      ),
    );
  }

  InkWell horizontalOffer(BuildContext context) {
    return InkWell(
      onLongPress: () {
        if (isOwner) {
          showFilterBottomMenuSheet(
            context,
            AcceptOfferButton(offer: offer),
          );
        } else {
          null;
        }
      },
      onTap: () {
        final idUser = homework.offers
            .firstWhere(
              (element) => element.id == offer.id,
            )
            .user
            .id
            .toString();
        context.push('/public_profile_page/$idUser');
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
    final textTheme = Theme.of(context).textTheme;
    return ListTile(
      leading: ShowProfileImage(
        profileImage: offer.user.profileImageUrl,
        userName: offer.user.username,
        radius: 20,
      ),
      title: Text(
        offer.user.username.toCapitalized(),
        style: textTheme.bodyLarge,
      ),
      trailing: SimpleText(
        text: '${offer.priceOffer}',
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

showFilterBottomMenuSheet(BuildContext context, Widget content) {
  showModalBottomSheet(
    /* isScrollControlled: true, */
    context: context,
    builder: (context) {
      return SafeArea(child: content);
    },
  );
}
