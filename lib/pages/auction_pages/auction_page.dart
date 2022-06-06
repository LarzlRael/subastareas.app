part of '../pages.dart';

class AuctionPage extends StatefulWidget {
  const AuctionPage({Key? key}) : super(key: key);
  @override
  State<AuctionPage> createState() => _AuctionPageState();
}

class _AuctionPageState extends State<AuctionPage> {
  late AuthServices auth;
  late HomeworkServices homeworkServices;
  @override
  void initState() {
    homeworkServices = HomeworkServices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final idHomeWork = ModalRoute.of(context)?.settings.arguments as int;
    auth = Provider.of<AuthServices>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.black,
            size: 25,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const SimpleText(
          text: 'Mi tarea de Matematica',
          color: Colors.black,
          fontSize: 20,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FutureBuilder(
                future: homeworkServices.getOneHomework(idHomeWork),
                /* initialData: InitialData, */
                builder: (BuildContext context,
                    AsyncSnapshot<OneHomeworkModel> snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        _imageCategory(),
                        _cardAuction(snapshot.data!, auth.isLogged),
                      ],
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),

              /* _buttonMakeOffer(), */
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardAuction(OneHomeworkModel oneHomeworkModel, bool isLogged) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SimpleText(
            text: oneHomeworkModel.user.username,
            fontWeight: FontWeight.w500,
            bottom: 15,
            fontSize: 22,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _infoContainer(
                  'Creador',
                  Row(
                    children: [
                      CircleAvatar(
                        /* child: showProfileImage(profileImage, userName) */
                        child: showProfileImage(
                            oneHomeworkModel.user.profileImageUrl,
                            oneHomeworkModel.user.username),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      SimpleText(
                        text: 'Nick Cannon',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ],
                  )),
              _infoContainer(
                'Acaba en ',
                const SimpleText(
                  text: '28 : 32 :12',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                /*   TimerCounter(
                  endTime: DateTime.now().millisecondsSinceEpoch + 1000 * 30,
                  testStyle: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ), */
              ),
            ],
          ),
          description(oneHomeworkModel.description),
          _buttonMakeOffer(oneHomeworkModel, isLogged),
          TextButton(
            child: Text('Ver Tarea '),
            onPressed: () {
              Navigator.pushNamed(context, 'showHomework',
                  arguments: oneHomeworkModel.fileUrl);
            },
          ),
          CircleAvatarGroup(
              urlImages: oneHomeworkModel.offers
                  .map((e) => e.user.profileImageUrl)
                  .toList()),
          Comments(comments: oneHomeworkModel.comments, isLogged: isLogged),
        ],
      ),
    );
  }

  Widget _imageCategory() {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.35,
      width: size.width,
      child: Image.network(
        'https://octutor.org/media/posts/11/math.jpg',
        /* width: 280.0, */
      ),
    );
  }

  _infoContainer(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SimpleText(
          text: title,
          fontSize: 16,
          color: Colors.grey,
          bottom: 10,
        ),
        content,
      ],
    );
  }

  Widget _buttonMakeOffer(OneHomeworkModel oneHomeworkModelbool, isLogged) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      /* width: size.width,
      height: size.height, */

      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        width: size.width * 1,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.blue,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          /* crossAxisAlignment: CrossAxisAlignment.stretch, */
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SimpleText(
                  text: 'Ofertar',
                  fontSize: 15,
                  color: Colors.white,
                ),
                SimpleText(
                  text: '${oneHomeworkModelbool.offeredAmount} bs',
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                /* Navigator.pushNamed(context, 'makeOffer'); */
                navigatorProtected(context, isLogged, 'makeOffer');
              },
              child: const Text('Hacer una oferta'),
            ),
          ],
        ),
      ),
    );
  }

  Widget description(String? desc) {
    if (desc == null || desc.isEmpty) return Container();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SimpleText(
          text: 'Descripción',
          top: 20,
          bottom: 10,
          color: Colors.black,
          fontSize: 18,
        ),
        DescriptionText(
          despegable: false,
          desc: desc,
        ),
      ],
    );
  }
}
