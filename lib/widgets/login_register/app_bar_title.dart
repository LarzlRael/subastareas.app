part of '../widgets.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    Key? key,
    this.fontSize = 25,
  }) : super(key: key);
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/icon.png',
          height: 35,
        ),
        SimpleText(
          left: 10,
          text: 'SUBASTAREAS',
          /* color: Colors.black, */
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }
}
