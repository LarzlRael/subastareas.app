part of '../widgets.dart';

class NoInformation extends StatelessWidget {
  final IconData icon;
  final String message;
  final bool showButton;
  final String? buttonTitle;
  final VoidCallback? onPressed;
  final IconData iconButton;

  const NoInformation({
    Key? key,
    required this.icon,
    required this.message,
    required this.showButton,
    required this.iconButton,
    this.buttonTitle,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      /* color: Colors.yellow, */
      padding: const EdgeInsets.all(40),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 150),
            const SizedBox(height: 15),
            Text(message),
            const SizedBox(height: 15),
            showButton
                ? Row(
                    /* mainAxisAlignment: MainAxisAlignment.center, */
                    children: [
                      Expanded(
                        child: ButtonWithIcon(
                          label: buttonTitle ?? '',
                          icon: iconButton,
                          /* buttonBorderPrimary: true, */
                          onPressed: onPressed!,
                        ),
                      ),
                    ],
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
