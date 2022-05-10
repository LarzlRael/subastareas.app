import 'package:flutter/material.dart';
import 'package:subastareaspp/initialPresentation/SlideShow.dart';
import 'package:subastareaspp/initialPresentation/slideshow_page.dart';
import 'package:subastareaspp/routes/routes.dart';
import 'package:subastareaspp/utils/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final prefs = UserPreferences();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      /* home: SlideshowPage(), */
      routes: appRoutes,
      initialRoute: prefs.showInitialSlider ? 'initialSlideShow' : 'loading',
    );
  }
}
