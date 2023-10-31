import 'package:go_router/go_router.dart';
import 'package:subastareaspp/models/models.dart';

import '../pages/pages.dart';

final appRouter = GoRouter(
  initialLocation: '/loading',
  /* refreshListenable: goRouterNotifier, */
  routes: [
    ///* Primera pantalla

    GoRoute(
      path: '/',
      builder: (context, state) => const LoadingPage(),
    ),
    GoRoute(
      path: '/loading',
      builder: (context, state) => const LoadingPage(),
    ),
    GoRoute(
      path: '/welcome_page',
      builder: (context, state) => const WelcomePage(),
    ),
    GoRoute(
      path: '/login_page',
      builder: (context, state) => const LoginPage(),
    ),

    GoRoute(
      path: '/verify_email_page',
      builder: (context, state) => const VerifyEmailPage(),
    ),
    GoRoute(
      path: '/register_page',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: '/home_page',
      builder: (context, state) => const BottomNavigation(),
    ),
    GoRoute(
      path: '/homework_detail/:id',
      builder: (context, state) {
        return HomeworkdDetailPage(
          idHomework: int.parse(state.pathParameters['id']!),
        );
      },
    ),

    GoRoute(
      path: '/upload_homework_with_file',
      builder: (context, state) {
        Homework? sample = state.extra as Homework?;
        return UploadHomeworkWithFile(
          homework: sample,
        );
      },
    ),
    /* 'my_homeworks_page': (BuildContext context) => MyHomeworksPage(
        goToPage: ModalRoute.of(context)?.settings.arguments as int,
      ), */
    GoRoute(
      path: '/my_homeworks_page',
      builder: (context, state) {
        int? sample = state.extra as int?;
        return MyHomeworksPage(
          goToPage: sample!,
        );
      },
    ),
    GoRoute(
      path: '/auction_with_offerPage',
      builder: (context, state) {
        OneHomeworkModel params = state.extra as OneHomeworkModel;
        return AuctionWithOfferPage(
          oneHomework: params,
        );
      },
    ),
    GoRoute(
      path: '/makeOffer',
      builder: (context, state) => const MakeOfferPage(),
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
        path: '/show_homework',
        builder: (context, state) {
          final Homework homework = state.extra as Homework;
          return ShowHomework(
            homework: homework,
          );
        }),
  ],
);
