part of '../pages.dart';

class SelectOption extends StatelessWidget {
  const SelectOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBackIcon(appBar: AppBar()),
      body: Column(
        children: [
          const SimpleText(
            text: 'Selecciona una opción',
            fontSize: 25,
            bottom: 30,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
            lightThemeColor: Colors.black87,
          ),
          Expanded(
            child: GridView.count(
              /* shrinkWrap: true, */
              /* physics: NeverScrollableScrollPhysics(), */
              crossAxisCount: 2,
              children: adminOptions(context).map((l) {
                return l;
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
