part of '../pages.dart';

class AuctionPage extends StatefulWidget {
  final int args;
  const AuctionPage({Key? key, required this.args}) : super(key: key);
  @override
  State<AuctionPage> createState() => _AuctionPageState();
}

class _AuctionPageState extends State<AuctionPage> {
  late AuthServices auth;
  final _oneHomeworkBloc = OneHomeworkBloc();

  @override
  void initState() {
    /* getOneHomeWork(); */
    _oneHomeworkBloc.getOneHomework(widget.args);
    super.initState();
  }

  /*  getOneHomeWork() async {
    print('load homework');
    final getOnehomework = await homeworkServices.getOneHomework(widget.args);
    setState(() {
      homework = getOnehomework;
    });
  } */

  @override
  Widget build(BuildContext context) {
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
        title: Text('que fue '),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  _imageCategory(widget.args),
                  StreamBuilder(
                    stream: _oneHomeworkBloc.oneHomeworkStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<OneHomeworkModel> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return _cardAuction(snapshot.data!, auth.isLogged);
                      }
                    },
                  ),
                ],
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
                      showProfileImage(
                          oneHomeworkModel.homework.user.profileImageUrl,
                          oneHomeworkModel.homework.user.username),
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
                /* TimerCounter(
                  endTime: DateTime.now().millisecondsSinceEpoch +
                      diff.inMilliseconds,
                  testStyle: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                  ),
                ), */
                Container(),
              ),
            ],
          ),
          description(oneHomeworkModel.homework.description),
          _buttonMakeOffer(oneHomeworkModel, isLogged),
          TextButton(
            child: const Text('Ver Tarea '),
            onPressed: () {
              Navigator.pushNamed(
                context,
                'showHomework',
                arguments: oneHomeworkModel.homework.fileUrl,
              );
            },
          ),
          CircleAvatarGroup(
            oneHomeworkModel: oneHomeworkModel,
          ),
          CommentsWidget(
            comments: oneHomeworkModel.comments,
            isLogged: isLogged,
            idhomework: oneHomeworkModel.homework.id,
          ),
        ],
      ),
    );
  }

  Widget _imageCategory(int idHomeWork) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.35,
      width: size.width,
      child: Hero(
        tag: idHomeWork,
        child: Image.network(
          'https://octutor.org/media/posts/11/math.jpg',
          /* width: 280.0, */
        ),
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
    /* Change this for the condition */
    final size = MediaQuery.of(context).size;
    bool isBearer = false;
    if (isLogged) {
      isBearer = oneHomeworkModel.homework.user.id == auth.usuario.id;
    }
    return SizedBox(
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
                  navigatorProtected(context, isLogged, 'autionWithOfferPage',
                      oneHomeworkModel);
                } else {
                  navigatorProtected(
                      context, isLogged, 'makeOffer', oneHomeworkModel);
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
