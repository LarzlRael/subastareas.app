part of '../widgets.dart';

class MenuProfileOption extends StatelessWidget {
  final String title;
  final Widget page;
  final IconData icon;
  final Future<bool>? onPressed;
  final bool showTrailing;
  const MenuProfileOption({
    Key? key,
    required this.title,
    required this.page,
    required this.icon,
    this.showTrailing = false,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        onTap: () async {
          if (onPressed != null) {
            await onPressed!;
            print('close sesion');
          } else {
            Navigator.push(context,
                PageTransition(type: PageTransitionType.fade, child: page));
          }
        },
        trailing: Icon(showTrailing ? Icons.lock_clock : Icons.chevron_right),
        leading: Icon(icon),
        title: Text(title),
      ),
    );
  }
}
