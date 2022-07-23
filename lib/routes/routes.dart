import 'package:flutter/material.dart';
import 'package:subastareaspp/models/models.dart';
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
  'autionWithOfferPage': (_) => AutionWithOfferPage(
        args: ModalRoute.of(_)?.settings.arguments as OneHomeworkModel,
      ),
  'makeOffer': (_) => const MakeOfferPage(),
  'listOpenHomeworks': (_) => const ListOpenHomeworksPage(),
  'showHomework': (_) => const ShowHomework(),
  'profile': (_) => const ProfilePage(),
  'forgot_password': (_) => const ForgotPassword(),
  'notifications': (_) => const NotificationPage(),
  'filter': (_) => const FilterPage(),
  'store_page': (_) => const StorePage(),
  'public_profile_page': (_) => const PublicProfilePage(),
  'upload_homework_only_text': (_) => UploadHomeworkOnlyText(),
  'upload_homework_with_file': (_) => UploadHomeworkWithFile(),
  'my_homeworks_page': (_) => const MyHomeworksPage(),
  'upload_homework_offered_page': (_) => UploadHomeworkOfferedPage(),
  'verify_homework_resolved': (_) => VerifyHomeworkResolved(),
};
