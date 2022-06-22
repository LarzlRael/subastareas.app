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
  'uploadHomework': (_) => const UploadHomeworkPage(),
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
  'filter': (_) => const FilterPage(),
  'store_page': (_) => const StorePage(),
  'public_profile_page': (_) => const PublicProfilePage(),
};
