part of '../widgets.dart';

class CommentsWidget extends StatefulWidget {
  final bool isLogged;
  final List<Comment> comments;
  final int homeworkId;
  const CommentsWidget({
    Key? key,
    required this.isLogged,
    required this.comments,
    required this.homeworkId,
  }) : super(key: key);

  @override
  State<CommentsWidget> createState() => _CommentsWidgetState();
}

class _CommentsWidgetState extends State<CommentsWidget> {
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
                    showProfileImage(auth.usuario.profileImageUrl,
                        auth.usuario.username, 25),
                    const SizedBox(
                      width: 15,
                    ),
                    const SimpleText(
                      text: 'Agregar un comentario ....',
                      color: Colors.grey,
                    ),
                  ],
                ),
              )
            : Container(),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.comments.length,
          itemBuilder: (context, index) {
            return CommentCard(
              comment: widget.comments[index],
            );
          },
        ),
        /* CommentCard(
          text:
              'Esto es un comentario random que solo pasa un par de veces y no deberias verlo',
        ), */
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
                  showProfileImage(
                      auth.usuario.profileImageUrl, auth.usuario.username),
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
                                'comments/newComment/${widget.homeworkId}',
                                {'content': controller.text},
                                await auth.getCurrentToken());
                            print(comment?.statusCode);

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
