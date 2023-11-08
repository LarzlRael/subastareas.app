part of 'buttons.dart';

class FillButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final Color? backgroundColor;
  final Color textColor;

  final double marginVertical;
  final double marginHorizontal;
  final bool ghostButton;
  final double borderRadius;
  const FillButton({
    Key? key,
    required this.onPressed,
    required this.label,
    this.backgroundColor = Colors.amber,
    this.textColor = Colors.white,
    this.marginVertical = 5,
    this.marginHorizontal = 0,
    this.ghostButton = false,
    this.borderRadius = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyle = TextStyle(
      color: ghostButton ? backgroundColor : textColor,
      fontSize: 17.0,
      fontWeight: FontWeight.bold,
    );
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        vertical: marginVertical,
        horizontal: marginHorizontal,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              ghostButton ? Colors.white : backgroundColor ?? colors.primary,
          side: BorderSide(
            color: backgroundColor ?? colors.primary,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 40.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),

        /* style: ElevatedButton(
          backgroundColor: MaterialStateProperty.all(
              ghostButton ? Colors.white : backGroundColor),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(
              vertical: 15.0,
              horizontal: 40.0,
            ),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
          ),
        ), */
        onPressed: onPressed,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: textStyle,
        ),
      ),
    );
  }
}
