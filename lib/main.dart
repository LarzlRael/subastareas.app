import 'package:flutter/material.dart';
import 'package:subastareaspp/initialPresentation/SlideShow.dart';
import 'package:subastareaspp/initialPresentation/slideshow_page.dart';
import 'package:subastareaspp/routes/routes.dart';
import 'package:subastareaspp/utils/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = UserPreferences();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final prefs = UserPreferences();
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(prefs.showInitialSlider);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      /* home: SlideshowPage(), */
      routes: appRoutes,
      initialRoute: prefs.showInitialSlider ? 'initialSlideShow' : 'welcome',
    );
  }
}
