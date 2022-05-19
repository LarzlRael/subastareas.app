part of 'widgets.dart';

class CircleAvatarGroup extends StatelessWidget {
  final List<String> urlImages;
  final int elementsToShow;

  const CircleAvatarGroup({
    Key? key,
    required this.urlImages,
    this.elementsToShow = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sliceArray = urlImages.length > elementsToShow
        ? urlImages.sublist(0, elementsToShow)
        : urlImages;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'autionWithOffer');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
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
                      .map((circle) => CircleAvatar(
                            backgroundImage: NetworkImage(circle),
                          ))
                      .toList(),
                ),
                urlImages.length > elementsToShow
                    ? _createCircleAvatarMore()
                    : Container(),
              ],
            ),
          ],
        ),
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
    final showNumber = urlImages.length - elementsToShow;
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
