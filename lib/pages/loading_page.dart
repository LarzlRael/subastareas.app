part of 'pages.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return Center(
            child: FittedBox(
              child: Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.black45,
                  border: Border.all(),
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                ),
                child: Column(
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(height: 10),
                    Text('Cargando ...', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthServices>(context, listen: false);
    final autenticado = await authService.isLoggenIn();
    /* final socketService = Provider.of<AuthServices>(context, listen: false); */

    if (autenticado) {
      /* socketService.connect(); */
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => BottomNavigation(),
          transitionDuration: const Duration(milliseconds: 0),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => WelcomePage(),
          transitionDuration: const Duration(milliseconds: 0),
        ),
      );
    }
  }
}
