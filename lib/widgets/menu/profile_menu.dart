part of '../widgets.dart';

class MenuProfileOption extends StatelessWidget {
  final String title;
  final Widget page;
  final Widget icon;
  final bool showTrailing;
  final bool showTrailingIcon;
  final bool closeSession;
  final bool showBadge;
  final Widget? badgeChild;
  final Future<dynamic> Function()? callback;
  const MenuProfileOption({
    Key? key,
    required this.title,
    required this.page,
    required this.icon,
    this.showBadge = false,
    this.showTrailing = false,
    this.showTrailingIcon = true,
    this.closeSession = false,
    this.callback,
    this.badgeChild,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthServices>(context);
    final filterProvider = Provider.of<FilterProvider>(context);
    final socketProvider = Provider.of<SocketService>(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: closeSession ? Colors.red : null,
        elevation: 3,
        child: ListTile(
            onTap: () async {
              if (closeSession) {
                await auth.logout();
                filterProvider.setCurrentBottomTab = 0;
                socketProvider.disconnect();
                Navigator.pushNamed(context, 'loading');
              } else {
                if (!showTrailing) {
                  Navigator.push(
                    context,
                    PageTransition(type: PageTransitionType.fade, child: page),
                  );
                  if (callback != null) {
                    await callback!();
                  }
                } else {
                  GlobalSnackBar.show(context, 'Proximamente!');
                }
              }
            },
            trailing: showTrailingIcon
                ? Icon(
                    showTrailing ? Icons.lock_clock : Icons.chevron_right,
                    /* color: color, */
                  )
                : null,
            leading: showBadge
                ? badges.Badge(
                    badgeContent: badgeChild,
                    child: icon,
                  )
                : icon,
            title: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: closeSession ? Colors.white : null),
            )
            /* SimpleText(
            text: title,
            fontSize: 15,
            fontWeight: FontWeight.bold,
            setUniqueColor: false,
            /* lightThemeColor: closeSession ? Colors.white : Colors.black87, */
          ), */
            ),
      ),
    );
  }
}
