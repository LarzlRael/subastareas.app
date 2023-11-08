part of '../pages.dart';

class PublicProfilePage extends StatelessWidget {
  const PublicProfilePage({
    Key? key,
    required this.userId,
  }) : super(key: key);
  final int userId;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
    );
    final userService = UserServices();
    return Scaffold(
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
      ),
      //hexadecimal background color
      /* backgroundColor: theme.isDarkTheme
          ? Theme.of(context).scaffoldBackgroundColor
          : const Color(0xFFD9D9D9), */
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: userService.getPublicProfile(userId),
            builder:
                (BuildContext context, AsyncSnapshot<PublicProfile> snapshot) {
              if (!snapshot.hasData) {
                return SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: const Center(child: SquareLoading()));
              }
              final publicProfile = snapshot.data!;
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ProfileCardWithStars(
                      publicProfile: snapshot.data!,
                      backgroundColor: Colors.black,
                    ),
                    information(),
                    information(),
                    information(),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 5,
                      child: Container(
                        padding: const EdgeInsets.all(25),
                        child: Column(
                          children: [
                            const SimpleText(
                              text: 'Trayectoria en subastareas',
                              style: textStyle,
                            ),
                            const SizedBox(height: 20),
                            profileInformation(
                                textStyle,
                                Icons.home,
                                "Trabajos realizados: ",
                                publicProfile.solvedHomeworks.toString()),
                            profileInformation(
                                textStyle,
                                Icons.home_mini,
                                "Reputación: ",
                                publicProfile.reputation.toString()),
                          ],
                        ),
                      ),
                    ),
                    publicProfile.bio == "null" || publicProfile.bio == null
                        ? Container()
                        : Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 5,
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(25),
                              child: const Column(
                                children: [
                                  SimpleText(
                                    text: 'Biografia',
                                    style: textStyle,
                                  ),
                                  SizedBox(height: 15),
                                ],
                              ),
                            ),
                          )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget profileInformation(
    TextStyle textStyle,
    IconData icon,
    String text,
    String informationToDisplay,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon),
              const SizedBox(width: 5),
              SimpleText(
                text: text,
                style: textStyle,
              ),
            ],
          ),
          SimpleText(text: informationToDisplay, style: textStyle),
        ],
      ),
    );
  }
}

Widget information() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Ionicons.checkmark_circle,
          color: Colors.lightGreen,
          size: 35,
        ),
        SimpleText(
          left: 10,
          fontSize: 20,
          text: 'Identidad verificada',
          fontWeight: FontWeight.bold,
        )
      ],
    ),
  );
}
