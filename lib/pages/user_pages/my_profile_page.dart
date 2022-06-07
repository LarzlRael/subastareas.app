part of '../pages.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  late final AuthServices auth;

  /* final _googleSignInServices = GoogleSignInServices; */
  @override
  Widget build(BuildContext context) {
    auth = Provider.of<AuthServices>(context, listen: true);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      /*   CircleAvatar(
                        radius: 50,
                        child: showProfileImage(
                          auth.usuario.profileImageUrl,
                          auth.usuario.username,
                        ),
                      ), */
                      showProfileImage(auth.usuario.profileImageUrl,
                          auth.usuario.username, 50),
                      const SizedBox(
                        height: 10,
                      ),
                      SimpleText(
                        text: auth.usuario.username,
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ProfileCard(),
                      ProfileCard(),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: getMenuProfileOptions(closeSession).length,
                  itemBuilder: (BuildContext context, int index) {
                    return getMenuProfileOptions(closeSession)[index];
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
        child: WelcomePage(),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

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
      margin: EdgeInsets.all(5),
      child: Row(
        children: [
          CircleAvatar(),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Personas que te sigues'),
              Text('999999'),
            ],
          )
        ],
      ),
    );
  }
}
