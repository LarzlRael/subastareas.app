import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subastareaspp/provider/providers.dart';
import 'package:subastareaspp/routes/routes.dart';
import 'package:subastareaspp/services/services.dart';
import 'package:subastareaspp/utils/utils.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initializeApp();
  await UserPreferences.init();
  /* await Enviroment.initEnviroment(); */
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProviderNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    PushNotificationService.messagesStream.listen((message) {
      /* print('MyApp: $message'); */
      navigatorKey.currentState?.pushNamed('message', arguments: message);

      final snackBar = SnackBar(content: Text(message));
      messengerKey.currentState?.showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.watch<ThemeProviderNotifier>().appTheme;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthServices()),
        ChangeNotifierProvider(create: (_) => SocketService()),
        ChangeNotifierProvider(create: (_) => FilterProvider()),
        ChangeNotifierProvider(create: (_) => NotificationService()),
      ],
      child: MaterialApp(
        title: 'Subastareas',
        navigatorKey: navigatorKey, // Navegar
        scaffoldMessengerKey: messengerKey, // Snacks
        debugShowCheckedModeBanner: false,
        routes: appRoutes,
        initialRoute: 'loading',
        theme: appTheme.getTheme(),
        localizationsDelegates: formBuildersDelegates,
        supportedLocales: supportedLocales,
      ),
    );
  }
}
