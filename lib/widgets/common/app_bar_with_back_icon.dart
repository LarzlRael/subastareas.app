part of '../widgets.dart';

class AppBarWithBackIcon extends StatelessWidget
    implements PreferredSizeWidget {
  final AppBar appBar;

  const AppBarWithBackIcon({Key? key, required this.appBar}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return AppBar(
      elevation: 0,
      backgroundColor: theme.isDarkTheme ? Colors.transparent : Colors.white,
      leading: IconButton(
        icon: Icon(
          Icons.chevron_left,
          color: theme.isDarkTheme ? Colors.white : Colors.black,
          size: 35,
        ),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
