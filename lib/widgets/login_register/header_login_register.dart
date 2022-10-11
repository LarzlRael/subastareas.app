part of '../widgets.dart';

class HeaderLoginRegister extends StatelessWidget {
  final String headerTitle;

  const HeaderLoginRegister({
    Key? key,
    required this.headerTitle,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 35),
          child: OnlyImageAndTitle(),
        ),
        SimpleText(
          text: headerTitle,
          fontSize: 25,
          fontWeight: FontWeight.w900,
          top: 10,
          bottom: 10,
        ),
      ],
    );
  }
}
