part of 'pages.dart';

class LoadingPageParameters extends StatelessWidget {
  const LoadingPageParameters({
    Key? key,
    this.future,
    required this.routeToRedirect,
  }) : super(key: key);
  final Future<dynamic>? future;
  final String routeToRedirect;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: redirect(context),
        builder: (context, snapshot) {
          return const SquareLoading();
        },
      ),
    );
  }

  Future redirect(BuildContext context) async {
    future;
    goToInitialPage(context, const BottomNavigation());
  }
}
