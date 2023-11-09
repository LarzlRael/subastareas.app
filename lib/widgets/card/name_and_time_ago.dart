part of '../widgets.dart';

class NameAndTimeAgo extends StatelessWidget {
  const NameAndTimeAgo({
    Key? key,
    required this.isOwner,
    required this.userName,
    required this.createdAt,
    required this.isCommentWritter,
    required this.isEdited,
    this.isRow = true,
  }) : super(key: key);
  final bool isOwner;
  final String userName;
  final DateTime createdAt;
  final bool isCommentWritter;
  final bool isRow;
  final bool isEdited;
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
      isOwner || isCommentWritter
          ? Container(
              decoration: BoxDecoration(
                color: isOwner ? Colors.grey[700] : Colors.blue[400],
                borderRadius: isCommentWritter
                    ? BorderRadius.circular(100)
                    : BorderRadius.circular(100),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 2,
                ),
                child: SimpleText(
                  text: userName,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  lightThemeColor: Colors.white,
                  setUniqueColor: true,
                ),
              ),
            )
          : SimpleText(
              text: userName,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: SimpleText(
          text: timeago.format(createdAt, locale: 'es'),
          lightThemeColor: Colors.grey,
          fontSize: 12,
        ),
      ),
      isEdited
          ? const SimpleText(
              text: '(Editado)',
              lightThemeColor: Colors.grey,
              fontSize: 12,
            )
          : const SizedBox()
    ];
  }
}
