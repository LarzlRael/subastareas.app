part of 'pages.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthServices>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);
    final theme = Provider.of<ThemeChanger>(context, listen: false);
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context, authServices, socketService, theme),
        builder: (_, __) {
          return const SquareLoading();
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context, AuthServices authServices,
      SocketService socketService, ThemeChanger theme) async {
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
