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
    DateTime dt1 = (oneHomeworkModel.homework.resolutionTime);
    final diff = getDateDiff(dt1);

    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SimpleText(
            text: oneHomeworkModel.homework.title,
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
                            oneHomeworkModel.homework.user.profileImageUrl,
                            oneHomeworkModel.homework.user.username),
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      SimpleText(
                        text: oneHomeworkModel.homework.user.username,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ],
                  )),
              _infoContainer(
                'Acaba en ',
                /* const SimpleText(
                  text: '28 : 32 :12',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ), */
                TimerCounter(
                  endTime: DateTime.now().millisecondsSinceEpoch +
                      diff.inMilliseconds,
                  testStyle: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          description(oneHomeworkModel.homework.description),
          _buttonMakeOffer(oneHomeworkModel, isLogged),
          TextButton(
            child: Text('Ver Tarea '),
            onPressed: () {
              Navigator.pushNamed(context, 'showHomework',
                  arguments: oneHomeworkModel.homework.fileUrl);
            },
          ),
          CircleAvatarGroup(
              urlImages: oneHomeworkModel.offers
                  .map((e) => e.user.profileImageUrl == null
                      ? e.user.profileImageUrl
                      : e.user.username)
                  .toList()),
          CommentsWidget(
              comments: oneHomeworkModel.comments,
              isLogged: isLogged,
              homeworkId: oneHomeworkModel.homework.id),
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

  Widget _buttonMakeOffer(OneHomeworkModel oneHomeworkModel, bool isLogged) {
    final size = MediaQuery.of(context).size;
    final isBearer = oneHomeworkModel.homework.user.id == auth.usuario.id;
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
                const SimpleText(
                  text: 'Ofertar',
                  fontSize: 15,
                  color: Colors.white,
                ),
                SimpleText(
                  text: '${oneHomeworkModel.homework.offeredAmount} bs',
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                /* Navigator.pushNamed(context, 'makeOffer'); */
                if (isBearer) {
                  navigatorProtected(context, isLogged, 'autionWithOffer');
                } else {
                  navigatorProtected(context, isLogged, 'makeOffer');
                }
              },
              child:
                  isBearer ? const Text('Ver ofertas') : const Text('Ofertar'),
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
