import 'package:flutter/material.dart';

import '../pages/pages.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  /* Register and login  */
  'login': (_) => LoginPage(),
  'register': (_) => RegisterPage(),
  'bottomNavigation': (_) => const BottomNavigation(),
  'loading': (_) => LoadingPage(),
  'welcome': (_) => WelcomePage(),
  'homePage': (_) => const UploadHomework(),
  'auctionPage': (_) => const AuctionPage(),
  'autionWithOffer': (_) => const AutionWithOffer(),
  'makeOffer': (_) => MakeOfferPage(),
  'listOpenHomeworks': (_) => const ListOpenHomeworks(),
  'showHomework': (_) => const ShowHomework(),
  'profile': (_) => ProfilePage(),
  'forgot_password': (_) => ForgotPassword(),
  'notifications': (_) => NotificationPage(),
  'filter': (_) => FilterPage(),
};
