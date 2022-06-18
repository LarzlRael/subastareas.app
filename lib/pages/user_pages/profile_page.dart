part of '../pages.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthServices>(context, listen: true);
    return auth.isLogged
        ? MyProfilePage()
        : WelcomePage(
            showNotNow: false,
          );
  }
}
