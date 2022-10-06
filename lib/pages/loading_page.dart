part of 'pages.dart';

class LoadingPage extends StatelessWidget {
  LoadingPage({Key? key}) : super(key: key);
  late AuthServices authServices;
  late SocketService socketService;
  @override
  Widget build(BuildContext context) {
    authServices = Provider.of<AuthServices>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (_, __) {
          return const SquareLoading();
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final isAuthenticated = await authServices.renewToken();
    /* final socketService = Provider.of<AuthServices>(context, listen: false); */

    if (isAuthenticated) {
      /* socketService.connect(); */
      goToPage(context, const BottomNavigation());
    } else {
      goToPage(context, const WelcomePage());
    }
  }
}
