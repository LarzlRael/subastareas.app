part of '../pages.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
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
              children: categoryList.map((category) {
                return (category);
              }).toList()),
        ),
      ],
    ));
  }

  Widget _fondoApp() {
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
  }

  Widget _titulos() {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                SimpleText(
                  text: "Buscar categoria",
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            const SimpleText(
              text: "Buscar por las distintas categorias",
              fontSize: 18.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _roundedButtons() {
    return Expanded(
      child: GridView.count(
          /* shrinkWrap: true, */
          /* physics: NeverScrollableScrollPhysics(), */
          crossAxisCount: 2,
          children: [
            /* 
    Matematica
    Programación
    Fisica
    Quimica
    Algebra
    Trigonometria
    Geometria 
     */
          ]),
    );
  }
}
