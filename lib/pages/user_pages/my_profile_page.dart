part of '../pages.dart';

class MyProfilePage extends HookWidget {
  MyProfilePage({Key? key}) : super(key: key);

  final _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBarTitle(
        title: 'PERFIL',
        fontSize: 20,
        actions: [
          InkWell(
            onTap: () => context.push('/notificatins_page'),
            child: const BellIconNotification(),
          ),
          const SizedBox(width: 15),
        ],
        appBar: AppBar(),
      ),
      body: SafeArea(
        child: SmartRefresher(
          onRefresh: () => _refreshUser(auth),
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
                const SizedBox(height: 30),
                /* BellIconNotification(), */
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: menuProfileOptions(auth).length,
                    itemBuilder: (_, int index) =>
                        menuProfileOptions(auth)[index],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _refreshUser(AuthProvider auth) async {
    await auth.refreshUser();
    _refreshController.refreshCompleted();
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
