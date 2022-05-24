part of 'widgets.dart';

class LabelLoginRegister extends StatelessWidget {
  final String title;
  final String subtitle;
  final String route;
  const LabelLoginRegister({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              'forgot_password',
            );
          },
          child: const SimpleText(
            text: 'Olvide mi contraseña',
            color: Colors.indigo,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, route);
          },
          child: Column(children: [
            SimpleText(
              text: title,
              color: Colors.indigo,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            SimpleText(
              text: subtitle,
              color: Colors.indigo,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ]),
        )
      ],
    );
  }
}
