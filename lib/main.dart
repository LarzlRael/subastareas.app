import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subastareaspp/provider/providers.dart';
import 'package:subastareaspp/routes/app_router.dart';
import 'package:subastareaspp/services/services.dart';
import 'package:subastareaspp/utils/utils.dart';

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
  @override
  void initState() {
    super.initState();
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
      child: MaterialApp.router(
        title: 'Subastareas',
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
        theme: appTheme.getTheme(),
        localizationsDelegates: formBuildersDelegates,
        supportedLocales: supportedLocales,
      ),
    );
  }
}
