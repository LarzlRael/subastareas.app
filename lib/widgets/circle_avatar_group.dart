part of 'widgets.dart';

class CircleAvatarGroup extends StatelessWidget {
  final int elementsToShow;
  final OneHomeworkModel oneHomeworkModel;
  const CircleAvatarGroup({
    Key? key,
    required this.oneHomeworkModel,
    this.elementsToShow = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sliceArray = oneHomeworkModel.offers.length > elementsToShow
        ? oneHomeworkModel.offers.sublist(0, elementsToShow)
        : oneHomeworkModel.offers;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'autionWithOfferPage',
            arguments: oneHomeworkModel);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        child: oneHomeworkModel.offers.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SimpleText(
                    text: 'Ofertas',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    bottom: 5,
                  ),
                  Row(
                    children: [
                      Row(
                        children: sliceArray
                            .map((offer) => Container(
                                  margin: const EdgeInsets.only(right: 5),
                                  child: showProfileImage(
                                    offer.user.profileImageUrl,
                                    offer.user.username,
                                    radius: 20,
                                  ),
                                ))
                            .toList(),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      oneHomeworkModel.offers.length > elementsToShow
                          ? _createCircleAvatarMore()
                          : Container(),
                    ],
                  ),
                ],
              )
            : Container(),
      ),
    );
  }

  _createCircleAvatar(String url) {
    return CircleAvatar(
      backgroundImage: NetworkImage(url),
      radius: 20,
    );
  }

  _createCircleAvatarMore() {
    final showNumber = oneHomeworkModel.offers.length - elementsToShow;
    return CircleAvatar(
      backgroundColor: Colors.grey,
      radius: 18,
      child: Text(
        showNumber.toString() + "+",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
