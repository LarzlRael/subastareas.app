part of '../pages.dart';

class AuctionPage extends StatefulWidget {
  final HomeworkArguments args;
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
    _oneHomeworkBloc.getOneHomework(widget.args.idHomework);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    auth = Provider.of<AuthServices>(context, listen: false);
    bool isBearer = false;
    if (auth.isLogged) {
      isBearer = widget.args.idUser == auth.user.id;
    }
    return Scaffold(
      body: StreamBuilder(
        stream: _oneHomeworkBloc.oneHomeworkStream,
        builder:
            (BuildContext context, AsyncSnapshot<OneHomeworkModel> snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                      elevation: 5,
                      centerTitle: true,
                      leading: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                      actions: <Widget>[
                        isBearer
                            ? IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    snapshot.data!.homework.fileType ==
                                            'only_text'
                                        ? 'upload_homework_only_text'
                                        : 'upload_homework_with_file',
                                    arguments: snapshot.data!.homework,
                                    /* PageTransition(
                                      type: PageTransitionType
                                          .leftToRightWithFade,
                                      child: UploadHomeworkOnlyText(),
                                      settings: snapshot.data!.homework,
                                    ), */
                                  );
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              )
                            : Container(),
                      ],
                      floating: true,
                      pinned: true,
                      snap: false,
                      expandedHeight: 200,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Image.asset(
                          'assets/category/${removeDiacritics(snapshot.data!.homework.category)}.jpg',
                          fit: BoxFit.cover,
                          /* width: 280.0, */
                        ),
                        centerTitle: true,
                        title: SimpleText(
                          text: 'Tarea de ${snapshot.data!.homework.category} ',
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      )),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        SafeArea(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    _cardAuction(snapshot.data!, auth.isLogged)
                                  ],
                                ),
                              ],
                            ),

                            /* _buttonMakeOffer(), */
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
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
          oneHomeworkModel.homework.fileUrl != null
              ? TextButton(
                  child: const Text('Ver Tarea '),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      'showHomework',
                      arguments: oneHomeworkModel.homework.fileUrl,
                    );
                  },
                )
              : Container(),
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
      isBearer = oneHomeworkModel.homework.user.id == auth.user.id;
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
