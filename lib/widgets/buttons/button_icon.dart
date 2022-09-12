part of '../widgets.dart';

class ButtonWithIcon extends StatelessWidget {
  final IconData? icon;
  final String label;
  final Color buttonBorderColor;
  final TextStyle styleLabelButton;

  final VoidCallback onPressed;
  final Color backgroundColorButton;
  final double verticalPadding;
  final double iconSize;

  final double marginHorizontal;
  final double marginVertical;
  const ButtonWithIcon({
    Key? key,
    this.icon,
    required this.label,
    this.backgroundColorButton = Colors.blue,
    this.buttonBorderColor = Colors.transparent,
    this.styleLabelButton = const TextStyle(color: Colors.white, fontSize: 16),
    this.verticalPadding = 5,
    this.iconSize = 24.0,
    this.marginHorizontal = 0,
    this.marginVertical = 0,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: marginHorizontal,
        vertical: marginVertical,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: icon != null
          ? TextButton.icon(
              icon: Icon(
                icon,
                color: Colors.white,
                size: iconSize,
              ),
              label: Text(label, style: styleLabelButton),
              onPressed: onPressed,
              style: buttonsStyles(context),
            )
          : ElevatedButton(
              child: Text(
                label,
                style: styleLabelButton,
              ),
              style: buttonsStyles(context),
              onPressed: onPressed,
            ),
    );
  }

  buttonsStyles(BuildContext context) {
    return ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      shape: const StadiumBorder(),
      primary: backgroundColorButton,
      side: BorderSide(
        width: .8,
        color: buttonBorderColor,
      ),
    );
  }
}
