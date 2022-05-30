part of 'pages.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthServices>(context, listen: true);
    return auth.isLogged ? MyProfilePage() : WelcomePage();
  }
}
