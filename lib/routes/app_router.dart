import 'package:go_router/go_router.dart';
import 'package:subastareaspp/models/models.dart';
import 'package:subastareaspp/widgets/widgets.dart';

import '../pages/pages.dart';

final appRouter = GoRouter(
  initialLocation: '/loading',
  /* refreshListenable: goRouterNotifier, */
  routes: [
    ///* Primera pantalla

    GoRoute(
      path: '/',
      builder: (_, __) => const LoadingPage(),
    ),
    GoRoute(
      path: '/loading',
      builder: (_, __) => const LoadingPage(),
    ),
    GoRoute(
      path: '/welcome_page',
      builder: (_, __) => const WelcomePage(),
    ),
    GoRoute(
      path: '/login_page',
      builder: (_, __) => const LoginPage(),
    ),

    GoRoute(
      path: '/forgot_password',
      builder: (_, __) => const ForgotPassword(),
    ),

    GoRoute(
      path: '/verify_email_page',
      builder: (_, __) => const VerifyEmailPage(),
    ),
    GoRoute(
      path: '/register_page',
      builder: (_, __) => const RegisterPage(),
    ),
    GoRoute(
      path: '/home_page',
      builder: (_, __) => const BottomNavigation(),
    ),
    GoRoute(
      path: '/homework_detail/:id',
      builder: (_, state) {
        return HomeworkdDetailPage(
          idHomework: int.parse(state.pathParameters['id']!),
        );
      },
    ),

    GoRoute(
      path: '/upload_homework_with_file',
      builder: (_, state) {
        Homework? homework = state.extra as Homework?;
        return UploadHomeworkWithFile(
          homework: homework,
        );
      },
    ),
    /* 'upload_homework_offered_page': (_) => const UploadHomeworkOfferedPage(), */
    GoRoute(
      path: '/upload_homework_offered_page',
      builder: (_, state) {
        HomeworkArguments sample = state.extra as HomeworkArguments;
        return UploadHomeworkOfferedPage(
          homeworkArguments: sample,
        );
      },
    ),

    GoRoute(
      path: '/my_homeworks_page',
      builder: (_, state) {
        int? sample = state.extra as int?;
        return MyHomeworksPage(
          goToPage: sample!,
        );
      },
    ),
    GoRoute(
      path: '/auction_with_offerPage/:idHomework',
      builder: (context, state) {
        /* OneHomeworkModel params = state.extra as OneHomeworkModel; */
        final idHomework = int.parse(state.pathParameters['idHomework']!);
        return AuctionWithOfferPage(
          idHomework: idHomework,
        );
      },
    ),
    GoRoute(
      path: '/makeOffer',
      builder: (context, state) {
        final OneHomeworkModel oneHomeworkModel =
            state.extra as OneHomeworkModel;
        return MakeOfferPage(
          oneHomework: oneHomeworkModel,
        );
      },
    ),
    /* 'verify_homework_resolved': (_) => const VerifyHomeworkResolved(), */
    GoRoute(
      path: '/verify_homework_resolved',
      builder: (context, state) {
        TradeUserModel tradeUserModel = state.extra as TradeUserModel;
        return VerifyHomeworkResolved(
          tradeUserModel: tradeUserModel,
        );
      },
    ),
    GoRoute(
      path: '/public_profile_page/:idUser',
      builder: (context, state) {
        final idUser = int.parse(state.pathParameters['idUser']!);
        return PublicProfilePage(
          userId: idUser,
        );
      },
    ),

    GoRoute(
      path: '/store_page',
      builder: (_, __) => const StorePage(),
    ),

    GoRoute(
      path: '/change_password',
      builder: (_, __) => const ChangePassword(),
    ),

    GoRoute(
      path: '/withdraw_page',
      builder: (_, __) => const WithdrawPage(),
    ),
    /* 'withdraw_method_selected_page': (_) => const WithdrawMethodSelectedPage(), */
    GoRoute(
      path: '/withdraw_method_selected_page',
      builder: (_, state) {
        final MethodArguments args = state.extra as MethodArguments;
        return WithdrawMethodSelectedPage(
          arguments: args,
        );
      },
    ),

    GoRoute(
      path: '/show_homework_uploaded',
      builder: (_, state) {
        final ShowHomeworkParams args = state.extra as ShowHomeworkParams;
        return ShowHomeworkUploaded(
          showHomeworkParams: args,
        );
      },
    ),
    GoRoute(
        path: '/supervisor_list_homeworks',
        builder: (_, __) => const SupervisorListHomeworks()),

    GoRoute(
        path: '/list_withdraw_request',
        builder: (_, __) => const ListWithdrawRequest()),
    GoRoute(
        path: '/show_homework',
        builder: (_, state) {
          final Homework homework = state.extra as Homework;
          return ShowHomework(
            homework: homework,
          );
        }),
    GoRoute(
        path: '/withdraw_request_detail',
        builder: (_, state) {
          final WithdrawalRequestsModel args =
              state.extra as WithdrawalRequestsModel;
          return WithdrawRequestDetail(
            withdrawRequest: args,
          );
        }),
    GoRoute(path: '/select_option', builder: (_, __) => const SelectOption()),
  ],
); /* 'withdraw_request_detail': (_) => const WithdrawRequestDetail(), */
