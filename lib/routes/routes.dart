import 'package:flutter/material.dart';
import 'package:subastareaspp/widgets/widgets.dart';

import '../pages/pages.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  /* Register and login  */
  'login': (_) => LoginPage(),
  'register': (_) => RegisterPage(),
  'bottomNavigation': (_) => const BottomNavigation(),
  'loading': (_) => const LoadingPage(),
  'welcome': (_) => const WelcomePage(),
  'uploadHomework': (_) => UploadHomework(),
  'auctionPage': (context) => AuctionPage(
        args: ModalRoute.of(context)?.settings.arguments as HomeworkArguments,
      ),
  'autionWithOfferPage': (_) => const AutionWithOfferPage(),
  'makeOffer': (_) => const MakeOfferPage(),
  'listOpenHomeworks': (_) => const ListOpenHomeworksPage(),
  'showHomework': (_) => const ShowHomework(),
  'profile': (_) => const ProfilePage(),
  'forgot_password': (_) => const ForgotPassword(),
  'notifications': (_) => const NotificationPage(),
  'filter': (_) => FilterPage(),
  'store_page': (_) => StorePage(),
};
