part of '../widgets.dart';

class GenericListTile extends StatelessWidget {
  const GenericListTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.initialValue,
    required this.onChanged,
  }) : super(key: key);
  final String title;
  final IconData icon;
  final bool initialValue;
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Switch(
        value: initialValue,
        onChanged: (value) {
          onChanged(value);
        },
      ),
      onTap: () {
        /* auth.logout(); */
      },
    );
  }
}
