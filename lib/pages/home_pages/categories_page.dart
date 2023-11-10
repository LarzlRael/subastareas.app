part of '../pages.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
/*       body: Stack(
        children: [ */
        /* _fondoApp(), */
        body: Column(
      children: [
        _titulos(),

        /* _roundedButtons(), */
        Expanded(
          child: GridView.count(
              /* shrinkWrap: true, */
              /* physics: NeverScrollableScrollPhysics(), */
              crossAxisCount: 2,
              children: adminOptions(context).map((category) {
                return (category);
              }).toList()),
        ),
      ],
    ));
  }

  /* Widget _fondoApp() {
    final gradiente = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: FractionalOffset(0.0, 0.6),
            end: FractionalOffset(0.0, 1.0),
            colors: [
              Color.fromRGBO(52, 54, 101, 1),
              Color.fromRGBO(35, 37, 57, 1),
            ]),
      ),
    );

    final pinkBox = Transform.rotate(
      angle: -pi / 5.0,
      child: Container(
        height: 360.0,
        width: 360.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80.0),
          color: Colors.pink,
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(236, 98, 188, 1.0),
              Color.fromRGBO(241, 142, 172, 1.0),
            ],
          ),
        ),
      ),
    );

    return Stack(
      children: [
        gradiente,
        Positioned(
          top: -100.0,
          child: pinkBox,
        ),
      ],
    );
  } */
  Widget _titulos() {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SimpleText(
                  text: "Buscar categoria",
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            SizedBox(height: 10.0),
            SimpleText(
              text: "Buscar por las distintas categorias",
              fontSize: 18.0,
            ),
          ],
        ),
      ),
    );
  }
}
