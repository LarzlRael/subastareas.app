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
    required this.appBar,
    Key? key,
    this.fontSize = 25,
    this.title = 'Subastareas',
    this.actions,
  }) : super(key: key);
  final double fontSize;
  final String title;
  final AppBar appBar;
  final List<Widget>? actions;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      actions: actions,
      elevation: 5,
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
        const SizedBox(width: 10),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall,
        )
        /* SimpleText(
          left: 10,
          text: title,
          /* color: Colors.black, */
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          setUniqueColor: true,
          lightThemeColor: Colors.black,
        ), */
      ],
    );
  }
}
