import 'package:flutter/material.dart';
import 'package:subastareaspp/initialPresentation/SlideShow.dart';
import 'package:subastareaspp/initialPresentation/slideshow_page.dart';
import 'package:subastareaspp/pages/auction_page.dart';
import 'package:subastareaspp/pages/aution_with_offer.dart';
import 'package:subastareaspp/pages/home_page.dart';
import 'package:subastareaspp/pages/loading_page.dart';
import 'package:subastareaspp/pages/login_page.dart';
import 'package:subastareaspp/pages/make_offer_page.dart';
import 'package:subastareaspp/pages/register_page.dart';
import 'package:subastareaspp/pages/welcome_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  /* Register and login  */
  'login': (_) => LoginPage(),
  'register': (_) => RegisterPage(),
  'loading': (_) => LoadingPage(),
  'initialSlideShow': (_) => const SlideshowPage(),
  'welcome': (_) => WelcomePage(),
  'homePage': (_) => const HomePage(),
  'auctionPage': (_) => const AuctionPage(),
  'autionWithOffer': (_) => const AutionWithOffer(),
  'makeOffer': (_) => MakeOfferPage(),
};
