part of 'buttons.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget buttonChild;
  final Color backGroundColor;
  final Color textColor;
  final Widget icon;
  final bool showIcon;
  final double marginVertical;
  final double marginHorizontal;
  final double fontSize;
  final double paddingVertical;
  final double paddingHorizontal;
  final double spaceBetweenIconAndText;
  const LoginButton({
    Key? key,
    required this.onPressed,
    required this.buttonChild,
    this.backGroundColor = Colors.blue,
    this.textColor = Colors.black,
    this.icon = const Icon(Icons.person),
    this.showIcon = true,
    this.marginVertical = 5,
    this.marginHorizontal = 0,
    this.fontSize = 17.0,
    this.paddingVertical = 15.0,
    this.paddingHorizontal = 40.0,
    this.spaceBetweenIconAndText = 10.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: marginVertical, horizontal: marginHorizontal),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(backGroundColor),
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(
              vertical: paddingVertical,
              horizontal: paddingHorizontal,
            ),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
              /* side: BorderSide(color: Colors.red), */
            ),
          ),
        ),
        child: showIcon
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  icon,
                  Expanded(
                    child: buttonChild,
                  ),
                ],
              )
            : SizedBox(
                width: double.infinity,
                child: buttonChild,
              ),
        onPressed: onPressed,
      ),
    );
  }
}
