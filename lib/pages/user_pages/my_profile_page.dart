part of '../pages.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  late final AuthServices auth;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthServices>(context, listen: true);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              CardProfile(auth: auth),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /* ProfileCard(),
                  ProfileCard(), */
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              /* BellIconNotification(), */
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: menuProfileOptions.length,
                  itemBuilder: (
                    BuildContext context,
                    int index,
                  ) {
                    return menuProfileOptions[index];
                  },
                ),
              ),
              /* MenuProfileOption(
                icon: Icons.question_answer,
                title: "Cerrar sesión",
                page: WalletPage(),
                onPressed: () async {
                  await auth.logout();
                  GoogleSignInServices.signOut();
                },
              ), */
            ],
          ),
        ),
      ),
    );
  }

  Future closeSession() async {
    await auth.logout();
    GoogleSignInServices.signOut();
    Navigator.pushReplacement(
      context,
      PageTransition(
        type: PageTransitionType.leftToRightWithFade,
        child: const WelcomePage(),
      ),
    );
  }
}

class CardProfile extends StatelessWidget {
  const CardProfile({
    Key? key,
    required this.auth,
  }) : super(key: key);

  final AuthServices auth;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black87,
      ),
      width: double.infinity,
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          /*   CircleAvatar(
            radius: 50,
            child: showProfileImage(
              auth.usuario.profileImageUrl,
              auth.usuario.username,
            ),
          ), */
          /* showProfileImage(auth.usuario.profileImageUrl,
              auth.usuario.username, 50), 
              */
          ProfileImageEdit(
            username: auth.user.username,
            profileImage: auth.user.profileImageUrl,
            auth: auth,
          ),
          /*  const SizedBox(
            height: 10,
          ),
          */
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            /* crossAxisAlignment: CrossAxisAlignment.center, */
            children: const [
              ProfileCard(amount: 20, title: 'Seguidores'),
              ProfileCard(amount: 44, title: 'Seguidores'),
            ],
          ),
        ],
      ),
    );
  }
}

class ProfileCard extends StatefulWidget {
  final String title;
  final int amount;
  const ProfileCard({
    Key? key,
    required this.title,
    required this.amount,
  }) : super(key: key);

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  File? _image;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      margin: const EdgeInsets.all(5),
      child: Row(
        children: [
          const CircleAvatar(),
          const SizedBox(
            width: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title),
                Text('${widget.amount}'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
