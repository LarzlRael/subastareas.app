part of '../widgets.dart';

class DescriptionText extends StatelessWidget {
  final String desc;
  final TextAlign? textAlign;
  final bool dropDown;
  const DescriptionText({
    Key? key,
    required this.desc,
    this.dropDown = true,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return dropDown
        ? DropdownComment(
            commentContent: desc,
            limit: 150,
          )
        : SimpleText(
            lightThemeColor: Colors.grey,
            fontSize: 16,
            lineHeight: 1.8,
            text: desc,
            textAlign: textAlign ?? textAlign);
  }
}
