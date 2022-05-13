import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:subastareaspp/routes/routes.dart';
import 'package:subastareaspp/servives/auth_services.dart';
import 'package:subastareaspp/utils/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final prefs = UserPreferences();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final prefs = UserPreferences();
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthServices()),
      ],
      child: MaterialApp(
        title: 'Subastareas',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        /* home: SlideshowPage(), */
        routes: appRoutes,
        /* initialRoute: prefs.showInitialSlider ? 'initialSlideShow' : 'welcome', */
        initialRoute: 'homePage',
        localizationsDelegates: [
          FormBuilderLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en', ''),
          Locale('es', ''),
          Locale('fr', ''),
          Locale('ja', ''),
          Locale('pt', ''),
        ],
      ),
    );
  }
}
