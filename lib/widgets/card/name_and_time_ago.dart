part of '../widgets.dart';

class NameAndTimeAgo extends StatelessWidget {
  const NameAndTimeAgo({
    Key? key,
    required this.isOwner,
    required this.userName,
    required this.createdAt,
    required this.isCommentWritter,
    this.isRow = true,
  }) : super(key: key);
  final bool isOwner;
  final String userName;
  final DateTime createdAt;
  final bool isCommentWritter;
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
    List<Widget> widgets = [];

    if (!isOwner && !isCommentWritter) {
      widgets.add(
        SimpleText(
          text: userName,
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      );
    }

    widgets.add(
      Container(
        decoration: BoxDecoration(
          color: isOwner ? Colors.grey[700] : Colors.blue[400],
          borderRadius: isCommentWritter
              ? BorderRadius.circular(100)
              : BorderRadius.circular(100),
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
    );

    widgets.add(const SizedBox(width: 15));
    widgets.add(
      SimpleText(
        text: timeago.format(createdAt, locale: 'es'),
        lightThemeColor: Colors.grey,
      ),
    );

    return widgets;
  }
}
