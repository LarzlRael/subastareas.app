part of '../pages.dart';

class WelcomePage extends StatelessWidget {
  final bool showNotNow;
  const WelcomePage({
    Key? key,
    this.showNotNow = true,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 32),
                child: Image.asset(
                  'assets/logo_with_letters.png',
                  fit: BoxFit.contain,
                  width: 250,
                ),
              ),
              const Expanded(
                child: Slideshow(
                  primaryColor: Colors.blue,
                  secondaryColor: Colors.blueGrey,
                  primaryBullet: 15.0,
                  secondaryBullet: 10.0,
                  slides: [
                    SlideItem(
                        assetImage: 'assets/svg/slide-1.svg',
                        title: "¿Bloqueado y con muchas prácticas?",
                        subtitle:
                            "En nivel de dificultad no es un problema en subastareas"),
                    SlideItem(
                        assetImage: 'assets/svg/slide-2.svg',
                        title: "¿Sabes la respuesta?",
                        subtitle:
                            "Ayuda con la tarea propuesta y gana dinero por ello"),
                    SlideItem(
                        assetImage: 'assets/svg/slide-3.svg',
                        title: "Tareas de todas las materias",
                        subtitle:
                            "Porque enseñar también es una manera de aprender"),
                  ],
                ),
              ),
              FillButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'login');
                },
                text: 'Iniciar sesion',
                textColor: Colors.white,
                backgroundColor: Colors.amber,
              ),
              FillButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'register');
                },
                ghostButton: true,
                text: 'Registrarse',
                backgroundColor: Colors.blue,
              ),
              showNotNow
                  ? TextOnTap(
                      text: const SimpleText(
                        text: 'No ahora',
                        fontSize: 16,
                        color: Colors.indigo,
                        top: 10,
                        bottom: 10,
                      ),
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, 'bottomNavigation');
                      },
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
