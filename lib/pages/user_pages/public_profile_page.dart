part of '../pages.dart';

class PublicProfilePage extends StatelessWidget {
  const PublicProfilePage({
    Key? key,
    required this.userId,
  }) : super(key: key);
  final int userId;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    const textStyle = TextStyle(
      fontSize: 23,
      fontWeight: FontWeight.bold,
    );
    final userService = UserServices();
    return Scaffold(
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
      ),
      //hexadecimal background color
      backgroundColor: theme.isDarkTheme
          ? Theme.of(context).scaffoldBackgroundColor
          : const Color(0xFFD9D9D9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: userService.getPublicProfile(userId),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    /* crossAxisAlignment: CrossAxisAlignment.center, */
                    mainAxisAlignment: MainAxisAlignment.center,
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
                              const SizedBox(height: 25),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: const [
                                  Icon(Icons.breakfast_dining),
                                  SimpleText(
                                      text: 'Trabajos resueltos: ',
                                      style: textStyle),
                                  SimpleText(text: '0', style: textStyle),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 5,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(25),
                          child: Column(
                            children: const [
                              SimpleText(
                                text: 'Biografia',
                                style: textStyle,
                              ),
                              SizedBox(height: 15),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: const Center(child: CircularProgressIndicator()));
              }
            },
          ),
        ),
      ),
    );
  }
}

Widget information() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
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
