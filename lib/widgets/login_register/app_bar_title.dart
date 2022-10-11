part of '../widgets.dart';

/* class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    Key? key,
    this.fontSize = 25,
    this.title = 'Subastareas',
  }) : super(key: key);
  final double fontSize;
  final String title;
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
          text: title,
          /* color: Colors.black, */
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }
} */

class AppBarTitle extends StatelessWidget implements PreferredSizeWidget {
  const AppBarTitle({
    Key? key,
    this.fontSize = 25,
    this.title = 'Subastareas',
    required this.appBar,
  }) : super(key: key);
  final double fontSize;
  final String title;
  final AppBar appBar;
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return AppBar(
      centerTitle: true,
      backgroundColor: theme.isDarkTheme ? Colors.transparent : Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: OnlyImageAndTitle(title: title, fontSize: fontSize),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}

class OnlyImageAndTitle extends StatelessWidget {
  const OnlyImageAndTitle({
    Key? key,
    this.title = 'Subastareas',
    this.fontSize = 25,
  }) : super(key: key);

  final String title;
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
          text: title,
          /* color: Colors.black, */
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }
}
