part of 'pages.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authServices = context.read<AuthServices>();
    final socketService = context.read<SocketService>();
    final theme = context.read<ThemeProviderNotifier>();
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context, authServices, socketService, theme),
        builder: (_, __) {
          return const SquareLoading();
        },
      ),
    );
  }

  Future checkLoginState(
    BuildContext context,
    AuthServices authServices,
    SocketService socketService,
    ThemeProviderNotifier theme,
  ) async {
    final isAuthenticated = await authServices.renewToken();
    if (isAuthenticated) {
      socketService.connect();
      /* theme.setDarkTheme = authServices.user.userProfile.isDarkTheme; */
      authServices.user.userProfile.isDarkTheme
          ? theme.changeToDarkTheme()
          : theme.changeToLightTheme();
      goToInitialPage(context, const BottomNavigation());
    } else {
      goToInitialPage(context, const WelcomePage());
    }
  }
}
