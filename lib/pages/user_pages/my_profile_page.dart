part of '../pages.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  late AuthProvider auth;

  final _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    auth = Provider.of<AuthProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBarTitle(
        title: 'PERFIL',
        fontSize: 20,
        appBar: AppBar(),
      ),
      body: SafeArea(
        child: SmartRefresher(
          onRefresh: _refreshUser,
          controller: _refreshController,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                CardProfile(auth: auth),
                /* Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ProfileCard(),
                    ProfileCard(),
                  ],
                ), */
                const SizedBox(
                  height: 30,
                ),
                /* BellIconNotification(), */
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: menuProfileOptions(auth).length,
                    itemBuilder: (
                      BuildContext context,
                      int index,
                    ) {
                      return menuProfileOptions(auth)[index];
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _refreshUser() async {
    await auth.refreshUser();
    _refreshController.refreshCompleted();
  }

  void closeSession() {
    auth.googleSignOut();
    auth.logout().then((value) {
      Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.leftToRightWithFade,
          child: const WelcomePage(),
        ),
      );
    });
  }
}

class CardProfile extends StatelessWidget {
  const CardProfile({
    Key? key,
    required this.auth,
  }) : super(key: key);

  final AuthProvider auth;

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
          ProfileImageEdit(
            auth: auth,
          ),
          /*  const SizedBox(
            height: 10,
          ),
          */
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ProfileCard(
                  amount: auth.user.professor.solvedHomeworks,
                  title: 'Tarea resueltas'),
              ProfileCard(
                amount: auth.user.professor.reputation,
                title: 'Reputacion',
              ),
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
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
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
