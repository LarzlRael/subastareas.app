part of '../widgets.dart';

class CommentsWidget extends StatefulWidget {
  final bool isLogged;
  final List<Comment> comments;
  final int idhomework;
  const CommentsWidget({
    Key? key,
    required this.isLogged,
    required this.comments,
    required this.idhomework,
  }) : super(key: key);

  @override
  State<CommentsWidget> createState() => _CommentsWidgetState();
}

class _CommentsWidgetState extends State<CommentsWidget> {
  final myController = TextEditingController();

  late AuthServices auth;
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reverseComments = widget.comments.reversed.toList();
    auth = Provider.of<AuthServices>(context, listen: false);
    return Column(
      children: [
        widget.isLogged
            ? GestureDetector(
                onTap: () {
                  showBottomMenuSheetAddOrEditComment(
                    context,
                    auth,
                    widget.idhomework,
                  );
                },
                child: Row(
                  children: [
                    showProfileImage(
                      auth.user.profileImageUrl,
                      auth.user.username,
                      radius: 25,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const SimpleText(
                      text: 'Agregar un comentario ...',
                      color: Colors.grey,
                    ),
                  ],
                ),
              )
            : Container(),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: reverseComments.length,
          itemBuilder: (context, index) {
            return CommentCard(
              comment: reverseComments[index],
              idHomework: widget.idhomework,
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

  /* showBottomMenuShet(TextEditingController controller) {
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
                            final commentService = CommentServices();
                            await commentService.newComment(
                              widget.homeworkId,
                              controller.text,
                            );
                            Navigator.pop(context);
                            GlobalSnackBar.show(context, 'Comentario enviado');
                            controller.clear();
                            widget.reloadHomework();
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
  } */
}
