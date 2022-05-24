import 'package:flutter/material.dart';

import '../pages/pages.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'initialSlideShow': (_) => const SlideshowPage(),
  /* Register and login  */
  'login': (_) => RegisterPage(),
  'register': (_) => RegisterPage(),
  'bottomNavigation': (_) => const BottomNavigation(),
  'loading': (_) => LoadingPage(),
  'welcome': (_) => WelcomePage(),
  'homePage': (_) => const HomePage(),
  'auctionPage': (_) => const AuctionPage(),
  'autionWithOffer': (_) => const AutionWithOffer(),
  'makeOffer': (_) => MakeOfferPage(),
  'listOpenHomeworks': (_) => const ListOpenHomeworks(),
  'showHomework': (_) => const ShowHomework(),
  'profile': (_) => ProfilePage(),
};
