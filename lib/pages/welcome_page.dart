part of 'pages.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: 200,
                    height: 200,
                    child: Image.asset('assets/icon.png')),
                const SimpleText(
                  text: 'Subastareas',
                  fontSize: 24,
                  top: 16,
                  bottom: 16,
                  fontWeight: FontWeight.bold,
                ),
                const SimpleText(
                  text:
                      'Si no sabes bien lo que haces, estas en el lugar correcto',
                  fontSize: 16,
                  textAlign: TextAlign.center,
                  color: Colors.black54,
                  bottom: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ButtonWithIcon(
                      label: 'Iniciar sesión',
                      /* icon: (Ionicons.paper_plane), */
                      backgroundColorButton: Colors.indigo,
                      onPressed: () => {
                        /* Navigator.pushNamed(context, 'sendPage'); */
                        Navigator.pushNamed(context, 'login'),
                      },
                    ),
                    ButtonWithIcon(
                      label: 'Registrarse',
                      /* icon: Ionicons.qr_code, */
                      buttonBorderColor: Colors.black38,
                      backgroundColorButton: Colors.white,
                      styleLabelButton: const TextStyle(color: Colors.black),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          'register',
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
