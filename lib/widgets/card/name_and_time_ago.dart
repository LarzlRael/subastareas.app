part of '../widgets.dart';

class NameAndTimeAgo extends StatelessWidget {
  const NameAndTimeAgo({
    Key? key,
    required this.isOwner,
    required this.userName,
    required this.createdAt,
    this.isRow = true,
  }) : super(key: key);
  final bool isOwner;
  final String userName;
  final DateTime createdAt;
  final bool isRow;
  @override
  Widget build(BuildContext context) {
    if (isRow) {
      return Row(
        children: content(),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: content(),
      );
    }
  }

  List<Widget> content() {
    return [
      isOwner
          ? SimpleText(
              text: userName,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            )
          : Container(
              decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(300),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 3,
                ),
                child: SimpleText(
                  text: userName,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  lightThemeColor: Colors.white,
                  setUniqueColor: true,
                ),
              ),
            ),
      const SizedBox(width: 15),
      SimpleText(
        text: timeAgo.format(createdAt, locale: 'es'),
        lightThemeColor: Colors.grey,
      ),
    ];
  }
}
