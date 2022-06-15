part of '../pages.dart';

class PublicProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 23,
      fontWeight: FontWeight.bold,
    );
    final auth = Provider.of<AuthServices>(context, listen: true);
    return Scaffold(
      //hexadecimal background color
      backgroundColor: const Color(0xFFD9D9D9),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Column(
            /* crossAxisAlignment: CrossAxisAlignment.center, */
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProfileCardWithStars(
                auth: auth,
                backgroundColor: Colors.black,
              ),
              information(),
              information(),
              information(),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 15,
                child: Container(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    children: [
                      SimpleText(
                        text: 'Trayectoria en subastareas',
                        style: textStyle,
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(Icons.breakfast_dining),
                          SimpleText(
                              text: 'Trabajos resueltos: ', style: textStyle),
                          SimpleText(text: '0', style: textStyle),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 15,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    children: [
                      SimpleText(
                        text: 'Biografia',
                        style: textStyle,
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget information() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Ionicons.checkmark_circle,
          color: Colors.lightGreen,
          size: 35,
        ),
        SimpleText(
          left: 10,
          fontSize: 20,
          text: 'Identidad verificada',
          fontWeight: FontWeight.bold,
        )
      ],
    ),
  );
}
