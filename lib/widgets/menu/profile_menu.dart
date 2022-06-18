part of '../widgets.dart';

class MenuProfileOption extends StatelessWidget {
  final String title;
  final Widget page;
  final IconData icon;
  final bool showTrailing;
  final bool showTrailingIcon;
  final bool closeSession;

  const MenuProfileOption({
    Key? key,
    required this.title,
    required this.page,
    required this.icon,
    this.showTrailing = false,
    this.showTrailingIcon = true,
    this.closeSession = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = !closeSession ? Colors.black87 : Colors.white;
    final auth = Provider.of<AuthServices>(context);
    final filterProvider = Provider.of<FilterProvider>(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: closeSession ? Colors.red : Colors.white,
        elevation: 5,
        child: ListTile(
          onTap: () async {
            if (closeSession) {
              auth.logout();
              filterProvider.setCurrentBottomTab = 0;
            } else {
              if (!showTrailing) {
                Navigator.push(
                  context,
                  PageTransition(type: PageTransitionType.fade, child: page),
                );
              } else {
                GlobalSnackBar.show(context, 'Proximamente!');
              }
            }
          },
          trailing: showTrailingIcon
              ? Icon(
                  showTrailing ? Icons.lock_clock : Icons.chevron_right,
                  color: color,
                )
              : null,
          leading: Icon(icon, color: color),
          title: SimpleText(
            text: title,
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }
}
