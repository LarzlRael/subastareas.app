part of 'pages.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  late AuthProvider authServices;
  late SocketService socketService;
  late ThemeProviderNotifier theme;
  late NotificationProvider notificationProvider;
  @override
  initState() {
    super.initState();
    authServices = context.read<AuthProvider>();
    socketService = context.read<SocketService>()..connect();
    theme = context.read<ThemeProviderNotifier>();
    notificationProvider = context.read<NotificationProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(),
        builder: (_, __) => const SquareLoading(),
      ),
    );
  }

  Future checkLoginState() async {
    authServices.renewToken().then((value) {
      if (value) {
        /* theme.setDarkTheme = authServices.user.userProfile.isDarkTheme; */
        notificationProvider.setIsSeenNotificationOption();
        authServices.user.userProfile.isDarkTheme
            ? theme.changeToDarkTheme()
            : theme.changeToLightTheme();

        context.go('/home_page');
      } else {
        context.go('/welcome_page');
      }
    });
  }
}
