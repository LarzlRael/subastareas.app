part of '../pages.dart';

class SlideshowPage extends StatelessWidget {
  const SlideshowPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final prefs = UserPreferences();

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
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
                    SlidePage(
                        assetImage: 'assets/svg/slide-1.svg',
                        title: "¿Bloqueado y con muchas prácticas?",
                        subtitle:
                            "En nivel de dificultad no es un problema en subastareas"),
                    SlidePage(
                        assetImage: 'assets/svg/slide-2.svg',
                        title: "¿Sabes la respuesta?",
                        subtitle:
                            "Ayuda con la tarea propuesta y gana dinero por ello"),
                    SlidePage(
                        assetImage: 'assets/svg/slide-3.svg',
                        title: "Tareas de todas las materias",
                        subtitle:
                            "Porque enseñar también es una manera de aprender"),
                  ],
                ),
              ),
              /* Expanded(
                child: Slideshow(
                  primaryColor: Colors.blue,
                  secondaryColor: Colors.blueGrey,
                  primaryBullet: 15.0,
                  secondaryBullet: 10.0,
                  slides: [
                    SvgPicture.asset('assets/svg/slide-1.svg'),
                    SvgPicture.asset('assets/svg/slide-2.svg'),
                    SvgPicture.asset('assets/svg/slide-3.svg'),
                  ],
                ),
              ), */
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
            ],
          ),
        ),
      ),
    );
  }
}
