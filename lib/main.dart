import 'package:flutter/material.dart';
import 'package:subastareaspp/initialPresentation/SlideShow.dart';
import 'package:subastareaspp/initialPresentation/slideshow_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SlideshowPage(),
    );
  }
}
