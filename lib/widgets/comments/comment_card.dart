part of '../widgets.dart';

class CommentCard extends StatefulWidget {
  final Comment comment;
  final int idHomework;

  bool isExpanded;
  CommentCard({
    Key? key,
    this.isExpanded = false,
    required this.comment,
    required this.idHomework,
  }) : super(key: key);

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard>
    with TickerProviderStateMixin<CommentCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /* double c_width = MediaQuery.of(context).size.width * 0.8; */
    final auth = Provider.of<AuthServices>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          showProfileImage(
            widget.comment.user.profileImageUrl,
            widget.comment.user.username,
            radius: 20,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _nameAndTimeAgo(),
                DesplegableComment(
                  commentContent: widget.comment.content,
                  isExpanded: widget.isExpanded,
                  limit: 75,
                ),
                widget.comment.edited
                    ? Row(
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const SimpleText(
                              text: 'Editado',
                              lightThemeColor: Colors.grey,
                            ),
                          )
                        ],
                      )
                    : Container()
              ],
            ),
          ),
          auth.isLogged
              ? IconButton(
                  onPressed: () {
                    showBottomMenuSheet(
                        auth, widget.comment, widget.idHomework);
                  },
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.grey,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Row _nameAndTimeAgo() {
    return Row(
      children: [
        SimpleText(
          text: widget.comment.user.username,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(width: 15),
        SimpleText(
          text: timeago.format(widget.comment.createdAt, locale: 'es'),
          lightThemeColor: Colors.grey,
        ),
      ],
    );
  }

  showBottomMenuSheet(AuthServices auth, Comment comment, int idHomework) {
    final homeworkBloc = OneHomeworkBloc();
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return auth.user.id == comment.user.id
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.edit),
                    title: const Text('Editar comentario'),
                    onTap: () {
                      Navigator.pop(context);
                      showBottomMenuSheetAddOrEditComment(
                        context,
                        auth,
                        widget.comment.id,
                        idHomework: widget.idHomework,
                        editable: true,
                        currentEditing: widget.comment.content,
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.delete),
                    title: const Text('Eliminar'),
                    onTap: () async {
                      Navigator.pop(context);
                      showConfirmDialog(
                        context,
                        'Eliminar comentario',
                        '¿Estás seguro de eliminar este comentario?',
                        () =>
                            homeworkBloc.deleteComment(comment.id, idHomework),
                      );
                    },
                  ),
                ],
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.flag),
                    title: const Text('Denunciar comentario'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
      },
    );
  }
}
