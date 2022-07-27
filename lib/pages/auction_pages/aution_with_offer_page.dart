part of '../pages.dart';

class AutionWithOfferPage extends StatefulWidget {
  OneHomeworkModel args;

  AutionWithOfferPage({
    required this.args,
    Key? key,
  }) : super(key: key);

  @override
  State<AutionWithOfferPage> createState() => _AutionWithOfferPageState();
}

class _AutionWithOfferPageState extends State<AutionWithOfferPage>
    with TickerProviderStateMixin {
  late List<PersonOfferHorizontal> _offer = [];
  late SocketService socketService;
  late AuthServices auth;
  int _currentViewers = 0;
  @override
  void initState() {
    auth = Provider.of<AuthServices>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    loadOffers();
    socketService.socket.emit('joinOfferRoom', widget.args.homework.id);
    socketService.socket.on('makeOfferToClient', _escucharMensaje);
    socketService.socket.on('joinOfferRoom', (_listenerUserRoomCount));
    socketService.socket.on('leaveOfferRoom', (_listenerUserRoomCount));
    socketService.socket.on('deleteOffer', _listeneOfferDeleted);
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
    disconnectEvents(socketService, widget.args.homework.id);

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
      homework: widget.args,
      //fix this

      isOwner: auth.user.id == widget.args.homework.user.id,
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

  void _listeneOfferDeleted(dynamic payload) {
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
      homework: widget.args,
      //fix this

      isOwner: auth.user.id == widget.args.homework.user.id,
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
    final offers = widget.args.offers.map((x) => PersonOfferHorizontal(
          offer: x,
          auth: AuthServices(),
          homework: widget.args,
          id: x.id,
          //fix this
          isOwner: auth.user.id == widget.args.homework.user.id,
          animationController: AnimationController(
            vsync: this,
            duration: Duration(milliseconds: 0),
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
    homeworksBloc.getOneHomework(widget.args.homework.id);
    final isOwner = auth.user.id == widget.args.homework.user.id;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ImageBackgorundAndTimer(
                      auth: auth, homework: widget.args, isOwner: isOwner),
                  Row(
                    children: [
                      Icon(Icons.remove_red_eye, color: Colors.grey),
                      SimpleText(
                        text: _currentViewers == 1
                            ? 'Solo tú estas viendo esto'
                            : 'Tú y ${_currentViewers - 1} estan viendo esto',
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        top: 5,
                        bottom: 5,
                      ),
                    ],
                  ),
                  const Center(
                    child: SimpleText(
                      text: "Ofertas recibidas",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      top: 15,
                      bottom: 15,
                    ),
                  ),
                  widget.args.homework.status == 'pending_to_resolve'
                      ? const SimpleText(
                          text:
                              'Ya aceptas una oferta, espera a que el profesor te responda',
                          fontSize: 15,
                          top: 5,
                          bottom: 5,
                        )
                      : Container(),
                  StreamBuilder(
                    stream: homeworksBloc.oneHomeworkStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<OneHomeworkModel> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (_offer.isEmpty) {
                        return const NoInformation(
                          message: 'No hay ofertas aun',
                          icon: Icons.search_off,
                          showButton: false,
                          iconButton: Icons.add,
                        );
                      } else {
                        return Expanded(
                          child: ListView.builder(
                            /* scrollDirection: Axis.horizontal, */
                            itemCount: _offer.length,
                            itemBuilder: (_, int index) => _offer[index],
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            /* filterProvider.getShowButtonAcept
                ? Positioned(
                    bottom: 0,
                    left: 0,
                    child: AcceptOfferButton(
                      amount: args.homework.priceOffer.toString(),
                    ),
                  )
                : Container(), */
          ],
        ),
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
    inspect(widget.offer);
    final pendingToResolve = widget.offer.status == 'pending_to_resolve';
    final offersServices = OffersServices();
    return Container(
      padding: const EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      height: 100,
      decoration: const BoxDecoration(
        color: Colors.green,
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
                    ? 'Aceptar oferta'
                    : 'Ya aceptaste una oferta',
                /* textAlign: TextAlign.center, */
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              !pendingToResolve
                  ? SimpleText(
                      text: widget.offer.priceOffer.toString(),
                      fontSize: 20,
                      color: Colors.white)
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
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
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
                      ? SimpleText(
                          text: 'Aceptar Oferta',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )
                      : CircularProgressIndicator(color: Colors.white),
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
      elevation: 10,
      child: Column(
        children: [
          Container(
            width: size.width * 0.75,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
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
                        children: const [
                          SimpleText(
                            text: 'Afro Weed',
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                          /* TimerCounter(
                            endTime: DateTime.now().millisecondsSinceEpoch +
                                getDateDiff(homework.homework.resolutionTime)
                                    .inMilliseconds,
                          ) */
                        ],
                      ),
                      ElevatedButton(
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
                          color: Colors.white,
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

class _ImageBackgorundAndTimer extends StatelessWidget {
  final AuthServices auth;
  final OneHomeworkModel homework;
  final bool isOwner;
  const _ImageBackgorundAndTimer(
      {Key? key,
      required this.auth,
      required this.homework,
      required this.isOwner})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    /* return Stack(
      children: [
        Image.network(
            'https://concepto.de/wp-content/uploads/2018/08/f%C3%ADsica-e1534938838719.jpg'),
        _ButtonOffer(isLogged: auth.isLogged, homework: homework),
        Positioned(
          bottom: 30,
          child: SizedBox(
            width: size.width,
            height: 100,
            child: const Align(
              child: FloatMenu(),
            ),
          ),
          top: 0,
        ),
      ],
    ); */
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
              /* color: Colors.blue, */
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                width: double.infinity,
                height: 100,
                child: Image.network(
                    'https://concepto.de/wp-content/uploads/2018/08/f%C3%ADsica-e1534938838719.jpg',
                    fit: BoxFit.fill),
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
