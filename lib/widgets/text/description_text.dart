part of '../widgets.dart';

class DescriptionText extends StatelessWidget {
  final String desc;
  final TextAlign? textAlign;
  final bool despegable;
  const DescriptionText({
    Key? key,
    required this.desc,
    this.despegable = true,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return despegable
        ? DesplegableComment(
            commentContent: desc,
            limit: 150,
          )
        : SimpleText(
            color: Colors.grey,
            fontSize: 16,
            lineHeight: 1.8,
            text: desc,
            textAlign: textAlign ?? textAlign);
  }
}
