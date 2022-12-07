part of '../widgets.dart';

class AppBarWithBackIcon extends StatelessWidget
    implements PreferredSizeWidget {
  final AppBar appBar;
  final String? title;
  final bool centerTitle;
  const AppBarWithBackIcon({
    Key? key,
    required this.appBar,
    this.centerTitle = false,
    this.title,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return AppBar(
      elevation: 0,
      centerTitle: centerTitle,
      backgroundColor: theme.isDarkTheme ? Colors.transparent : Colors.white,
      title: title != null
          ? SimpleText(
              text: title!,
              lightThemeColor: Colors.black,
              darkThemeColor: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )
          : null,
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
