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
    final style = Theme.of(context).textTheme.headlineSmall;
    return AppBar(
      elevation: 0,
      centerTitle: centerTitle,
      title: title != null
          ? /* SimpleText(
              text: title!,
              lightThemeColor: Colors.black,
              darkThemeColor: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ) */
          Text(title!, style: style)
          : null,
      leading: IconButton(
        icon: const Icon(
          Icons.chevron_left,
          size: 35,
        ),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
