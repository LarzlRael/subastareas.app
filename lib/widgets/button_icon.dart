part of 'widgets.dart';

class ButtonWithIcon extends StatelessWidget {
  final IconData? icon;
  final String label;
  final Color buttonBorderColor;
  final TextStyle styleLabelButton;

  final VoidCallback onPressed;
  final Color backgroundColorButton;

  ButtonWithIcon(
      {this.icon,
      required this.label,
      required this.backgroundColorButton,
      this.buttonBorderColor = Colors.transparent,
      this.styleLabelButton =
          const TextStyle(color: Colors.white, fontSize: 16),
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      /* padding: EdgeInsets.symmetric(horizontal: 5),
      color: Colors.amber, */
      /* width: double.infinity, */
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: icon != null
            ? TextButton.icon(
                icon: Icon(icon, color: Colors.white),
                label: Text(label, style: styleLabelButton),
                onPressed: onPressed,
                style: buttonsStyles(context),
              )
            : ElevatedButton(
                child: Text(label, style: styleLabelButton),
                style: buttonsStyles(context),
                onPressed: onPressed,
              ),
      ),
    );
  }

  buttonsStyles(BuildContext context) {
    return ElevatedButton.styleFrom(
      shape: StadiumBorder(),
      primary: backgroundColorButton,
      side: BorderSide(
        width: .8,
        color: buttonBorderColor,
      ),
    );
  }
}
