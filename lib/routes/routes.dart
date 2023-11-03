import 'package:flutter/material.dart';
import 'package:subastareaspp/models/models.dart';
import 'package:subastareaspp/widgets/widgets.dart';

import '../pages/pages.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  /* Register and login  */
  'login': (_) => const LoginPage(),
  'register': (_) => RegisterPage(),
  /* 'bottomNavigation': (context) => BottomNavigation(
        currentIndex: ModalRoute.of(context)!.settings.arguments as int,
      ), */
  'bottomNavigation': (context) => const BottomNavigation(),
  'loading': (_) => LoadingPage(),
  'welcome': (_) => const WelcomePage(),
  'uploadHomework': (_) => const UploadHomeworkPage(),
  'auctionPage': (context) => HomeworkdDetailPage(
        idHomework: ModalRoute.of(context)?.settings.arguments as int,
      ),
  'auctionWithOfferPage': (_) => AuctionWithOfferPage(
        oneHomework: ModalRoute.of(_)?.settings.arguments as OneHomeworkModel,
      ),
  'makeOffer': (_) => const MakeOfferPage(),
  'listOpenHomeworks': (_) => const ListOpenHomeworksPage(),
  'showHomework': (_) => ShowHomework(
        homework: ModalRoute.of(_)?.settings.arguments as Homework,
      ),
  'show_homework_uploaded': (_) => ShowHomeworkUploaded(
        showHomeworkParams:
            ModalRoute.of(_)?.settings.arguments as ShowHomeworkParams,
      ),
  'profile': (_) => const ProfilePage(),
  'forgot_password': (_) => const ForgotPassword(),
  'verify_email_page': (_) => const VerifyEmailPage(),
  'notifications': (_) => const NotificationPage(),
  'filter': (_) => const FilterPage(),
  'store_page': (_) => const StorePage(),
  'public_profile_page': (BuildContext context) => PublicProfilePage(
        userId: ModalRoute.of(context)?.settings.arguments as int,
      ),
  /* 'upload_homework_only_text': (BuildContext context) => UploadHomeworkOnlyText(
        authService: ModalRoute.of(context)?.settings.arguments as AuthServices,
      ), */
  'upload_homework_with_file': (BuildContext context) => UploadHomeworkWithFile(
        homework: ModalRoute.of(context)?.settings.arguments as Homework,
      ),
  'my_homeworks_page': (BuildContext context) => MyHomeworksPage(
        goToPage: ModalRoute.of(context)?.settings.arguments as int,
      ),
  'pending_homeworks_offers_accepts': (_) =>
      const PendingHomeworksOffersAccepts(),
  'change_password': (_) => const ChangePassword(),
  /* 'upload_homework_offered_page': (_) => const UploadHomeworkOfferedPage(), */
  'verify_homework_resolved': (_) => const VerifyHomeworkResolved(),
  'withdraw_page': (_) => const WithdrawPage(),
  /* 'withdraw_method_selected_page': (_) => const WithdrawMethodSelectedPage(), */
  /* Admin pages */
  'supervisor_list_homeworks': (_) => const SupervisorListHomeworks(),
  'list_withdraw_request': (_) => const ListWithdrawRequest(),
  'withdraw_request_detail': (_) => const WithdrawRequestDetail(),
  'select_option': (_) => const SelectOption(),
};
