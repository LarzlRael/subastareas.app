part of 'pages.dart';

class LoadingPage extends StatelessWidget {
  LoadingPage({Key? key}) : super(key: key);
  late AuthServices authServices;
  late SocketService socketService;
  late ThemeChanger theme;
  @override
  Widget build(BuildContext context) {
    authServices = Provider.of<AuthServices>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    theme = Provider.of<ThemeChanger>(context, listen: false);
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
    if (isAuthenticated) {
      socketService.connect();
      theme.setDarkTheme = authServices.user.userProfile.isDarkTheme;
      goToInitialPage(context, const BottomNavigation());
    } else {
      goToInitialPage(context, const WelcomePage());
    }
  }
}
