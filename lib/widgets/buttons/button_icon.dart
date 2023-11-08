part of 'buttons.dart';

class ButtonWithIcon extends StatelessWidget {
  final IconData? icon;
  final String label;
  final Color buttonBorderColor;
  final TextStyle styleLabelButton;

  final VoidCallback onPressed;
  final Color backgroundColorButton;
  final double verticalPadding;
  final double horizontalPadding;

  final double iconSize;

  final double marginHorizontal;
  final double marginVertical;
  const ButtonWithIcon({
    Key? key,
    this.icon,
    required this.label,
    this.backgroundColorButton = Colors.blue,
    this.buttonBorderColor = Colors.transparent,
    this.styleLabelButton = const TextStyle(color: Colors.white, fontSize: 14),
    this.verticalPadding = 5,
    this.iconSize = 24.0,
    this.marginHorizontal = 0,
    this.marginVertical = 0,
    this.horizontalPadding = 0,
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
          ? FilledButton.icon(
              icon: Icon(
                icon,
                size: iconSize,
              ),
              label: Text(label, style: styleLabelButton),
              onPressed: onPressed,
            )
          : ElevatedButton(
              onPressed: onPressed,
              child: Text(
                label,
                style: styleLabelButton,
              ),
            ),
    );
  }
}
