import 'package:flutter/material.dart';

import '../pages/pages.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  /* Register and login  */
  'login': (_) => LoginPage(),
  'register': (_) => RegisterPage(),
  'bottomNavigation': (_) => const BottomNavigation(),
  'loading': (_) => LoadingPage(),
  'welcome': (_) => WelcomePage(),
  'uploadHomework': (_) => const UploadHomework(),
  'auctionPage': (context) => AuctionPage(
        args: ModalRoute.of(context)?.settings.arguments as int,
      ),
  'autionWithOfferPage': (_) => const AutionWithOfferPage(),
  'makeOffer': (_) => MakeOfferPage(),
  'listOpenHomeworks': (_) => const ListOpenHomeworksPage(),
  'showHomework': (_) => const ShowHomework(),
  'profile': (_) => ProfilePage(),
  'forgot_password': (_) => ForgotPassword(),
  'notifications': (_) => NotificationPage(),
  'filter': (_) => FilterPage(),
  'store_page': (_) => StorePage(),
};
