import 'package:flutter/material.dart';
import 'package:subastareaspp/initialPresentation/SlideShow.dart';
import 'package:subastareaspp/initialPresentation/slideshow_page.dart';
import 'package:subastareaspp/pages/loading_page.dart';
import 'package:subastareaspp/pages/login_page.dart';
import 'package:subastareaspp/pages/register_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  /* Register and login  */
  'login': (_) => LoginPage(),
  'register': (_) => RegisterPage(),

  'loading': (_) => LoadingPage(),
  'initialSlideShow': (_) => const SlideshowPage(),
};