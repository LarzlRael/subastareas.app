part of '../widgets.dart';

class Comments extends StatefulWidget {
  final bool isLogged;
  const Comments({
    Key? key,
    required this.isLogged,
  }) : super(key: key);

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  final myController = TextEditingController();
  bool _showSendIcon = false;
  late AuthServices auth;
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    auth = Provider.of<AuthServices>(context, listen: false);
    return Column(
      children: [
        widget.isLogged
            ? GestureDetector(
                onTap: () {
                  showBottomMenuShet(myController);
                },
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      child: showProfileImage(
                          auth.usuario.profileImageUrl, auth.usuario.username),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    SimpleText(
                      text: 'Agregar un comentario ....',
                      color: Colors.grey,
                    ),
                  ],
                ),
              )
            : Container(),
        CommentCard(
          text:
              'Esto es un comentario random que solo pasa un par de veces y no deberias verlo',
        ),
        CommentCard(
          text:
              '50esto es solo un numero oe 50esto es solo un numero oe50esto es solo un numero oe50esto es solo un numero oe  specimen book. It has survived not only five centuries, but also the leap into electronic 38883888f8f899d',
        ),
        CommentCard(
          text:
              '50esto es solo un numero oe 50esto es solo un numero oe50esto es solo un numero oe50esto es solo un numero oe  specimen book. It has survived not only five centuries, but also the leap into electronic 38883888f8f899d',
        ),
        CommentCard(
          text:
              '50esto es solo un numero oe 50esto es solo un numero oe50esto es solo un numero oe50esto es solo un numero oe  specimen book. It has survived not only five centuries, but also the leap into electronic 38883888f8f899d',
        ),
      ],
    );
  }

  showBottomMenuShet(TextEditingController controller) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircleAvatar(
                      child: showProfileImage(
                          auth.usuario.profileImageUrl, auth.usuario.username)),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: TextField(
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Escribe un comentario',
                    ),
                    autofocus: true,
                    controller: controller,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          _showSendIcon = true;
                        });
                      } else {
                        setState(() {
                          _showSendIcon = false;
                        });
                      }
                    },
                  )),
                  _showSendIcon
                      ? IconButton(
                          onPressed: () async {
                            // usar servicio en este punto

                            final comment = await Services.sendRequestWithToken(
                                'POST',
                                'comments/newComment/16',
                                {'content': controller.text},
                                await auth.getCurrentToken());
                            print(comment?.body);

                            Navigator.pop(context);
                            controller.clear();
                          },
                          icon: const Icon(Icons.send),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
