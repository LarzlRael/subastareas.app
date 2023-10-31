part of '../pages.dart';

class AuctionWithOfferPage extends StatefulWidget {
  final OneHomeworkModel oneHomework;

  const AuctionWithOfferPage({
    required this.oneHomework,
    Key? key,
  }) : super(key: key);

  @override
  State<AuctionWithOfferPage> createState() => _AuctionWithOfferPageState();
}

class _AuctionWithOfferPageState extends State<AuctionWithOfferPage>
    with TickerProviderStateMixin {
  late final List<PersonOfferHorizontal> _offer = [];
  late SocketService socketService;
  late AuthServices auth;
  int _currentViewers = 0;
  @override
  void initState() {
    auth = Provider.of<AuthServices>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    loadOffers();
    socketService.socket.emit('joinOfferRoom', widget.oneHomework.homework.id);
    socketService.socket.on('makeOfferToClient', _escucharMensaje);
    socketService.socket.on('joinOfferRoom', (_listenerUserRoomCount));
    socketService.socket.on('leaveOfferRoom', (_listenerUserRoomCount));
    socketService.socket.on('deleteOffer', _listenOfferDeleted);
    socketService.socket.on('editOffer', _listenerOfferEdited);

    super.initState();
  }

  @override
  void dispose() {
    for (PersonOfferHorizontal message in _offer) {
      message.animationController.dispose();
    }
    //TODO ver si funciona
    /* socketService.socket.emit('leaveOfferRoom', widget.args.homework.id);
    socketService.socket.off('leaveOfferRoom');
    socketService.socket.off('makeOfferToClient');
    socketService.socket.off('deleteOffer');
    socketService.socket.off('editOffer'); */
    disconnectEvents(socketService, widget.oneHomework.homework.id);
    super.dispose();
  }

  void _listenerOfferEdited(dynamic payload) {
    final offer = offerSimpleModelFromJson(payload);
    final index = _offer.indexWhere((item) => item.id == offer.id);
    PersonOfferHorizontal message = PersonOfferHorizontal(
      offer: Offer(
        id: offer.id,
        priceOffer: offer.priceOffer,
        status: offer.status,
        edited: offer.edited,
        user: OfferUser(
          id: offer.user.id,
          username: offer.user.username,
          profileImageUrl: offer.user.profileImageUrl,
        ),
      ),
      id: offer.id,
      auth: AuthServices(),
      homework: widget.oneHomework,
      //fix this

      isOwner: auth.user.id == widget.oneHomework.homework.user.id,
      animationController: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 200),
      )..forward(),
    );
    if (mounted) {
      setState(() {
        _offer[index] = message;
      });
    }
  }

  void _listenOfferDeleted(dynamic payload) {
    final offer = offerSimpleModelFromJson(payload);
    if (mounted) {
      setState(() {
        _offer.removeWhere((item) => item.id == offer.id);
      });
    }
  }

  void _listenerUserRoomCount(dynamic data) {
    if (mounted) {
      setState(() {
        _currentViewers = data;
      });
    }
  }

  void _escucharMensaje(dynamic payload) {
    final offer = offerSimpleModelFromJson(payload);

    PersonOfferHorizontal message = PersonOfferHorizontal(
      offer: Offer(
        id: offer.id,
        priceOffer: offer.priceOffer,
        status: offer.status,
        edited: offer.edited,
        user: OfferUser(
          id: offer.user.id,
          username: offer.user.username,
          profileImageUrl: offer.user.profileImageUrl,
        ),
      ),
      id: offer.id,
      auth: AuthServices(),
      homework: widget.oneHomework,
      //fix this

      isOwner: auth.user.id == widget.oneHomework.homework.user.id,
      animationController: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 200),
      )..forward(),
    );

    setState(() {
      _offer.insert(0, message);
    });
    /* if (mounted) {
      // check whether the state object is in tree
    } */
  }

  void loadOffers() {
    final offers = widget.oneHomework.offers.map((x) => PersonOfferHorizontal(
          offer: x,
          auth: AuthServices(),
          homework: widget.oneHomework,
          id: x.id,
          //fix this
          isOwner: auth.user.id == widget.oneHomework.homework.user.id,
          animationController: AnimationController(
            vsync: this,
            duration: const Duration(milliseconds: 0),
          )..forward(),
        ));

    setState(() {
      _offer.insertAll(0, offers);
    });
  }

  @override
  Widget build(BuildContext context) {
    /* final auth = Provider.of<AuthServices>(context, listen: false); */
    OneHomeworkBloc homeworksBloc = OneHomeworkBloc();
    homeworksBloc.getOneHomework(widget.oneHomework.homework.id);
    final isOwner = auth.user.id == widget.oneHomework.homework.user.id;
    return Scaffold(
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
        title: widget.oneHomework.homework.title.toCapitalized(),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ImageBackgroundAndTimer(
                      auth: auth,
                      homework: widget.oneHomework,
                      isOwner: isOwner),
                  auth.isLogged ? currentHomeworkViewers() : Container(),
                  widget.oneHomework.homework.status == 'pending_to_resolve'
                      ? const SimpleText(
                          text:
                              'Ya aceptaste una oferta, espera a que el profesor te responda',
                          fontSize: 15,
                          top: 5,
                          bottom: 5,
                        )
                      : const SizedBox(),
                  StreamBuilder(
                    stream: homeworksBloc.oneHomeworkStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<OneHomeworkModel> snapshot) {
                      if (!snapshot.hasData) {
                        return const CircularCenter();
                      }
                      if (_offer.isEmpty) {
                        return const NoInformation(
                          message: 'Aún no hay ofertas ',
                          icon: Icons.search_off,
                          showButton: false,
                          iconButton: Icons.add,
                        );
                      }
                      return Expanded(
                        child: ListView.builder(
                          /* scrollDirection: Axis.horizontal, */
                          itemCount: _offer.length,
                          itemBuilder: (_, int index) => _offer[index],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget currentHomeworkViewers() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          const Icon(Icons.remove_red_eye, color: Colors.grey),
          const SizedBox(width: 5),
          /* SimpleText(
            text: _currentViewers == 1
                ? 'Solo tú estas viendo esto'
                : 'Tú y ${_currentViewers - 1} personas más, están viendo esto',
            fontSize: 15,
            fontWeight: FontWeight.w500,
            top: 5,
            bottom: 5,
          ), */
          Text(
            _currentViewers == 1
                ? 'Solo tú estas viendo esto'
                : 'Tú y ${_currentViewers - 1} personas más, están viendo esto',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class AcceptOfferButton extends StatefulWidget {
  final Offer offer;

  const AcceptOfferButton({
    Key? key,
    required this.offer,
  }) : super(key: key);

  @override
  State<AcceptOfferButton> createState() => _AcceptOfferButtonState();
}

class _AcceptOfferButtonState extends State<AcceptOfferButton> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    /*TODO Check this code */
    final colors = Theme.of(context).colorScheme;
    final pendingToResolve = widget.offer.status == 'pending_to_resolve' ||
        widget.offer.status == 'traded';
    final offersServices = OffersServices();
    return Container(
      padding: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      height: 100,
      decoration: BoxDecoration(
        color: colors.primary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SimpleText(
                text: !pendingToResolve
                    /* TODO revisar esta parte para que no de error a future */
                    ? 'Oferta'
                    : 'Ya aceptaste una oferta',
                /* textAlign: TextAlign.center, */
                fontSize: 15,
                fontWeight: FontWeight.bold,
                lightThemeColor: Colors.white,
              ),
              !pendingToResolve
                  ? SimpleText(
                      text: widget.offer.priceOffer.toString(),
                      fontSize: 15,
                      lightThemeColor: Colors.white)
                  : Container()
            ],
          ),
          pendingToResolve
              ? Container()
              : MaterialButton(
                  onPressed: !loading
                      ? () async {
                          setState(() {
                            loading = true;
                          });
                          await offersServices
                              .enterPendingTrade(widget.offer.id);
                          setState(() {
                            loading = false;
                          });
                          /* Navigator.of(context).pop(); */
                          GlobalSnackBar.show(
                            context,
                            'Acabas de aceptar la oferta, espere a que el otro usuario termine tu tarea',
                            backgroundColor: Colors.green,
                            /* icon: Icons.check, */
                          );
                        }
                      : null,
                  height: 45,
                  minWidth: 150,
                  elevation: 0,
                  shape: const StadiumBorder(),
                  color: !loading ? Colors.black : Colors.yellow,
                  child: !loading
                      ? const SimpleText(
                          text: 'Aceptar oferta',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          lightThemeColor: Colors.white,
                        )
                      : const CircularProgressIndicator(color: Colors.white),
                ),
        ],
      ),
    );
  }
}

class _ButtonOffer extends StatelessWidget {
  final bool isLogged;
  final OneHomeworkModel homework;
  const _ButtonOffer({
    Key? key,
    required this.isLogged,
    required this.homework,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
      elevation: 5,
      child: Column(
        children: [
          Container(
            width: size.width * 0.85,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5.0,
                  spreadRadius: 1.0,
                  offset: Offset(
                    0.0,
                    1.0,
                  ),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SimpleText(
                            text:
                                homework.homework.user.username.toCapitalized(),
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                          Timer(
                            endTime: homework.homework.resolutionTime,
                          ),
                        ],
                      ),
                      FilledButton(
                        onPressed: () {
                          navigatorProtected(
                            context,
                            isLogged,
                            'makeOffer',
                            homework,
                          );
                        },
                        child: const SimpleText(
                          fontSize: 15,
                          text: "Hacer una oferta",
                          fontWeight: FontWeight.w400,
                          /* lightThemeColor: Colors.white, */
                        ),
                      ),
                    ]),
              ],
            ),
          )
        ],
      ),
    );
  }
}

/* Widget _buttonOffer(Size size, bool isLogged, OneHomeworkModel homework) {
    
  } */

class _ImageBackgroundAndTimer extends StatelessWidget {
  final AuthServices auth;
  final OneHomeworkModel homework;
  final bool isOwner;
  const _ImageBackgroundAndTimer(
      {Key? key,
      required this.auth,
      required this.homework,
      required this.isOwner})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double height = size.height * 0.35;
    return Stack(
      children: <Widget>[
        // The containers in the background
        Column(
          children: <Widget>[
            Container(
              width: size.width,
              height: height,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                width: double.infinity,
                height: 100,
                child: Image.asset(
                  'assets/category/${removeDiacritics(homework.homework.category)}.jpg',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
        !isOwner
            ? Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.only(
                  top: height * 0.75,
                ),
                child:
                    _ButtonOffer(isLogged: auth.isLogged, homework: homework),
              )
            : Container()
      ],
    );
  }
}
