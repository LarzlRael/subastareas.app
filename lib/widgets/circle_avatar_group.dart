part of 'widgets.dart';

class CircleAvatarGroup extends StatefulWidget {
  final int elementsToShow;
  final OneHomeworkModel oneHomeworkModel;

  const CircleAvatarGroup({
    Key? key,
    required this.oneHomeworkModel,
    this.elementsToShow = 5,
  }) : super(key: key);

  @override
  State<CircleAvatarGroup> createState() => _CircleAvatarGroupState();
}

class _CircleAvatarGroupState extends State<CircleAvatarGroup> {
  late SocketService socketService;
  late List<ProfileImage> _profileImages = [];
  late List<Offer> sliceArray = [];
  @override
  void initState() {
    socketService = Provider.of<SocketService>(context, listen: false);
    sliceArray = widget.oneHomeworkModel.offers.length > widget.elementsToShow
        ? widget.oneHomeworkModel.offers.sublist(0, widget.elementsToShow)
        : widget.oneHomeworkModel.offers;
    loadOffers();
    socketService.socket
        .emit('joinOfferRoom', widget.oneHomeworkModel.homework.id);
    socketService.socket.on('makeOfferToClient', _escucharMensaje);
    socketService.socket.on('deleteOffer', _listeneOfferDeleted);
    super.initState();
  }

  @override
  void dispose() {
    disconnectEvents(socketService, widget.oneHomeworkModel.homework.id);
    super.dispose();
  }

  void _listeneOfferDeleted(dynamic payload) {
    final offer = offerSimpleModelFromJson(payload);
    if (mounted) {
      setState(() {
        _profileImages.removeWhere((item) => item.id == offer.id);
      });
    }
  }

  void _escucharMensaje(dynamic payload) {
    final offer = offerSimpleModelFromJson(payload);

    ProfileImage message = ProfileImage(
      profileImage: offer.user.profileImageUrl,
      userName: offer.user.username,
      id: offer.id,
      radius: 20,
      index: _profileImages.length,
    );

    if (mounted) {
      setState(() {
        _profileImages.insert(0, message);
      });
      // check whether the state object is in tree
    }
  }

  void loadOffers() {
    final profileImages = sliceArray.map((x) => ProfileImage(
          profileImage: x.user.profileImageUrl,
          userName: x.user.username,
          index: sliceArray.indexOf(x),
          radius: 20,
          id: x.id,
        ));

    setState(() {
      _profileImages.insertAll(0, profileImages);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          'autionWithOfferPage',
          arguments: widget.oneHomeworkModel,
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        child: _profileImages.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SimpleText(
                    text: 'Ofertas',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    bottom: 5,
                  ),
                  Row(
                    children: [
                      Row(
                        children: _profileImages.toList(),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      widget.oneHomeworkModel.offers.length >
                              widget.elementsToShow
                          ? _createCircleAvatarMore()
                          : Container(),
                    ],
                  ),
                ],
              )
            : Container(),
      ),
    );
  }

  _createCircleAvatarMore() {
    final showNumber =
        widget.oneHomeworkModel.offers.length - widget.elementsToShow;
    return CircleAvatar(
      backgroundColor: Colors.grey,
      radius: 18,
      child: SimpleText(
        text: showNumber.toString() + "+",
        lightThemeColor: Colors.white,
      ),
    );
  }
}
